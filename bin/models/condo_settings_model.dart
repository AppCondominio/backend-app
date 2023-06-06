class CondoSettingsModel {
  int? id;
  bool? isConfigurated;
  int? idCondo;

  CondoSettingsModel();

  Map toJson() => {'id': id, 'isConfigurated': isConfigurated, 'idCondo': idCondo};

  @override
  String toString() => 'CondoSettingsModel(id: $id, isConfigurated: $isConfigurated, idCondo: $idCondo)';

  factory CondoSettingsModel.fromMap(Map map) {
    return CondoSettingsModel()
      ..id = int.parse(map['id'])
      ..isConfigurated = map['isConfigurated'] == "1" ? true : false
      ..idCondo = int.parse(map['idCondo']);
  }

  factory CondoSettingsModel.fromRequest(Map map) {
    return CondoSettingsModel()
      ..id = map['id']
      ..isConfigurated = map['isConfigurated'] == "1" ? true : false
      ..idCondo = int.parse(map['idCondo']);
  }
}
