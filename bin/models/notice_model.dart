class NoticeModel {
  int? id;
  String? title;
  String? description;
  String? attached;
  String? dtToDelete;
  int? leftDays;
  String? dtCreated;
  String? dtUpdated;
  String? status;
  int? idCondo;

  NoticeModel();

  factory NoticeModel.fromMap(Map map) {
    return NoticeModel()
      ..id = int.parse(map['id'])
      ..title = map['title']
      ..description = map['description']
      ..attached = map['attached']
      ..dtToDelete = map['dtToDelete']
      ..dtCreated = map['dtCreated']
      ..dtUpdated = map['dtUpdated']
      ..status = map['status']
      ..idCondo = int.parse(map['idCondo']);
  }

  factory NoticeModel.fromRequest(Map map) {
    return NoticeModel()
      ..id = map['id']
      ..title = map['title']
      ..description = map['description']
      ..attached = map['attached']
      ..dtToDelete = map['dtToDelete']
      ..status = map['status']
      ..idCondo = map['idCondo'];
  }

  Map toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'attached': attached,
        'dtToDelete': dtToDelete,
        'leftDays': leftDays,
        'dtCreated': dtCreated,
        'dtUpdated': dtUpdated,
        'status': status,
        'idCondo': idCondo
      };

  @override
  String toString() {
    return 'WarningModel(id: $id, title: $title, description: $description, attached: $attached, dtToDelete: $dtToDelete, dtCreated: $dtCreated, dtUpdated: $dtUpdated, status: $status, idCondo: $idCondo)';
  }
}
