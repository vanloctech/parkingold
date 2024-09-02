import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/parkingether_localizations.dart';
import 'package:parkingold/providers/image_quality.provider.dart';
import 'package:parkingold/repositories/setting.repo.dart';
import 'package:parkingold/resources/colors.dart';
import 'package:parkingold/utils/constants.uti.dart';
import 'package:parkingold/utils/image_quality.util.dart';
import 'package:parkingold/utils/locale.util.dart';
import 'package:parkingold/utils/my_toast.util.dart';
import 'package:parkingold/utils/screen.util.dart';
import 'package:provider/provider.dart';
// import 'package:parkingold/providers/locale_provider.dart';

import '../../resources/dimens.dart';
import '../../resources/gaps.dart';

class ImageQualitySettingPage extends StatefulWidget {
  const ImageQualitySettingPage({Key? key}) : super(key: key);

  @override
  State<ImageQualitySettingPage> createState() =>
      _ImageQualitySettingPageState();
}

class _ImageQualitySettingPageState extends State<ImageQualitySettingPage> {

  @override
  Widget build(BuildContext context) {
    final List<String> list = ImageQualityHelper.maps(context).values.toList();
    final Map<String, String> mapQuality = ImageQualityHelper.maps(context);

    var app = MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ImageQualityProvider())],
      child: Consumer<ImageQualityProvider>(
        builder: (context, ImageQualityProvider imageQualityProvider, child) {
          // imageQualityProvider.getQuality();
          String mode = imageQualityProvider.mode;
          print('mode from provider $mode');
          
          return ListView.builder(
            itemCount: mapQuality.length,
            itemBuilder: (_, int index) {
              String key = mapQuality.keys.elementAt(index);
              return InkWell(
                onTap: () {
                  imageQualityProvider.createOrUpdate(mapQuality.keys.elementAt(index));
                  MyToast.show('Thành công');
                  setState(() {});
                },
                child: Container(
                  margin:
                  const EdgeInsets.only(bottom: Dimens.gap_dp15),
                  decoration: BoxDecoration(
                      border: mode == key
                          ? Border.all(
                          color: Colours.buttonColor, width: 2)
                          : const Border(),
                      color: Colours.white,
                      borderRadius:
                      BorderRadius.circular(Dimens.radius_25),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colours.grey.withOpacity(0.05),
                      //     spreadRadius: 5,
                      //     blurRadius: 5,
                      //     // changes position of shadow
                      //   ),
                      // ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: (context.width - 90) * 0.7,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list[index],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colours.mainFontColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Opacity(
                                opacity: mode == key ? 1 : 0,
                                child: const Icon(Icons.done,
                                    color: Colours.buttonColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colours.primary,
      appBar: AppBar(
        title: Text(
          'Chất lượng hình ảnh',
          style: const TextStyle(
            color: Colours.mainFontColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colours.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        leading: const BackButton(
          color: Colours.mainFontColor,
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(Dimens.gap_dp20),
          child: app,
        ),
      ),
    );
  }

  void _updateQuality(BuildContext context, value) async {
    SettingRepository repository = SettingRepository();

    await repository.createOrUpdate(Constant.imageQuality, value);

    MyToast.show('Thành công');
  }
}
