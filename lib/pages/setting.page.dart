import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkingold/pages/settings/image_quality_setting.page.dart';

// import 'package:parkingold/pages/settings/locale_setting.page.dart';
import 'package:parkingold/resources/dimens.dart';
import 'package:parkingold/resources/gaps.dart';
import 'package:parkingold/utils/image_quality.util.dart';

// import 'package:parkingold/utils/locale.util.dart';
import 'package:parkingold/utils/screen.util.dart';
import 'package:parkingold/widgets/card_setting.widget.dart';
import 'package:parkingold/widgets/item_avatar_info.widget.dart';
import 'package:parkingold/resources/colors.dart';
import 'package:provider/provider.dart';

import '../providers/image_quality.provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    // final String localeMode = LocaleHelper.localMode(context);
    final Map<String, String> listImageQuality = ImageQualityHelper.maps(context);

    return Scaffold(
      backgroundColor: Colours.primary,
      appBar: AppBar(
        title: Text(
          'Cài đặt',
          style: const TextStyle(
            color: Colours.mainFontColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colours.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        leading: const BackButton(
          color: Colours.mainFontColor, // <-- SEE HERE
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 0,
                ),
                decoration: BoxDecoration(
                    color: Colours.white,
                    borderRadius: BorderRadius.circular(Dimens.radius_25),
                    boxShadow: [
                      BoxShadow(
                        color: Colours.grey.withOpacity(0.03),
                        spreadRadius: 10,
                        blurRadius: 3,
                        // changes position of shadow
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.gap_dp20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.edit,
                            color: Colours.mainFontColor,
                          )
                        ],
                      ),
                      Gaps.vGap15,
                      Column(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://images.unsplash.com/photo-1531256456869-ce942a665e80?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTI4fHxwcm9maWxlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
                                    fit: BoxFit.cover)),
                          ),
                          Gaps.vGap10,
                          Container(
                            width: (context.width - 40) * 0.6,
                            child: Column(
                              children: [
                                Text(
                                  "Lộc Nguyễn",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colours.mainFontColor),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Giữ xe hiện đại",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colours.black),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Gaps.vGap32,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ItemAvatarInfo(title: 'Thẻ xe tối đa', value: '50'),
                          Container(
                            width: 0.5,
                            height: 40,
                            color: Colours.black.withOpacity(0.3),
                          ),
                          ItemAvatarInfo(title: 'Thẻ đã sử dụng', value: '30'),
                          Container(
                            width: 0.5,
                            height: 40,
                            color: Colours.black.withOpacity(0.3),
                          ),
                          ItemAvatarInfo(title: 'Thẻ còn lại', value: '20'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  children: [
                    CardSetting(
                      icon: Icons.credit_card_outlined,
                      title: 'Gói hiện tại',
                      desc: 'Miễn phí',
                    ),
                    CardSetting(
                      icon: Icons.attach_money_outlined,
                      title: 'Phí giữ xe',
                      desc: '2,000đ/lượt',
                    ),
                    // ChangeNotifierProvider(
                    //   create: (context) => ImageQualityProvider(),
                    //   child: 
                      Consumer<ImageQualityProvider>(
                        builder: (context, imageQuality, child) {
                          print('ben ngoai ' + imageQuality.mode);
                          print('re-render');
                          return CardSetting(
                            icon: Icons.hd_outlined,
                            title: 'Chất lượng hình ảnh',
                            desc: listImageQuality[imageQuality.mode],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ImageQualitySettingPage(),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    // ),
                    // CardSetting(
                    //   icon: Icons.language_outlined,
                    //   title: 'Ngôn ngữ',
                    //   desc: localeMode,
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const LocaleSettingPage(),
                    //       ),
                    //     );
                    //   },
                    // ),
                    CardSetting(
                      icon: Icons.wifi_outlined,
                      title: 'Trạng thái',
                      desc: 'Không cần mạng',
                    ),
                    // todo: offline khong co dang xuat
                    CardSetting(
                      icon: Icons.logout_outlined,
                      title: 'Đăng xuất',
                    ),
                  ],
                ),
              ),
              Gaps.vGap10,
            ],
          ),
        ),
      ),
    );
  }
}
