// import 'package:flutter/material.dart';
// // import 'package:flutter_gen/gen_l10n/parkingether_localizations.dart';
// import 'package:parkingold/resources/colors.dart';
// import 'package:parkingold/utils/locale.util.dart';
// import 'package:parkingold/utils/my_toast.util.dart';
// import 'package:parkingold/utils/screen.util.dart';
// import 'package:provider/provider.dart';
// import 'package:parkingold/providers/locale_provider.dart';
//
// import '../../resources/dimens.dart';
// import '../../resources/gaps.dart';
//
// class LocaleSettingPage extends StatefulWidget {
//   const LocaleSettingPage({Key? key}) : super(key: key);
//
//   @override
//   State<LocaleSettingPage> createState() => _LocaleSettingPageState();
// }
//
// class _LocaleSettingPageState extends State<LocaleSettingPage> {
//   @override
//   Widget build(BuildContext context) {
//     final List<String> list = LocaleHelper.localeList(context);
//     final String localeMode = LocaleHelper.localMode(context);
//
//     return Scaffold(
//       backgroundColor: Colours.primary,
//       appBar: AppBar(
//         title: Text(
//           ParkingetherLocalizations.of(context)!.language,
//           style: const TextStyle(
//             color: Colours.mainFontColor,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colours.transparent,
//         shadowColor: Colors.transparent,
//         centerTitle: true,
//         leading: const BackButton(
//           color: Colours.mainFontColor, // <-- SEE HERE
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           margin: const EdgeInsets.all(Dimens.gap_dp20),
//           child: ListView.builder(
//             itemCount: list.length,
//             itemBuilder: (_, int index) {
//               return InkWell(
//                 onTap: () {
//                   final String locale =
//                       index == 0 ? '' : (index == 1 ? 'vi' : 'en');
//                   context.read<LocaleProvider>().setLocale(locale);
//                   // MyToast.show(ParkingetherLocalizations.of(context)!.success);
//                   setState(() {});
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.only(bottom: Dimens.gap_dp15),
//                   decoration: BoxDecoration(
//                       border: localeMode == list[index]
//                           ? Border.all(color: Colours.buttonColor, width: 2)
//                           : const Border(),
//                       color: Colours.white,
//                       borderRadius: BorderRadius.circular(Dimens.radius_25),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colours.grey.withOpacity(0.05),
//                           spreadRadius: 5,
//                           blurRadius: 5,
//                           // changes position of shadow
//                         ),
//                       ]),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             width: (context.width - 90) * 0.7,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   list[index],
//                                   style: const TextStyle(
//                                       fontSize: 15,
//                                       color: Colours.mainFontColor,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Opacity(
//                                 opacity: localeMode == list[index] ? 1 : 0,
//                                 child: const Icon(Icons.done,
//                                     color: Colours.buttonColor),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
