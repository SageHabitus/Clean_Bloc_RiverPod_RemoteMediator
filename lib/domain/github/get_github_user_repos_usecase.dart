import '../../data/model/github/github_repository_datamodel.dart';
import '../../data/repository/github/github_repository.dart';
import '../usecase.dart';

class GetUserReposUseCase
    implements UseCase<List<GithubRepositoryDataModel>, Params> {
  final GithubRepository repository;

  GetUserReposUseCase(this.repository);

  @override
  Future<List<GithubRepositoryDataModel>> call(Params params) async {
    return await repository.getUserRepos(params.page,params.username);
  }
}

class Params {
  final int page;
  final String username;

  Params({required this.page, required this.username});
}
