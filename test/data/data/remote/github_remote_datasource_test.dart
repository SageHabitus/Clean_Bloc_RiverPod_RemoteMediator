import 'package:dio/dio.dart';
import 'package:github_sample/data/source/remote/github_remote_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'github_remote_datasource_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late GithubRemoteDataSource remoteDataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    remoteDataSource = GithubRemoteDataSource(mockDio);
  });

  group('GithubRemoteDataSource 테스트', () {
    const testPage = 1;
    const testPerPage = 30;

    // Test getUsersWithAds
    test('getUsersWithAds 함수가 성공적으로 UserAdDataModel을 반환하는지 테스트', () async {
      final mockResponse = Response(
        data: [
          {'login': 'testuser1', 'avatar_url': 'avatar_url1'},
          {'login': 'testuser2', 'avatar_url': 'avatar_url2'},
        ],
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => mockResponse);

      final result =
          await remoteDataSource.getUsersWithAds(testPage, testPerPage);

      expect(result.userDataModels.length, 2);
      expect(result.userDataModels.first.login, 'testuser1');
    });

    // Test getUserRepos
    test('getUserRepos 함수가 성공적으로 List<GithubRepositoryDataModel>을 반환하는지 테스트',
        () async {
      final mockResponse = Response(
        data: [
          {
            'name': 'repo1',
            'full_name': 'user/repo1',
            'html_url': 'https://repo1.com',
            'description': 'Test repo 1',
            'language': 'Dart',
            'stargazers_count': 100,
            'owner': {'login': 'testuser'}
          }
        ],
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => mockResponse);

      final result = await remoteDataSource.getUserRepos(
          'testuser', testPage, testPerPage);

      expect(result.length, 1);
      expect(result.first.name, 'repo1');
    });
  });
}
