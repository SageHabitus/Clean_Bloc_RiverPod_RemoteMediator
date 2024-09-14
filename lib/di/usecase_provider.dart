import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/github/get_github_user_repos_usecase.dart';
import '../domain/github/get_github_users_usecase.dart';
import 'repository_provider.dart';

final getUsersUseCaseProvider = Provider<GetUsersUseCase>((ref) {
  return GetUsersUseCase(ref.read(githubRepositoryProvider));
});

final getUserReposUseCaseProvider = Provider<GetUserReposUseCase>((ref) {
  return GetUserReposUseCase(ref.read(githubRepositoryProvider));
});
