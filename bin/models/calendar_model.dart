// ignore_for_file: public_member_api_docs, sort_constructors_first
class CalendarModel {
  int? id;
  String? day;
  String? event;
  int? idCondo;

  CalendarModel();

  factory CalendarModel.fromMap(Map map) {
    return CalendarModel()
      ..id = int.parse(map['id'])
      ..day = map['day']
      ..event = map['event']
      ..idCondo = int.parse(map['idCondo']);
  }

  factory CalendarModel.fromRequest(Map map) {
    return CalendarModel()
      ..id = map['id']
      ..day = map['day']
      ..event = map['event']
      ..idCondo = map['idCondo'];
  }

  Map toJson() {
    return {
      'id': id,
      'day': day,
      'event': event,
      'idCondo': idCondo,
    };
  }

  @override
  String toString() {
    return 'CalendarModel(id: $id, day: $day, event: $event, idCondo: $idCondo)';
  }
}
