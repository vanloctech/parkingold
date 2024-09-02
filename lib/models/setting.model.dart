class SettingModel {
  String? key;
  String? value;
  int? sync;

  SettingModel({this.key, this.value, this.sync});

  SettingModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}
