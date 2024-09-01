import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7049834143174787/6493902064';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7049834143174787/7826359131';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
}
//--- Call like this ----
//_bannerAd = BannerAd(
//adUnitId: AdHelper.bannerAdUnitId,