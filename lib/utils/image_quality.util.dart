import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:flutter/cupertino.dart';
import 'package:parkingold/repositories/setting.repo.dart';
import 'constants.uti.dart';

class ImageQualityHelper {
  static Map<String, String> maps(BuildContext context) {
    return {
      'low': 'Thấp - 480p',
      'medium': 'Trung bình - 720p',
      'high': 'Cao - 1080p',
      'very_high': 'Rất cao - 2160p',
      'ultra_high': 'Cực cao',
    };
  }

  static List<String> lists(BuildContext context) {
    return <String>[
      'Thấp - 480p',
      'Trung bình - 720p',
      'Cao - 1080p',
      'Rất cao - 2160p',
      'Cực cao',
    ];
  }

  static Future<String> mode(BuildContext context) async {
    final List<String> list = maps(context).values.toList();
    SettingRepository settingRepository = SettingRepository();
    final quality = await settingRepository.getByKey(Constant.imageQuality);

    if (quality != null) {
      return quality.value ?? 'medium';
    } else {
      return 'medium';
    }

    // return quality?.value;
    final String? locale = SpUtil.getString(Constant.locale);
    // final box = GetStorage();
    // final String locale = box.read(Constant.locale);

    String localeMode;
    switch (locale) {
      case 'vi':
        localeMode = list[1];
        break;
      case 'en':
        localeMode = list[2];
        break;
      default:
        localeMode = list[0];
        break;
    }

    return localeMode;
  }
}