class GithubUserDataModel {
  final String login;
  final String avatarUrl;

  GithubUserDataModel({required this.login, required this.avatarUrl});

  factory GithubUserDataModel.fromJson(Map<String, dynamic> json) {
    return GithubUserDataModel(
      login: json['login'],
      avatarUrl: json['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'avatar_url': avatarUrl,
    };
  }
}