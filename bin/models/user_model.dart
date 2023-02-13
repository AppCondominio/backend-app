// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

class UserModel {
  final int? id;
  final String name;
  final String lastName;
  final String documentNumber;
  final String email;
  final String? renter;
  final String? password;
  final DateTime dtCreated;
  final DateTime? dtUpdated;
  final String? status;
  final String? deviceToken;
  final String? jwtToken;

  UserModel(
      this.id,
      this.name,
      this.lastName,
      this.documentNumber,
      this.email,
      this.renter,
      this.password,
      this.dtCreated,
      this.dtUpdated,
      this.status,
      this.deviceToken,
      this.jwtToken);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, lastName: $lastName, documentNumber: $documentNumber, email: $email, renter: $renter ,password: $password, dtCreated: $dtCreated, dtUpdated: $dtUpdated, status: $status, deviceToken: $deviceToken, jwtToken: $jwtToken)';
  }

  factory UserModel.fromJson(Map map) {
    return UserModel(
      map['id'] ?? '',
      map['name'],
      map['lastName'],
      map['documentNumber'],
      map['email'],
      map['renter'],
      map['password'] ??
          map['name'].toString() +
              map['documentNumber'].toString().substring(0, 2),
      DateTime.now(),
      map['dtUpdated'] != null
          ? DateTime.fromMicrosecondsSinceEpoch(map['dtUpdated'])
          : null,
      map['status'] ?? 'A',
      map['deviceToken'] ?? '',
      map['jwtToken'] ?? ''
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lastName': lastName,
      'documentNumber': documentNumber,
      'email': email,
      'renter': renter,
      'password': password,
      'dtCreated': dtCreated.millisecondsSinceEpoch,
      'dtUpdated': dtUpdated?.millisecondsSinceEpoch,
      'status': status,
      'deviceToken': deviceToken,
      'jwtToken': jwtToken
    };
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'lastName': lastName,
        'documentNumber': documentNumber,
        'email': email,
        'renter': renter,
        'password': password,
        'dtCreated': dtCreated.millisecondsSinceEpoch,
        'dtUpdated': dtUpdated?.millisecondsSinceEpoch,
        'status': status,
        'deviceToken': deviceToken,
        'jwtToken': jwtToken
      };
}
