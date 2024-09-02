import 'package:parkingold/dao/card_vehicle.dao.dart';
import 'package:parkingold/dao/setting.dao.dart';
import 'package:parkingold/models/setting.model.dart';

import '../models/card_vehicle.model.dart';

class SettingRepository {
  final modelDao = SettingDAO();

  Future<SettingModel?> getByKey(String key) => modelDao.getByKey(key);

  Future<int> createOrUpdate(String key, String value) => modelDao.createOrUpdate(key, value);
}