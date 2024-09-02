// import 'package:flustars_flutter3/flustars_flutter3.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_gen/gen_l10n/parkingether_localizations.dart';
// import 'constants.uti.dart';
//
// class LocaleHelper {
//   static List<String> localeList(BuildContext context) {
//     return <String>[
//       ParkingetherLocalizations.of(context)!.system,
//       ParkingetherLocalizations.of(context)!.vietnamese,
//       ParkingetherLocalizations.of(context)!.english,
//     ];
//   }
//
//   static String localMode(BuildContext context) {
//     final List<String> list = localeList(context);
//
//     final String? locale = SpUtil.getString(Constant.locale);
//     // final box = GetStorage();
//     // final String locale = box.read(Constant.locale);
//
//     String localeMode;
//     switch (locale) {
//       case 'vi':
//         localeMode = list[1];
//         break;
//       case 'en':
//         localeMode = list[2];
//         break;
//       default:
//         localeMode = list[0];
//         break;
//     }
//
//     return localeMode;
//   }
// }