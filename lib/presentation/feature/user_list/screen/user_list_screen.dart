import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../resource/alert_message.dart';
import '../bloc/user_list_bloc.dart';
import '../bloc/user_list_event.dart';
import '../bloc/user_list_provider.dart';
import '../bloc/user_list_state.dart';
import '../widget/user_list.dart';

class UserListScreen extends ConsumerStatefulWidget {
  const UserListScreen({super.key});

  @override
  ConsumerState<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  late UserListBloc _userListBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _userListBloc = ref.read(userListBlocProvider);

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _userListBloc.add(FetchUsers());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _userListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AlertMessage.appTitle)),
      body: RefreshIndicator(
        onRefresh: () async {
          _userListBloc.add(RefreshUsers());
        },
        child: BlocBuilder<UserListBloc, UserListState>(
          bloc: _userListBloc,
          builder: (context, state) {
            if (state is Loading && state is! Success) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is Success) {
              return UserList(
                users: state.users,
                ad: state.ad,
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
