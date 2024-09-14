import '../../../../data/model/github/github_repository_datamodel.dart';

class RepoItemState {
  final String name;
  final String description;
  final int starCount;
  final String language;

  RepoItemState({
    required this.name,
    required this.description,
    required this.starCount,
    required this.language,
  });

  factory RepoItemState.toState(GithubRepositoryDataModel repo) {
    return RepoItemState(
      name: repo.name,
      description: repo.description ?? '',
      starCount: repo.stargazersCount ?? 0,
      language: repo.language ?? 'Unknown',
    );
  }
}
