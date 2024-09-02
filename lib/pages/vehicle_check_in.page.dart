import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkingold/providers/card_vehicle.provider.dart';
import 'package:parkingold/resources/colors.dart';
import 'package:parkingold/resources/dimens.dart';
import 'package:parkingold/resources/gaps.dart';
import 'package:parkingold/theme/colors.dart';
import 'package:parkingold/utils/my_toast.util.dart';

import 'package:parkingold/utils/screen.util.dart';
import 'package:parkingold/utils/helpers.util.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:io';
import 'dart:core';
// import 'package:nfc_manager/nfc_manager.dart';
import 'dart:typed_data';
// import 'package:nfc_manager/platform_tags.dart';
// import 'package:flutter_gen/gen_l10n/parkingether_localizations.dart';
import 'package:provider/provider.dart';

class VehicleCheckIn extends StatefulWidget {
  const VehicleCheckIn({Key? key}) : super(key: key);

  @override
  State<VehicleCheckIn> createState() => _VehicleCheckInState();
}

class _VehicleCheckInState extends State<VehicleCheckIn> {
  late CameraController _cameraController;
  Future<void>? _initializeControllerFuture;
  bool _hasRFID = false;
  num _tagRFIDValue = 0;
  String _imagePath = '';
  bool _isSaving = false;
  final List<String> _recentImages = [];
  late FlashMode _flashLight = FlashMode.off;

  CardVehicleProvider provider = CardVehicleProvider();

  Future<void> _initCamera() async {
    final _cameras = await availableCameras();
    final firstCamera = _cameras.first;

    setState(() {
      _cameraController = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );

      // Next, initialize the controller. This returns a Future.
      _initializeControllerFuture = _cameraController.initialize();
    });
  }

  @override
  void initState() {
    //you are not allowed to add async modifier to initState
    super.initState();
    _initCamera();
    _readTagRFID();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        title: Text(
          'Xe vào',
          style: const TextStyle(
            color: Colours.mainFontColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colours.transparent,
        shadowColor: Colours.transparent,
        centerTitle: true,
        leading: const BackButton(
          color: Colours.mainFontColor, // <-- SEE HERE
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
              top: Dimens.gap_dp10, bottom: Dimens.gap_dp20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStatusRFID(context),
              Gaps.vGap20,
              takePictureScreen(context),
              Gaps.vGap20,
              imagePreview(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget textStatusRFID(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimens.gap_dp20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _hasRFID
                ? 'Đang chụp ảnh, giữ yên...'.toUpperCase()
                : 'Đưa thẻ vào'.toUpperCase(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _hasRFID ? orange : Colours.mainFontColor,
            ),
          ),
          Gaps.hGap5,
          _isSaving
              ? const SizedBox(
                  width: Dimens.gap_dp15,
                  height: Dimens.gap_dp15,
                  child: CircularProgressIndicator(
                    backgroundColor: Colours.orange,
                    color: Colours.primary,
                  ),
                )
              : const Icon(
                  Icons.nfc,
                  color: Colours.mainFontColor,
                  size: 25,
                ),
        ],
      ),
    );
  }

  Widget takePictureScreen(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: context.height / 1.7,
      // margin: const EdgeInsets.all(10),
      child: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            _cameraController.setFlashMode(_flashLight);
            return ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.radius_25),
              child: CameraPreview(
                _cameraController,
                child: Container(
                  padding: const EdgeInsets.all(Dimens.gap_dp10),
                  // color: green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        backgroundColor: buttoncolor,
                        foregroundColor: primary,
                        onPressed: _onChangeFlashLight,
                        child: Icon(
                          _checkFlashLightStatus()
                              ? Icons.flashlight_on
                              : Icons.flashlight_off,
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget imagePreview(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: Dimens.gap_dp20),
        // height: context.height / 3,
        child: ListView.builder(
            itemCount: _recentImages.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                // color: Colors.red,
                margin: const EdgeInsets.only(
                    left: Dimens.gap_dp5, right: Dimens.gap_dp5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.radius_25),
                  child: Image.file(
                    File(_recentImages[index]),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _cameraController.takePicture();

      if (!mounted) return;

      _imagePath = image.path;
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }

  Future<void> _onSave() async {
    // final cardVehicleProvider = Provider.of<CardVehicleProvider>(context, listen: false);

    setState(() {
      _isSaving = true;
    });

    if (_tagRFIDValue != 0) {
      await _takePicture();
      print('RFID: $_tagRFIDValue');
      print('Image path: $_imagePath');

      if (_recentImages.isNotEmpty && _recentImages.length >= 5) {
        _recentImages.removeLast();
      }
      setState(() {
        _recentImages.insert(0, _imagePath);
      });
    }

    provider.vehicleCheckIn(rfid: _tagRFIDValue.toString(), imagePath: _imagePath);
    // cardVehicleProvider.insert(_tagRFIDValue.toString(), _imagePath);
    //
    // print(provider.getAll());
    _refreshNewState();
    MyToast.show('Thêm xe thành công', backgroundColor: Colours.buttonColor);

    setState(() {
      _isSaving = false;
    });
  }

  Future<void> _readTagRFID() async {
    // Check availability
    // NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
    //   var tmp = (NfcA.from(tag)?.identifier ??
    //           NfcB.from(tag)?.identifier ??
    //           NfcF.from(tag)?.identifier ??
    //           NfcV.from(tag)?.identifier ??
    //           Uint8List(0))
    //       .toHexString(separator: '');
    //
    //   print(Utils.hexToDecimal(tmp));
    //   setState(() {
    //     _hasRFID = true;
    //     _tagRFIDValue = Utils.hexToDecimal(tmp);
    //   });
    //
    //   NfcManager.instance.stopSession();
    //   _onSave();
    // });
  }

  void _onChangeFlashLight() {
    FlashMode tmp;

    if (_checkFlashLightStatus()) {
      tmp = FlashMode.off;
    } else {
      tmp = FlashMode.torch;
    }

    setState(() {
      _flashLight = tmp;
    });
  }

  /// off is false, on is true
  bool _checkFlashLightStatus() {
    if (_flashLight == FlashMode.off) {
      return false;
    } else {
      return true;
    }
  }

  void _refreshNewState() async {
    setState(() {
      _tagRFIDValue = 0;
      _imagePath = '';
      _hasRFID = false;
    });

    // _initCamera();
    await _readTagRFID();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _cameraController.dispose();
    // NfcManager.instance.stopSession();
    super.dispose();
  }
}
