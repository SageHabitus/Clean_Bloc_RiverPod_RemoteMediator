import '../../../../data/model/ad/ad_datamodel.dart';

class AdItemState {
  final String bannerUrl;
  final Uri linkUri;

  AdItemState({
    required this.bannerUrl,
    required this.linkUri,
  });

  factory AdItemState.toState(AdDataModel ad) {
    return AdItemState(
      bannerUrl: ad.adBannerUrl,
      linkUri: Uri.parse(ad.linkUrl),
    );
  }
}
