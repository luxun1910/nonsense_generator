import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nonsense_generator/ad/banner_ad_model.dart';
import 'package:provider/provider.dart';

/// バナー広告ページ
class BannerAdPage extends StatelessWidget {
  const BannerAdPage({super.key});

  @override
  Widget build(BuildContext context) {
    BannerAd? bannerAd;

    if (Platform.isAndroid || Platform.isIOS) {
      context.read<BannerAdModel>().loadBannerAd();
      bannerAd = context.watch<BannerAdModel>().bannerAd;
    }

    return bannerAd == null
        ? const SizedBox()
        : SizedBox(
            width: bannerAd.size.width.toDouble(),
            height: bannerAd.size.height.toDouble(),
            child: AdWidget(
              ad: bannerAd,
            ),
          );
  }
}
