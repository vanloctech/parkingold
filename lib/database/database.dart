import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const String migrations = 'migrations';
const String cardVehiclesTable = 'card_vehicles';
const String vehiclesTable = 'vehicles';
const String settingTable = 'settings';

const int lastVersion = 2;

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  late Database _database;

  Future<Database> get database async {
    // if (_database != null) return _database;

    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveTodo.db is our database instance name
    String path = join(documentsDirectory.path, "parkingether.db");
    var database = await openDatabase(path,
        version: lastVersion, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  Future<void> onUpgrade(Database database, int oldVersion, int newVersion) async {
    print('onUpgradeDB');
    if (newVersion > oldVersion) {
      create230418CreateSettingTable(database);
      // update230416AddColumnStatusToCardVehicleTable(database);
      // update230416AddColumnMerchantIdToCardVehicleTable(database);
    }
  }

  void initDB(Database database, int version) async {
    print('initDB');
    await database.execute("CREATE TABLE $cardVehiclesTable ("
        "uuid TEXT PRIMARY KEY, "
        "rfid TEXT NOT NULL, "
        "plate_license CHAR(30), "
        "image_path TEXT NOT NULL, "
        "sync INTEGER, "
        "version INTEGER, "
        "status INTEGER, "
        "merchant_id INTEGER, "
        "created_at_local INTEGER NOT NULL, "
        "updated_at_local INTEGER NOT NULL"
        ")");

    await database.execute("CREATE TABLE $vehiclesTable ("
        "uuid TEXT PRIMARY KEY, "
        "rfid TEXT NOT NULL, "
        "plate_license CHAR(30), "
        "image_path TEXT NOT NULL, "
        "created_at_local INTEGER NOT NULL, "
        "updated_at_local INTEGER NOT NULL, "
        "merchant_id INTEGER, "
        "sync INTEGER"
        ")");

    create230418CreateSettingTable(database);
  }

  void update230416AddColumnStatusToCardVehicleTable(Database database) async {
    await database.execute("ALTER TABLE $cardVehiclesTable ADD COLUMN shop_id INT");
  }

  void update230416AddColumnMerchantIdToCardVehicleTable(Database database) async {
    await database.execute("ALTER TABLE $cardVehiclesTable ADD COLUMN merchant_id INT");
    await database.execute("ALTER TABLE $vehiclesTable ADD COLUMN merchant_id INT");
  }

  void create230418CreateSettingTable(Database database) async {
    await database.execute("CREATE TABLE $settingTable ("
        "key TEXT PRIMARY KEY, "
        "value TEXT, "
        "sync INTEGER, "
        "created_at_local INTEGER NOT NULL, "
        "updated_at_local INTEGER NOT NULL"
        ")");
  }
}
