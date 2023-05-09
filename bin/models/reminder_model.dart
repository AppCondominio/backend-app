// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReminderModel {
  int? id;
  String? title;
  String? description;
  String? dtCreated;
  int? idCondo;

  ReminderModel();

  factory ReminderModel.fromMap(Map map) {
    return ReminderModel()
      ..id = int.parse(map['id'])
      ..title = map['title']
      ..description = map['description']
      ..dtCreated = map['dtCreated']
      ..idCondo = int.parse(map['idCondo']);
  }

  factory ReminderModel.fromRequest(Map map) {
    return ReminderModel()
      ..id = map['id']
      ..title = map['title']
      ..description = map['description']
      ..dtCreated = map['dtCreated']
      ..idCondo = map['idCondo'];
  }

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dtCreated': dtCreated,
      'idCondo': idCondo,
    };
  }

  @override
  String toString() {
    return 'ReminderModel(id: $id, title: $title, description: $description, dtCreated: $dtCreated, idCondo: $idCondo)';
  }
}
