// ignore_for_file: public_member_api_docs, sort_constructors_first

// Retirei a senha do model

import 'package:intl/intl.dart';

class CondoModel {
  int? id;
  String? name;
  String? document;
  String? password;
  String? email;
  String? zipCode;
  String? addressNumber;
  String? optAddress;
  String? dtCreated;
  String? dtUpdated;
  String? status;

  CondoModel();

  CondoModel.create(this.id, this.name, this.document, this.email, this.zipCode, this.addressNumber, this.optAddress,
      this.dtCreated, this.dtUpdated, this.status);

  factory CondoModel.fromMap(Map<String, dynamic> map) {
    return CondoModel.create(
      int.parse(map['id']),
      map['name'],
      map['document'],
      map['email'],
      map['zipCode'],
      map['addressNumber'],
      map['optAddress'] ?? '',
      map['dtCreated'],
      map['dtUpdated'] ?? '',
      map['status'] ?? 'A',
    );
  }

  factory CondoModel.fromRequest(Map map) {
    return CondoModel()
      ..name = map['name']
      ..document = map['document']
      ..password = map['password']
      ..email = map['email']
      ..zipCode = map['zipCode']
      ..addressNumber = map['addressNumber']
      ..optAddress = map['optAddress'];
  }

  factory CondoModel.fromJson(Map map) {
    return CondoModel.create(
        map['id'] ?? '',
        map['name'],
        map['document'],
        map['email'],
        map['zipCode'],
        map['addressNumber'],
        map['optAddress'] ?? '',
        map['dtCreated'] ?? DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        map['dtUpdated'] != null ? DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()) : null,
        map['status'] ?? 'A',);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'document': document,
      'email': email,
      'zipCode': zipCode,
      'addressNumber': addressNumber,
      'optAddress': optAddress,
      'dtCreated': dtCreated,
      'dtUpdated': dtUpdated,
      'status': status,
    };
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'document': document,
        'email': email,
        'zipCode': zipCode,
        'addressNumber': addressNumber,
        'optAddress': optAddress,
        'dtCreated': dtCreated,
        'dtUpdated': dtUpdated,
        'status': status,
      };

  @override
  String toString() {
    return 'CondoModel(id: $id, name: $name, document: $document, email: $email, zipCode: $zipCode, addressNumber: $addressNumber, optAddress: $optAddress, dtCreated: $dtCreated, dtUpdated: $dtUpdated, status: $status)';
  }
}
