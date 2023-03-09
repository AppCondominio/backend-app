class CooperatorModel {
  int? id;
  String? name;
  String? document;
  String? job;
  String? status;
  String? dtCreated;
  String? dtUpdated;
  int? idSettingCondo;

  CooperatorModel();

  factory CooperatorModel.fromMap(Map map) {
    return CooperatorModel()
      ..id = int.parse(map['id'])
      ..name = map['name']
      ..document = map['document']
      ..job = map['job']
      ..status = map['status']
      ..dtCreated = map['dtCreated']
      ..dtUpdated = map['dtUpdated']
      ..idSettingCondo = int.parse(map['idSettingCondo']);
  }

  factory CooperatorModel.fromRequest(Map map) {
    return CooperatorModel()
      ..id = map['id']
      ..name = map['name']
      ..document = map['document']
      ..job = map['job']
      ..idSettingCondo = map['idSettingCondo'];
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'document': document,
        'job': job,
        'dtCreated': dtCreated,
        'dtUpdated': dtUpdated,
        'status': status,
        'idSettingCondo':idSettingCondo
      };

  @override
  String toString() {
    return 'CooperatorModel(id: $id, name: $name, document: $document, job: $job, dtCreated: $dtCreated, dtUpdated: $dtUpdated, status: $status, idSettingCondo: $idSettingCondo)';
  }
}
