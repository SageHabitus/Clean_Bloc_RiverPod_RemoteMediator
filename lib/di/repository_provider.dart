import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repository/github/github_repository.dart';
import '../data/repository/github/github_repository_impl.dart';
import 'datasource_provider.dart';

final githubRepositoryProvider = Provider<GithubRepository>((ref) {
  return GithubRepositoryImpl(
    ref.read(remoteDataSourceProvider),
    ref.read(localDataSourceProvider),
  );
});
