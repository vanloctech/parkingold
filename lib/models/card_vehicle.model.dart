class CardVehicleModel {
  String? uuid;
  String? rfid;
  String? plateLicense;
  String? imagePath;
  int? createdAtLocal;
  int? updatedAtLocal;
  int? sync;
  int? version;
  int? status;
  int? merchantId;

  CardVehicleModel(
      {required this.uuid,
      required this.rfid,
      this.plateLicense,
      this.imagePath,
      this.createdAtLocal,
      this.updatedAtLocal,
      this.sync,
      this.status,
      this. merchantId,
      this.version});

  CardVehicleModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    rfid = json['rfid'];
    plateLicense = json['plate_license'];
    imagePath = json['image_path'];
    createdAtLocal = json['created_at_local'];
    updatedAtLocal = json['updated_at_local'];
    sync = json['sync']  as int?;
    version = json['version'];
    status = json['status'];
    merchantId = json['merchant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['rfid'] = this.rfid;
    data['plate_license'] = this.plateLicense;
    data['image_path'] = this.imagePath;
    data['created_at_local'] = this.createdAtLocal;
    data['updated_at_local'] = this.updatedAtLocal;
    data['sync'] = this.sync;
    data['version'] = this.version;
    data['status'] = this.status;
    data['merchant_id'] = this.merchantId;
    return data;
  }
}
