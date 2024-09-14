import '../ad/ad_datamodel.dart';
import '../github/github_user_datamodel.dart';

class UserAdDataModel {
  static const String _defaultAdBannerUrl =
      'https://via.placeholder.com/500x100?text=Ad';
  static const String _defaultAdClickUrl = 'https://taxrefundgo.kr';

  final List<GithubUserDataModel> userDataModels;
  final AdDataModel adDataModel;

  UserAdDataModel({required this.userDataModels, required this.adDataModel});

  // User 리스트와 광고를 별도로 보내주는 가상 서버 데이터
  factory UserAdDataModel.fromJson(dynamic data) {
    final userDataModels = (data as List)
        .map((user) => GithubUserDataModel.fromJson(user))
        .toList();

    final adDataModel = AdDataModel(
        adBannerUrl: _defaultAdBannerUrl, linkUrl: _defaultAdClickUrl);

    return UserAdDataModel(
        userDataModels: userDataModels, adDataModel: adDataModel);
  }
}
