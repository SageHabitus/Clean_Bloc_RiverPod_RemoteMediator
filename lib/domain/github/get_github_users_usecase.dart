import '../../data/model/composite/user_ad_datamodel.dart';
import '../../data/repository/github/github_repository.dart';
import '../usecase.dart';

class GetUsersUseCase implements UseCase<UserAdDataModel, Params> {
  final GithubRepository repository;

  GetUsersUseCase(this.repository);

  @override
  Future<UserAdDataModel> call(Params params) async {
    return await repository.getUsersWithAds(params.page);
  }
}

class Params {
  final int page;

  Params({required this.page});
}
