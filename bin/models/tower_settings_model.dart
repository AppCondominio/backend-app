class TowerSettingsModel {
  int? id;
  String? name;
  String? dtCreated;
  String? dtUpdated;
  int? idSettingCondo;

  TowerSettingsModel();

  factory TowerSettingsModel.fromMap(Map map) {
    return TowerSettingsModel()
      ..id = int.parse(map['id'])
      ..name = map['name']
      ..dtCreated = map['dtCreated']
      ..dtUpdated = map['dtUpdated']
      ..idSettingCondo = int.parse(map['idSettingCondo']);
  }

  factory TowerSettingsModel.fromRequest(Map map) {
    return TowerSettingsModel()
      ..id = map['id']
      ..name = map['name']
      ..idSettingCondo = map['idSettingCondo'];
  }

  Map toJson() =>
      {'id': id, 'name': name, 'dtCreated': dtCreated, 'dtUpdated': dtUpdated, 'idSettingCondo': idSettingCondo};
}
