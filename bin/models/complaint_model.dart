// ignore_for_file: public_member_api_docs, sort_constructors_first
class ComplaintModel {
  int? id;
  String? namePersonCreated;
  String? lastNamePersonCreated;
  String? phonePersonCreated;
  String? topic;
  String? description;
  String? attached;
  String? obs;
  String? dtCreated;
  String? dtUpdated;
  String? status;
  int? idCondo;
  int? idResident;
  String? apt;
  String? optApt;
  String? nameCurrentResident;
  String? lastNameCurrentResident;
  String? phoneCurrentResident;

  ComplaintModel();

  factory ComplaintModel.fromMap(Map map) {
    return ComplaintModel()
      ..id = int.parse(map['id'])
      ..namePersonCreated = map['namePersonCreated']
      ..lastNamePersonCreated = map['lastNamePersonCreated']
      ..phonePersonCreated = map['phonePersonCreated']
      ..topic = map['topic']
      ..description = map['description']
      ..attached = map['attached']
      ..obs = map['obs']
      ..dtCreated = map['dtCreated']
      ..dtUpdated = map['dtUpdated']
      ..status = map['status']
      ..idCondo = int.parse(map['idCondo'])
      ..idResident = int.parse(map['idResident'])
      ..apt = map['apartament']
      ..optApt = map['optApartament']
      ..nameCurrentResident = map['name']
      ..lastNameCurrentResident = map['lastName']
      ..phoneCurrentResident = map['phone'];
  }

  factory ComplaintModel.fromRequest(Map map) {
    return ComplaintModel()
      ..id = map['id']
      ..namePersonCreated = map['namePersonCreated']
      ..lastNamePersonCreated = map['lastNamePersonCreated']
      ..phonePersonCreated = map['phonePersonCreated']
      ..topic = map['topic']
      ..description = map['description']
      ..attached = map['attached']
      ..obs = map['obs']
      ..status = map['status']
      ..idCondo = map['idCondo']
      ..idResident = map['idResident'];
  }

  Map toJson() => {
        'id': id,
        'namePersonCreated':namePersonCreated,
        'lastNamePersonCreated': lastNamePersonCreated,
        'phonePersonCreated':phonePersonCreated,
        'topic': topic,
        'description': description,
        'attached': attached,
        'obs': obs,
        'dtCreated': dtCreated,
        'dtUpdated': dtUpdated,
        'status': status,
        'idCondo': idCondo,
        'idResident': idResident,
        'apt': apt,
        'optApt': optApt,
        'name': nameCurrentResident,
        'lastName': lastNameCurrentResident,
        'phone': phoneCurrentResident,
      };

  @override
  String toString() {
    return 'ComplaintModel(id: $id, namePersonCreated: $namePersonCreated, lastNamePersonCreated: $lastNamePersonCreated, phonePersonCreated: $phonePersonCreated, topic: $topic, description: $description, attached: $attached, obs: $obs, dtCreated: $dtCreated, dtUpdated: $dtUpdated, status: $status, idCondo: $idCondo, idResident: $idResident, apt: $apt, optApt: $optApt, nameCurrentResident: $nameCurrentResident, lastNameCurrentResident: $lastNameCurrentResident, phoneCurrentResident: $phoneCurrentResident)';
  }
}
