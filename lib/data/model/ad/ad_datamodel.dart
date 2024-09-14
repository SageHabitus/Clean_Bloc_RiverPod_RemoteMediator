class AdDataModel {
  final String adBannerUrl;
  final String linkUrl;

  AdDataModel({required this.adBannerUrl, required this.linkUrl});

  factory AdDataModel.fromJson(Map<String, dynamic> json) {
    return AdDataModel(
      adBannerUrl: json['ad_banner_url'] ?? '',
      linkUrl: json['link_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ad_banner_url': adBannerUrl,
      'link_url': linkUrl,
    };
  }
}