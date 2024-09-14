import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../bloc/repo_list_bloc.dart';
import '../bloc/repo_list_event.dart';
import '../bloc/repo_list_provider.dart';
import '../bloc/repo_list_state.dart';
import '../widget/repo_list.dart';

class RepoListScreen extends ConsumerStatefulWidget {
  const RepoListScreen({super.key});

  @override
  ConsumerState<RepoListScreen> createState() => _RepoListScreenState();
}

class _RepoListScreenState extends ConsumerState<RepoListScreen> {
  late RepoListBloc _repoListBloc;
  final ScrollController _scrollController = ScrollController();
  late String username;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      username = ModalRoute.of(context)!.settings.arguments as String;
      _repoListBloc = ref.read(repoListBlocProvider(username));
      _isInitialized = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _repoListBloc.add(FetchMoreRepos(username));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _repoListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _repoListBloc.add(RefreshRepos(username));
        },
        child: BlocBuilder<RepoListBloc, RepoListState>(
          bloc: _repoListBloc,
          builder: (context, state) {
            if (state is Loading && state is! Success) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is Success) {
              return RepoList(
                repos: state.repos,
                scrollController: _scrollController,
              );
            } else if (state is Error) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
