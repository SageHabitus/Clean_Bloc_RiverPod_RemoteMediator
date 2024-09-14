import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_sample/presentation/feature/repo_list/bloc/repo_list_event.dart';
import '../../../../di/usecase_provider.dart';
import 'repo_list_bloc.dart';

final repoListBlocProvider =
    Provider.family<RepoListBloc, String>((ref, username) {
  final getUserReposUseCase = ref.read(getUserReposUseCaseProvider);
  final bloc = RepoListBloc(getUserReposUseCase: getUserReposUseCase);
  bloc.add(FetchRepos(username));
  return bloc;
});
