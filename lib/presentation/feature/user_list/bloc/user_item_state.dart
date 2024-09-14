import '../../../../data/model/github/github_user_datamodel.dart';

class UserItemState {
  final String name;
  final String profileUrl;

  UserItemState({
    required this.name,
    required this.profileUrl,
  });

  factory UserItemState.toState(GithubUserDataModel user) {
    return UserItemState(
      name: user.login,
      profileUrl: user.avatarUrl,
    );
  }
}