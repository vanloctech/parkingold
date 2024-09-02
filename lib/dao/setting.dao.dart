import '../database/database.dart';
import '../models/setting.model.dart';

class SettingDAO {
  final dbProvider = DatabaseProvider.dbProvider;

  /// Get value by key
  Future<SettingModel?> getByKey(String key) async {
    final db = await dbProvider.database;

    final List<Map<String, dynamic>> maps = await db.query(
      settingTable,
      where: 'key = ?',
      whereArgs: [key],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return SettingModel.fromJson(maps.first);
    }

    return null;
  }

  /// Create or update setting
  Future<int> createOrUpdate(String key, String value) async {
    final db = await dbProvider.database;

    SettingModel? settingModel = await getByKey(key);

    var result = 0;
    if (settingModel == null) {
      result = await db.insert(settingTable, {
        'key': key,
        'value': value,
        'created_at_local': DateTime.now().microsecond / 1000,
        'updated_at_local': DateTime.now().microsecond / 1000,
      });
    } else {
      result = await db.update(settingTable, {
        'value': value,
        'updated_at_local': DateTime.now().microsecond / 1000,
      });
    }

    return result;
  }
}
