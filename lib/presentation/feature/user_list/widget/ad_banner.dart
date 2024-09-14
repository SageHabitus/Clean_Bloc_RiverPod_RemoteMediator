import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/ad_item_state.dart';

class AdBanner extends StatelessWidget {
  final AdItemState ads;

  const AdBanner({super.key, required this.ads});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final uri = ads.linkUri;
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch $uri';
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        height: 100,
        child: Image.network(
          ads.bannerUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, exception, stackTrace) {
            return Image.asset(
              'assets/images/placeholder.jpg',
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
