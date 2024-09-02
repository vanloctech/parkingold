class VehicleModel {
  String? rfid;
  String? plateLicense;
  String? imagePath;
  int? createdAtLocal;
  int? updatedAtLocal;
  int? sync;
  int? merchantId;

  VehicleModel(
      {this.rfid,
        this.plateLicense,
        this.imagePath,
        this.createdAtLocal,
        this.updatedAtLocal,
        this.merchantId,
        this.sync});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    rfid = json['rfid'];
    plateLicense = json['plate_license'];
    imagePath = json['image_path'];
    createdAtLocal = json['created_at_local'];
    updatedAtLocal = json['updated_at_local'];
    sync = json['sync'];
    merchantId = json['merchant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rfid'] = this.rfid;
    data['plate_license'] = this.plateLicense;
    data['image_path'] = this.imagePath;
    data['created_at_local'] = this.createdAtLocal;
    data['updated_at_local'] = this.updatedAtLocal;
    data['sync'] = this.sync;
    data['merchant_id'] = this.merchantId;
    return data;
  }
}
