class AppUrl {
  static const String baseUrl = 'https://api.github.com';
  static const String users = 'users';
  static const String repos = 'repos';

  static String userEndpoint() => '$baseUrl/$users';

  static String userReposEndpoint(String username) => '$baseUrl/$users/$username/$repos';
}