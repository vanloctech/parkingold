import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:parkingold/pages/home.page.dart';
// import 'package:flutter_gen/gen_l10n/parkingether_localizations.dart';
import 'package:parkingold/providers/locale_provider.dart';
import 'package:parkingold/resources/colors.dart';
import 'package:parkingold/resources/dimens.dart';
import 'package:provider/provider.dart';

import 'providers/image_quality.provider.dart';

Future<void> main() async {
  await GetStorage.init();
  await SpUtil.getInstance();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());

  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //     overlays: [SystemUiOverlay.bottom]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget app = _buildMaterialApp(context);

    return OKToast(
      backgroundColor: Colours.buttonColor,
      textPadding: const EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp16, vertical: Dimens.gap_dp10),
      radius: Dimens.radius_20,
      position: ToastPosition.bottom,
      child: app,
    );
  }

  Widget _buildMaterialApp(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImageQualityProvider(),
      child: MaterialApp(
        title: 'Parkingold - giữ xe',
        // localizationsDelegates: ParkingetherLocalizations.localizationsDelegates,
        // supportedLocales: ParkingetherLocalizations.supportedLocales,
        // locale: localeProvider.locale,
        theme: ThemeData(
          fontFamily: GoogleFonts.montserrat().fontFamily,
          // primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
