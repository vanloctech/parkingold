import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parkingold/utils/constants.uti.dart';

class LocaleProvider extends ChangeNotifier {

  Locale? get locale {
    final String? locale =  SpUtil.getString(Constant.locale);
    // final box = GetStorage();
    // String locale = box.read(Constant.locale);
    switch (locale) {
      case 'en':
        return const Locale('en', 'US');
      case 'vi':
        return const Locale('vi', 'VN');
      default:
        return null;
    }
  }

  void setLocale(String locale) {
    // final box = GetStorage();
    // box.write(Constant.locale, locale);
    SpUtil.putString(Constant.locale, locale);

    notifyListeners();
  }

}
