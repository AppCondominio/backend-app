// ignore_for_file: public_member_api_docs, sort_constructors_first
class ScheduleModel {
  int? id;
  String? local;
  String? dtScheduled;
  bool? wasPaid;
  String? dtCreated;
  int? idUser;
  int? idCondo;
  int? idResident;
  int? idRecreation;

  ScheduleModel();

  @override
  String toString() {
    return 'ScheduleModel(id: $id, local: $local, dtScheduled: $dtScheduled, wasPaid: $wasPaid, dtCreated: $dtCreated, idUser: $idUser, idCondo: $idCondo, idResident: $idResident, idRecreation: $idRecreation)';
  }

  factory ScheduleModel.fromMap(Map map) {
    return ScheduleModel()
      ..id = int.parse(map['id'])
      ..local = map['local']
      ..dtScheduled = map['dtScheduled']
      ..wasPaid = map['wasPaid'] == "1" ? true : false
      ..dtCreated = map['dtCreated']
      ..idUser = int.parse(map['idUser'])
      ..idCondo = int.parse(map['idCondo'])
      ..idResident = int.parse(map['idResident'])
      ..idRecreation = int.parse(map['idRecreation']);
  }

  factory ScheduleModel.fromRequest(Map map) {
    return ScheduleModel()
      ..id = map['id']
      ..local = map['local']
      ..dtScheduled = map['dtScheduled']
      ..wasPaid = map['wasPaid']
      ..dtCreated = map['dtCreated']
      ..idUser = map['idUser']
      ..idCondo = map['idCondo']
      ..idResident = map['idResident']
      ..idRecreation = map['idRecreation'];
  }

  Map toJson() => {'id': id, 'local': local, 'dtScheduled': dtScheduled, 'wasPaid': wasPaid, 'dtCreated': dtCreated, 'idUser': idUser, 'idCondo': idCondo, 'idResident': idResident, 'idRecreation':idRecreation};

  Map toJsonDtSchadule() => {'dtScheduled': dtScheduled, 'idRecreation': idRecreation};
}
