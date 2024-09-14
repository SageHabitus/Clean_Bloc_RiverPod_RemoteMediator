import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/source/local/db/database_helper.dart';
import '../data/source/local/github_local_datasource.dart';
import '../data/source/remote/github_remote_datasource.dart';
import 'dio_provider.dart';

final remoteDataSourceProvider = Provider<GithubRemoteDataSource>((ref) {
  return GithubRemoteDataSource(ref.read(dioProvider));
});

final localDataSourceProvider = Provider<GithubLocalDataSource>((ref) {
  return GithubLocalDataSource(DatabaseHelper());
});
