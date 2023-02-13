// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:intl/intl.dart';

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
  final String dtCreated;
  final String? dtUpdated;
  final String? status;
  // Apenas para testes
  final String plan;
  final bool isSet;
  // Configuracoes

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
      this.plan,
      this.isSet);

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
        map['dtCreated'] ?? DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        map['dtUpdated'] != null
            ? DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
            : null,
        map['status'] ?? 'A',
        map['plan'],
        map['isSet'] ?? false);
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
      'dtCreated': dtCreated,
      'dtUpdated': dtUpdated,
      'status': status,
      'plan': plan,
      'isSet': isSet
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
        'dtCreated': dtCreated,
        'dtUpdated': dtUpdated,
        'status': status,
        'plan': plan,
        'isSet': isSet
      };
}
