// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

class CondoModel {
  final int? id;
  final String condoName;
  final String documentNumber;
  final String? password;
  final String email;
  final String zipCode;
  final String numberAddress;
  final String? optionalAddress;
  //final String imageUrl;
  final DateTime dtCreated;
  final DateTime? dtUpdated;
  final String? status;
  // Apenas para testes
  final int? idUser;
  final String plan;

  CondoModel(
      this.id,
      this.condoName,
      this.documentNumber,
      this.password,
      this.email,
      this.zipCode,
      this.numberAddress,
      this.optionalAddress,
      this.dtCreated,
      this.dtUpdated,
      this.status,
      this.idUser,
      this.plan);

  factory CondoModel.fromJson(Map map) {
    return CondoModel(
        map['id'] ?? '',
        map['condoName'],
        map['documentNumber'],
        map['password'] ?? Random().nextInt(50).toString(),
        map['email'],
        map['zipCode'],
        map['numberAddress'],
        map['optionalAddress'] ?? '',
        DateTime.now(),
        map['dtUpdated'] != null
            ? DateTime.fromMicrosecondsSinceEpoch(map['dtUpdated'])
            : null,
        map['status'] ?? 'A',
        map['idUser'] ?? '',
        map['plan']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'condoName': condoName,
      'documentNumber': documentNumber,
      'password': password,
      'email': email,
      'zipCode': zipCode,
      'numberAddress': numberAddress,
      'optionalAddress': optionalAddress,
      'dtCreated': dtCreated.millisecondsSinceEpoch,
      'dtUpdated': dtUpdated?.millisecondsSinceEpoch,
      'status': status,
      'idUser': idUser,
      'plan':plan
    };
  }

  Map toJson() => {
        'id': id,
        'condoName': condoName,
        'documentNumber': documentNumber,
        'password': password,
        'email': email,
        'zipCode': zipCode,
        'numberAddress': numberAddress,
        'optionalAddress': optionalAddress,
        'dtCreated': dtCreated.millisecondsSinceEpoch,
        'dtUpdated': dtUpdated?.millisecondsSinceEpoch,
        'status': status,
        'idUser': idUser,
        'plan':plan
      };
}
