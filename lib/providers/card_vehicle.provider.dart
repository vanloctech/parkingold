import 'package:flutter/cupertino.dart';
import 'package:parkingold/enums/sync.enum.dart';
import 'package:uuid/uuid.dart';
import '../models/card_vehicle.model.dart';
import '../repositories/card_vehicle.repo.dart';

class CardVehicleProvider extends ChangeNotifier {
  final _cardVehicleRepository = CardVehicleRepository();
  List<CardVehicleModel> _item = [];

  List<CardVehicleModel> get item => _item;

  Future<void> getAll() async {
    _item = await _cardVehicleRepository.getAll();

    notifyListeners();
  }

  /// insert
  Future vehicleCheckIn({
    String? rfid,
    String? imagePath,
  }) async {
    CardVehicleModel? cardVehiclesModel =
        await _cardVehicleRepository.getOne(rfid!, column: 'rfid');

    if (cardVehiclesModel == null) {
      final cardVehicleModel = CardVehicleModel(
        uuid: const Uuid().v4(),
        rfid: rfid,
        plateLicense: '',
        imagePath: imagePath,
        createdAtLocal: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        updatedAtLocal: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        sync: SyncEnum.noSync,
        status: 0,
      );
      _item.add(cardVehicleModel);

      await _cardVehicleRepository.insert(cardVehicleModel);
    } else {
      await _cardVehicleRepository.update(cardVehiclesModel.uuid, {
        'status': 0,
        'image_path': imagePath,
        'updated_at_local': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      });
      // todo: neu da co trong sqlite thi xoa anh
    }

    notifyListeners();
  }

  Future<CardVehicleModel?> vehicleCheckOut({
    required String rfid,
  }) async {
    CardVehicleModel? cardVehiclesModel =
    await _cardVehicleRepository.getOne(rfid, column: 'rfid');

    if (cardVehiclesModel != null) {
      await _cardVehicleRepository.update(cardVehiclesModel.uuid, {
        'status': 1,
        'updated_at_local': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      });

      // todo: tao 1 cai luu vo vehicle de thong ke bao cao -> xu ly quet nhieu lan chi tinh 1 lan

      return cardVehiclesModel;
    }

    return null;
  }

  Future<void> deleteByUuid(String uuid) async {
    await _cardVehicleRepository.deleteByUuid(uuid);

    print('deleted card_vehicle');
    notifyListeners();
  }

  Future<void> updateByUuid(String uuid, Map<String, dynamic> data) async {
    await _cardVehicleRepository.update(uuid, data);

    notifyListeners();
  }
}
