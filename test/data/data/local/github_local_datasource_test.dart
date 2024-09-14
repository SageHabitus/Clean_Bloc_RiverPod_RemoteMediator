import 'package:github_sample/data/model/github/github_user_datamodel.dart';
import 'package:github_sample/data/source/local/db/database_helper.dart';
import 'package:github_sample/data/source/local/github_local_datasource.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:test/test.dart';

import '../../dummy/github/dummy_data.dart';

void main() {
  late GithubLocalDataSource localDataSource;
  late DatabaseHelper databaseHelper;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    databaseHelper = DatabaseHelper();
    localDataSource = GithubLocalDataSource(databaseHelper);

    final db = await databaseHelper.database;
    await databaseHelper.createTestDb(db, 1);
  });

  test('유저 데이터를 캐싱하고 불러오는지 테스트', () async {
    final testUser =
        GithubUserDataModel(login: DummyData.testUsers[0].login, avatarUrl: DummyData.testUsers[0].avatarUrl);

    await localDataSource.cacheUsers([testUser]);

    final cachedData = await localDataSource.queryCachedUserWithAds(0, 1);
    expect(cachedData.userDataModels.isNotEmpty, true);
    expect(cachedData.userDataModels.first.login, DummyData.testUsers[0].login);
  });

  test('저장소 데이터를 캐싱하고 불러오는지 테스트', () async {

    await localDataSource.cacheUserRepos(DummyData.testUsername,DummyData.testRepos);

    final cachedRepos =
        await localDataSource.queryPagedCachedUserRepos(DummyData.testUsername, 0, 1);
    expect(cachedRepos.isNotEmpty, true);
    expect(cachedRepos.first.name, DummyData.testRepos[0].name);
  });

  test('광고 데이터를 캐싱하고 불러오는지 테스트', () async {
    await localDataSource.cacheAd(DummyData.testAd);

    final cachedAd = await localDataSource.queryCachedUserWithAds(0, 1);
    expect(cachedAd.adDataModel.adBannerUrl, DummyData.testAd.adBannerUrl);
  });

  tearDown(() async {
    await databaseHelper.clearTables();
  });
}
