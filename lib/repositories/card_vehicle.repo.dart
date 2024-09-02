import 'package:parkingold/dao/card_vehicle.dao.dart';

import '../models/card_vehicle.model.dart';

class CardVehicleRepository {
  final modelDao = CardVehicleDao();

  Future getAll({List<String>? columns}) => modelDao.getAll(columns: columns);

  Future<CardVehicleModel?> getOne(String value, {String column = 'uuid'}) => modelDao.getOne(value, column: column);

  Future insert(CardVehicleModel cardVehicleModel) => modelDao.create(cardVehicleModel);

  Future update(uuid, Map<String, dynamic> data) => modelDao.update(uuid, data);

  Future deleteByUuid(String uuid) => modelDao.delete(uuid);
}