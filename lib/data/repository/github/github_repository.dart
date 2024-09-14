import '../../model/composite/user_ad_datamodel.dart';
import '../../model/github/github_repository_datamodel.dart';

abstract class GithubRepository {
  Future<UserAdDataModel> getUsersWithAds(int page);

  Future<List<GithubRepositoryDataModel>> getUserRepos(
      int page, String username);

  Future<void> clearUserAdCache();

  Future<void> clearUserRepoCache(String username);
}
