class GithubRepositoryDataModel {
  final String name;
  final String fullName;
  final String htmlUrl;
  final String? description;
  final String? language;
  final int stargazersCount;
  final String username;

  GithubRepositoryDataModel({
    required this.name,
    required this.fullName,
    required this.htmlUrl,
    this.description,
    this.language,
    required this.stargazersCount,
    required this.username,
  });

  factory GithubRepositoryDataModel.fromJson(Map<String, dynamic> json) {
    try {
      return GithubRepositoryDataModel(
        name: json['name'],
        fullName: json['full_name'],
        htmlUrl: json['html_url'],
        description: json['description'],
        language: json['language'],
        stargazersCount: json['stargazers_count'],
        username: json['owner'] != null ? json['owner']['login'] : 'unknown',
      );
    } catch (e) {
      throw Exception('Failed to parse repository data: $e');
    }
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'full_name': fullName,
      'html_url': htmlUrl,
      'description': description,
      'language': language,
      'stargazers_count': stargazersCount,
      'username': username,
    };
  }
}
