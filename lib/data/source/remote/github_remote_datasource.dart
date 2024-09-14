import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../constants/app_url.dart';
import '../../exception/exception_message.dart';
import '../../model/composite/user_ad_datamodel.dart';
import '../../model/github/github_repository_datamodel.dart';

class GithubRemoteDataSource {
  final Dio _dio;

  GithubRemoteDataSource(this._dio);

  Future<UserAdDataModel> getUsersWithAds(int since, int pageSize) async {
    try {
      final response = await _dio.get(
        AppUrl.userEndpoint(),
        queryParameters: {'since': since, 'per_page': pageSize},
      );
      return UserAdDataModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            '${ExceptionMessage.apiExceptionMessage}: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        throw Exception(
            '${ExceptionMessage.networkExceptionMessage}: ${e.message}');
      }
    } catch (e) {
      throw Exception(
          '${ExceptionMessage.unexpectedFetchUserExceptionMessage}: $e');
    }
  }

  Future<List<GithubRepositoryDataModel>> getUserRepos(
      String username, int page, int perPage) async {
    try {
      final response = await _dio.get(
        AppUrl.userReposEndpoint(username),
        queryParameters: {
          'per_page': perPage,
          'page': page,
        },
      );
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((repo) => GithubRepositoryDataModel.fromJson(repo))
            .toList();
      } else {
        throw Exception(
            '${ExceptionMessage.failedToLoadRepositories}: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('${ExceptionMessage.failedToFetchRepositories}: $e');
    }
  }
}
