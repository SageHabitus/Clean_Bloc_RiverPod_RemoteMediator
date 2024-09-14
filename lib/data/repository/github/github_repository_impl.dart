import 'package:flutter/foundation.dart';
import '../../exception/exception_message.dart';
import '../../model/composite/user_ad_datamodel.dart';
import '../../model/github/github_repository_datamodel.dart';
import '../../source/local/github_local_datasource.dart';
import '../../source/remote/github_remote_datasource.dart';
import 'github_repository.dart';

class GithubRepositoryImpl implements GithubRepository {
  final GithubRemoteDataSource remoteDataSource;
  final GithubLocalDataSource localDataSource;
  static const int pageSize = 20;

  GithubRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<UserAdDataModel> getUsersWithAds(int page) async {
    try {
      debugPrint("Requesting page: $page");
      final offset = (page - 1) * pageSize;

      final cachedData =
      await localDataSource.queryCachedUserWithAds(offset, pageSize);

      if (cachedData.userDataModels.isNotEmpty) {
        return cachedData;
      }

      final since = page * pageSize;
      final usersWithAds =
      await remoteDataSource.getUsersWithAds(since, pageSize);

      await localDataSource.cacheUsers(usersWithAds.userDataModels);
      await localDataSource.cacheAd(usersWithAds.adDataModel);

      return usersWithAds;
    } catch (e) {
      throw Exception(ExceptionMessage.failedToFetchCachedUsers);
    }
  }

  @override
  Future<List<GithubRepositoryDataModel>> getUserRepos(
      int page, String username) async {
    try {

      final cachedRepos = await localDataSource.queryPagedCachedUserRepos(
          username, (page - 1) * pageSize, pageSize);

      if (cachedRepos.isNotEmpty) {
        return cachedRepos;
      }

      final remoteRepos =
      await remoteDataSource.getUserRepos(username, page, pageSize);

      if (remoteRepos.isNotEmpty) {
        await localDataSource.cacheUserRepos(username, remoteRepos);
      }

      return remoteRepos;
    } catch (e) {
      throw Exception(ExceptionMessage.failedToFetchRepositories);
    }
  }


  Future<void> clearUserAdCache() async {
    await localDataSource.clearUserAdCache();
  }

  Future<void> clearUserRepoCache(String username) async {
    await localDataSource.clearUserRepoCache(username);
  }
}