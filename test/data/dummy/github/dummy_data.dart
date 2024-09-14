import 'package:github_sample/data/model/ad/ad_datamodel.dart';
import 'package:github_sample/data/model/github/github_repository_datamodel.dart';
import 'package:github_sample/data/model/github/github_user_datamodel.dart';

class DummyData {
  static const testPage = 1;
  static const testUsername = 'testuser';

  static final testUsers = List.generate(
    100,
        (index) => GithubUserDataModel(
      login: 'testuser$index',
      avatarUrl: 'https://avatar.url/$index',
    ),
  );

  static final testRepos = List.generate(
    100,
        (index) => GithubRepositoryDataModel(
      name: 'repo$index',
      fullName: 'user/repo$index',
      htmlUrl: 'https://repo$index.com',
      description: 'Test repo $index',
      language: 'Dart',
      stargazersCount: 100 + index,
      username: testUsername,
    ),
  );

  static final testAd = AdDataModel(
    adBannerUrl: 'https://placehold.it/500x100?text=ad',
    linkUrl: 'https://taxrefundgo.kr',
  );
}
