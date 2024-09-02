import 'package:parkingold/models/card_vehicle.model.dart';

import '../database/database.dart';

class CardVehicleDao {
  final dbProvider = DatabaseProvider.dbProvider;

  /// Adds new records
  Future<int> create(CardVehicleModel cardVehicleModel) async {
    final db = await dbProvider.database;
    var result = db.insert(cardVehiclesTable, cardVehicleModel.toJson());

    return result;
  }

  /// Get All items
  Future<List<CardVehicleModel>> getAll({List<String>? columns}) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result = [];

    if (columns != null) {
      result = await db.query(cardVehiclesTable, columns: columns);
    } else {
      result = await db.query(cardVehiclesTable);
    }

    List<CardVehicleModel> cardVehicles = result.isNotEmpty
        ? result.map((item) => CardVehicleModel.fromJson(item)).toList()
        : [];
    return cardVehicles;
  }

  /// Update record
  Future<CardVehicleModel?> getOne(String value,
      {String column = 'uuid'}) async {
    final db = await dbProvider.database;

    final List<Map<String, dynamic>> maps = await db.query(
      cardVehiclesTable,
      where: '$column = ?',
      whereArgs: [value],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return CardVehicleModel.fromJson(maps.first);
    }

    return null;
  }

  /// Update record
  Future<int> update(uuid, Map<String, dynamic> data) async {
    final db = await dbProvider.database;

    var result = await db
        .update(cardVehiclesTable, data, where: "uuid = ?", whereArgs: [uuid]);

    return result;
  }

  /// Delete records
  Future<int> delete(String uuid) async {
    final db = await dbProvider.database;
    var result = await db
        .delete(cardVehiclesTable, where: 'uuid = ?', whereArgs: [uuid]);

    return result;
  }
}
