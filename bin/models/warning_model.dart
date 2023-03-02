// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

class WarningModel {
  final int? id;
  final String title;
  final String description;
  final int dtToDelete;
  final String dtCreated;
  final String? dtUpdated;
  final String status;
  final int idCondo;

  WarningModel(this.id, this.title, this.description, this.dtToDelete,
      this.dtCreated, this.dtUpdated, this.status, this.idCondo);

  @override
  String toString() {
    return 'WarningModel(id: $id, title: $title, description: $description, dtToDelete: $dtToDelete, dtCreated: $dtCreated, dtUpdated: $dtUpdated, status: $status, idCondo: $idCondo)';
  }

  factory WarningModel.fromJson(Map map) {
    try {
      return WarningModel(
          map['id'],
          map['title'],
          map['description'],
          map['dtToDelete'],
          map['dtCreated'] ??
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
          map['dtUpdated'] != null
              ? DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
              : null,
          map['status'] ?? 'A',
          map['idCondo']);
    } catch (e) {
      throw Exception();
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'dtToDelete': dtToDelete,
      'dtCreated': dtCreated,
      'dtUpdated': dtUpdated,
      'status': status,
      'idCondo': idCondo
    };
  }

  Map toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'dtToDelete': dtToDelete,
        'dtCreated': dtCreated,
        'dtUpdated': dtUpdated,
        'status': status,
        'idCondo': idCondo
      };
}
