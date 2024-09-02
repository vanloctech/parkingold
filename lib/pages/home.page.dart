import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:nfc_manager/nfc_manager.dart';
import 'package:parkingold/models/card_vehicle.model.dart';
import 'package:parkingold/pages/setting.page.dart';
import 'package:parkingold/pages/vehicle_check_out.page.dart';
import 'package:parkingold/widgets/button_function.widget.dart';
import 'package:parkingold/pages/vehicle_check_in.page.dart';
import 'package:parkingold/resources/colors.dart';
// import 'package:flutter_gen/gen_l10n/parkingether_localizations.dart';

import '../utils/my_toast.util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ButtonFunction(
                      icon: Icons.motorcycle,
                      title: 'Xe vào',
                      onTap: () async {
                        // bool isAvailable =
                        //     await NfcManager.instance.isAvailable();
                        //
                        // if (!isAvailable) {
                        //   MyToast.show(
                        //       'Thiết bị của bạn không hỗ trợ đọc thẻ NFC hoặc RFID',
                        //       duration: 5000);
                        //   return;
                        // }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VehicleCheckIn(),
                          ),
                        );
                      },
                    ),
                    ButtonFunction(
                      icon: Icons.keyboard_double_arrow_right,
                      title: 'Xe ra',
                      onTap: () async {
                        // bool isAvailable =
                        //     await NfcManager.instance.isAvailable();
                        //
                        // if (!isAvailable) {
                        //   MyToast.show(
                        //       'Thiết bị của bạn không hỗ trợ đọc thẻ NFC hoặc RFID',
                        //       duration: 5000);
                        //   return;
                        // }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VehicleCheckOut(),
                          ),
                        );
                      },
                    ),
                    ButtonFunction(
                      icon: Icons.topic,
                      title: 'Báo cáo',
                      onTap: () {
                        print('bao cao');
                      },
                    ),
                    ButtonFunction(
                      icon: Icons.settings,
                      title: 'Cài đặt',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingPage(),
                          ),
                        );
                        // print(Lang().trans('setting').then((value) => null));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Parkingold - giữ xe',
          style: TextStyle(
            color: Colours.buttonColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colours.transparent,
        shadowColor: Colours.transparent,
        centerTitle: true,
      ),
    );
  }
}
