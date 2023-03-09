// ignore_for_file: public_member_api_docs, sort_constructors_first
class ComplaintModel {
  int? id;
  String? topic;
  String? description;
  List<int>? attached;
  String? dtCreated;
  String? dtUpdated;
  String? status;
  int? idCondo;
  int? idResident;

  ComplaintModel();

  factory ComplaintModel.fromMap(Map map) {
    return ComplaintModel()
      ..id = int.parse(map['id'])
      ..topic = map['topic']
      ..description = map['description']
      ..attached = map['attached'] == null ? [] : map['attached'].getBytes()
      ..dtCreated = map['dtCreated']
      ..dtUpdated = map['dtUpdated']
      ..status = map['status']
      ..idCondo = int.parse(map['idCondo'])
      ..idResident = int.parse(map['idResident']);
  }

  factory ComplaintModel.fromRequest(Map map) {
    return ComplaintModel()
      ..id = map['id']
      ..topic = map['topic']
      ..description = map['description']
      ..attached = map['attached']
      ..idCondo = map['idCondo']
      ..idResident = map['idResident'];
  }

  Map toJson() => {
        'id': id,
        'topic': topic,
        'description': description,
        'attached': attached,
        'dtCreated': dtCreated,
        'dtUpdated': dtUpdated,
        'status': status,
        'idCondo': idCondo,
        'idResident': idResident
      };

  @override
  String toString() {
    return 'ComplaintModel(id: $id, topic: $topic, description: $description, attached: $attached, dtCreated: $dtCreated, dtUpdated: $dtUpdated, status: $status, idCondo: $idCondo, idResident: $idResident)';
  }
}
