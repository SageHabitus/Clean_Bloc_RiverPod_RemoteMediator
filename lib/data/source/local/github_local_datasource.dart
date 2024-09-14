import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../constants/data_constants.dart';
import '../../exception/exception_message.dart';
import '../../model/ad/ad_datamodel.dart';
import '../../model/composite/user_ad_datamodel.dart';
import '../../model/github/github_repository_datamodel.dart';
import '../../model/github/github_user_datamodel.dart';
import 'db/database_helper.dart';

class GithubLocalDataSource {
  final DatabaseHelper databaseHelper;

  GithubLocalDataSource(this.databaseHelper);

  Future<UserAdDataModel> queryCachedUserWithAds(int offset, int limit) async {
    try {
      final db = await databaseHelper.database;

      final List<Map<String, dynamic>> userMaps = await db
          .query(DataConstants.usersTable, limit: limit, offset: offset);

      final users = userMaps.isNotEmpty
          ? userMaps.map((user) => GithubUserDataModel.fromJson(user)).toList()
          : <GithubUserDataModel>[];

      final adMap = await db.query(DataConstants.adsTable, limit: 1);
      final ad = adMap.isNotEmpty
          ? AdDataModel.fromJson(adMap.first)
          : AdDataModel(adBannerUrl: '', linkUrl: '');

      return UserAdDataModel(userDataModels: users, adDataModel: ad);
    } catch (e) {
      throw Exception('${ExceptionMessage.failedToFetchCachedUsers}: $e');
    }
  }

  Future<void> cacheUsers(List<GithubUserDataModel> users) async {
    try {
      final db = await databaseHelper.database;
      final batch = db.batch();
      for (var user in users) {
        batch.insert(DataConstants.usersTable, user.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
    } catch (e) {
      throw Exception('Error caching users: $e');
    }
  }

  Future<List<GithubRepositoryDataModel>> queryPagedCachedUserRepos(
      String username, int offset, int limit) async {
    try {
      final db = await databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DataConstants.repositoriesTable,
        where: '${DataConstants.usernameField} = ?',
        whereArgs: [username],
        limit: limit,
        offset: offset,
      );

      debugPrint('Query result for $username: $maps');

      if (maps.isEmpty) {
        debugPrint('No data found for $username');
        return [];
      }

      return maps
          .map((repo) => GithubRepositoryDataModel.fromJson(repo))
          .toList();
    } catch (e) {
      debugPrint('Error querying cached repos: $e');
      throw Exception(
          '${ExceptionMessage.databaseRepoFetchExceptionMessage}: $e');
    }
  }


  Future<void> cacheUserRepos(
      String username, List<GithubRepositoryDataModel> repos) async {
    try {
      final db = await databaseHelper.database;
      final batch = db.batch();
      for (var repo in repos) {
        final repoJson = repo.toJson();
        repoJson[DataConstants.usernameField] = username;
        batch.insert(DataConstants.repositoriesTable, repoJson,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
    } catch (e) {
      throw Exception(
          '${ExceptionMessage.databaseCacheRepoExceptionMessage}: $e');
    }
  }

  Future<void> cacheAd(AdDataModel adDataModel) async {
    try {
      final db = await databaseHelper.database;
      await db.insert(DataConstants.adsTable, adDataModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      throw Exception('Error caching ad: $e');
    }
  }

  Future<void> clearUserAdCache() async {
    final db = await databaseHelper.database;
    await db.delete(DataConstants.usersTable);
    await db.delete(DataConstants.adsTable);
  }

  Future<void> clearUserRepoCache(String username) async {
    try {
      final db = await databaseHelper.database;
      await db.delete(DataConstants.repositoriesTable,
          where: '${DataConstants.usernameField} = ?', whereArgs: [username]);
    } catch (e) {
      throw Exception(
          '${ExceptionMessage.databaseClearRepoExceptionMessage}: $e');
    }
  }
}
