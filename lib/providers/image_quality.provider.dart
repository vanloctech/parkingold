import 'package:flutter/cupertino.dart';
import 'package:parkingold/enums/sync.enum.dart';
import 'package:parkingold/repositories/setting.repo.dart';
import 'package:parkingold/utils/constants.uti.dart';
import 'package:uuid/uuid.dart';
import '../models/card_vehicle.model.dart';
import '../repositories/card_vehicle.repo.dart';

class ImageQualityProvider extends ChangeNotifier {
  final _settingRepository = SettingRepository();
  String _mode = 'low';

  String get mode => _mode;

  ImageQualityProvider() {
    getQuality();
  }

  Future<void> getQuality() async {
    var quality = await _settingRepository.getByKey(Constant.imageQuality);
    if (quality != null) {
      // print(quality.toJson());
      _mode = quality.value ?? 'low';
    }

    notifyListeners();
  }

  Future<void> createOrUpdate(String value) async {
    // print('receive $value');
    await _settingRepository.createOrUpdate(Constant.imageQuality, value);
    _mode = value;

    // print('after save $_mode');
    notifyListeners();
  }
}
