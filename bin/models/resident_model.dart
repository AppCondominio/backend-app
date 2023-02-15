// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResidentModel {
  final int? id;
  final String room;
  final String? optionalRoom;
  //apenas para testes
  final String idUser;
  final int idCondo;

  ResidentModel(
    this.id,
    this.room,
    this.optionalRoom,
    this.idUser,
    this.idCondo,
  );

  @override
  String toString() {
    return 'ResidentModel(id: $id, room: $room, optionalRoom: $optionalRoom, idUser: $idUser, idCondo: $idCondo)';
  }

  factory ResidentModel.fromJson(Map map) {
    return ResidentModel(map['id'] ?? '', map['room'],
        map['optionalRoom'] ?? '', map['idUser'], map['idCondo']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'room': room,
      'optionalRoom': optionalRoom,
      'idUser': idUser,
      'idCondo': idCondo
    };
  }

  Map toJson() => {
        'id': id,
        'room': room,
        'optionalRoom': optionalRoom,
        'idUser': idUser,
        'idCondo': idCondo,
      };
}
