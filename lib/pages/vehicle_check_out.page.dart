import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:nfc_manager/nfc_manager.dart';
// import 'package:nfc_manager/platform_tags.dart';
import 'package:parkingold/models/card_vehicle.model.dart';
import 'package:parkingold/repositories/card_vehicle.repo.dart';
import 'package:parkingold/resources/colors.dart';
import 'package:parkingold/resources/gaps.dart';

import 'package:parkingold/resources/dimens.dart';
import 'package:parkingold/utils/helpers.util.dart';
import 'package:parkingold/utils/my_toast.util.dart';

import '../providers/card_vehicle.provider.dart';

class VehicleCheckOut extends StatefulWidget {
  const VehicleCheckOut({Key? key}) : super(key: key);

  @override
  State<VehicleCheckOut> createState() => _VehicleCheckOutState();
}

class _VehicleCheckOutState extends State<VehicleCheckOut> {
  num _tagRFIDValue = 0;
  bool _hasRFID = false;
  String? _imagePath;

  CardVehicleProvider provider = CardVehicleProvider();

  @override
  void initState() {
    //you are not allowed to add async modifier to initState
    super.initState();
    _readTagRFID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary,
      appBar: AppBar(
        title: const Text(
          'Xe ra',
          style: TextStyle(
              color: Colours.mainFontColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colours.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        leading: const BackButton(
          color: Colours.mainFontColor, // <-- SEE HERE
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 20),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: const [
                  Text(
                    'Đưa thẻ vào',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colours.mainFontColor,
                    ),
                  ),
                  Gaps.vGap10,
                  Icon(
                    Icons.nfc,
                    color: Colours.mainFontColor,
                    size: 100,
                  ),
                ],
              ),
              Gaps.vGap10,
              Expanded(child: imagePreview(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget imagePreview(BuildContext context) {
    return _hasRFID
        ? ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.radius_25),
            child: Container(
              color: Colors.red,
              child: Image.file(
                File(
                    _imagePath!
                ),
              ),
            ),
          )
        : Container();
  }

  void _readTagRFID() async {
    // NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
    //   var tmp = (NfcA.from(tag)?.identifier ??
    //           NfcB.from(tag)?.identifier ??
    //           NfcF.from(tag)?.identifier ??
    //           NfcV.from(tag)?.identifier ??
    //           Uint8List(0))
    //       .toHexString(separator: '');
    //
    //   var rfid = Utils.hexToDecimal(tmp);
    //
    //   CardVehicleModel? cardVehicleModel = await provider.vehicleCheckOut(rfid: rfid.toString());
    //   if (cardVehicleModel != null) {
    //     setState(() {
    //       _hasRFID = true;
    //       _imagePath = cardVehicleModel.imagePath;
    //     });
    //   } else {
    //     MyToast.show('Không tìm thấy xe');
    //   }
    //
    //   setState(() {
    //     _tagRFIDValue = rfid;
    //   });
    //
    //   // NfcManager.instance.stopSession();
    // });
  }

  @override
  void dispose() {
    // NfcManager.instance.stopSession();
    super.dispose();
  }
}
