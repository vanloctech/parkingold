import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

class Lang {
  Future<String> getLocale(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? locale = prefs.getString('locale');

    if (locale == null) {
      String languageCode = Platform.localeName.split('_')[0];
      String countryCode = Platform.localeName.split('_')[1];
      print(languageCode);
      print(countryCode);
      await prefs.setString('locale', languageCode);
      locale = languageCode;
    }

    return locale;
  }

  Future<String> trans(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? locale = prefs.getString('locale');

    if (locale == null) {
      String languageCode = Platform.localeName.split('_')[0];
      String countryCode = Platform.localeName.split('_')[1];
      print(languageCode);
      print(countryCode);
      await prefs.setString('locale', languageCode);
      locale = languageCode;
    }

    print("This is test function");
    return Future(() => someMap[locale][key]);
  }

  static Object vi() {
    return {
      'setting': 'Cafi dat',
      'user': 'Nguoi dung',
    };
  }

  static Object en() {
    return {
      'setting': 'Settings',
      'user': 'User',
    };
  }

  final Map<String, dynamic> someMap = {
    'en': {
      'setting': 'Settings',
      'user': 'User',
    },
    'vi': {
      'setting': 'Cafi dat',
      'user': 'Nguoi dung',
    },
  };

  Object lang() {
    return {
      'en': {
        'setting': 'Settings',
        'user': 'User',
      },
      'vi': {
        'setting': 'Cafi dat',
        'user': 'Nguoi dung',
      },
    };
  }
}
