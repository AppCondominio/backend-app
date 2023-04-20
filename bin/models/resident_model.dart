// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResidentModel {
  int? id;
  String? apartament;
  String? optApartament;
  bool? isRental;
  int? idUser;
  int? idCondo;
  int? idUserRental;

  ResidentModel();

  @override
  String toString() {
    return 'ResidentModel(id: $id, apartament: $apartament, optApartament: $optApartament, isRental: $isRental, idUser: $idUser, idCondo: $idCondo, idUserRental: $idUserRental)';
  }

  factory ResidentModel.fromMap(Map map) {
    return ResidentModel()
      ..id = int.parse(map['id'])
      ..apartament = map['apartament']
      ..optApartament = map['optApartament']
      ..isRental = map['isRental'] == "1" ? true : false
      ..idUser = map['idUser'] == null ? -1 : int.parse(map['idUser'])
      ..idCondo = int.parse(map['idCondo'])
      ..idUserRental = map['idUserRental'] == null ? -1 : int.parse(map['idUserRental']);
  }

  factory ResidentModel.fromRequest(Map map) {
    return ResidentModel()
      ..id = map['id']
      ..apartament = map['apartament']
      ..optApartament = map['optApartament']
      ..isRental = map['isRental']
      ..idUser = map['idUser']
      ..idCondo = map['idCondo']
      ..idUserRental = map['idUserRental'];
  }

  Map toJson() {
    return {
      'id': id,
      'apartament': apartament,
      'optApartament': optApartament,
      'isRental': isRental,
      'idUser': idUser,
      'idCondo': idCondo,
      'idUserRental': idUserRental,
    };
  }
}
