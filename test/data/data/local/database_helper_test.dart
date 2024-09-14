import 'package:github_sample/data/source/local/db/database_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:test/test.dart';

void main() {
  late DatabaseHelper databaseHelper;
  late Database database;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    databaseHelper = DatabaseHelper();
    database = await databaseFactory.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await databaseHelper.createTestDb(db, version);
        },
      ),
    );
  });

  test('DB 초기화 및 테이블 생성 확인', () async {
    final tables = await database
        .rawQuery("SELECT name FROM sqlite_master WHERE type='table'");

    expect(tables.any((table) => table['name'] == 'users'), isTrue);
    expect(tables.any((table) => table['name'] == 'repositories'), isTrue);
    expect(tables.any((table) => table['name'] == 'ads'), isTrue);
  });

  test('유저 테이블 데이터 삽입 및 조회', () async {
    await database.insert('users', {
      'login': 'testuser1',
      'avatar_url': 'avatar_url1',
    });

    // 삽입된 데이터 조회
    final users = await database.query('users');
    expect(users.length, 1);
    expect(users[0]['login'], 'testuser1');
  });

  test('레포지토리 테이블 데이터 삽입 및 조회', () async {
    await database.insert('repositories', {
      'name': 'repo1',
      'full_name': 'testuser/repo1',
      'html_url': 'https://repo1.com',
      'description': 'Test repo 1',
      'language': 'Dart',
      'stargazers_count': 100,
      'username': 'testuser1',
    });

    final repos = await database.query('repositories');
    expect(repos.length, 1);
    expect(repos[0]['name'], 'repo1');
  });

  tearDown(() async {
    await databaseHelper.clearTables();
  });

  tearDownAll(() async {
    await databaseHelper.closeDatabase();
  });
}
