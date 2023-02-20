// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

class CooperatorModel {
  final int? id;
  final String name;
  final String documentNumber;
  final String role;
  final String dtCreated;
  final String? dtUpdated;
  final String? status;
  final int idCondo;

  CooperatorModel(
    this.id,
    this.name,
    this.documentNumber,
    this.role,
    this.dtCreated,
    this.dtUpdated,
    this.status, this.idCondo,
  );

  factory CooperatorModel.fromJson(Map map) {
    return CooperatorModel(
      map['id'] ?? '',
      map['name'],
      map['documentNumber'],
      map['role'],
      map['dtCreated'] ??
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      map['dtUpdated'] != null
          ? DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
          : null,
      map['status'] ?? 'A',
      map['idCondo']
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'documentNumber': documentNumber,
      'role': role,
      'dtCreated': dtCreated,
      'dtUpdated': dtUpdated,
      'status': status,
      'idCondo':idCondo
    };
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'documentNumber': documentNumber,
        'role': role,
        'dtCreated': dtCreated,
        'dtUpdated': dtUpdated,
        'status': status,
        'idCondo':idCondo
      };

  @override
  String toString() {
    return 'CooperatorModel(id: $id, name: $name, documentNumber: $documentNumber, role: $role, dtCreated: $dtCreated, dtUpdated: $dtUpdated, status: $status, idCondo: $idCondo)';
  }
}
