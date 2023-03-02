import 'package:intl/intl.dart';

class CondoSettingsModel {
  final int? id;
  final List? towers;
  final int? recreationArea;
  final List cooperator;
  final String dtCreated;
  final String? dtUpdated;
  final int idCondo;

  CondoSettingsModel(
    this.id,
    this.towers,
    this.recreationArea,
    this.cooperator,
    this.dtCreated,
    this.dtUpdated,
    this.idCondo,
  );

  factory CondoSettingsModel.fromJson(Map map) {
    return CondoSettingsModel(
      map['id'] ?? '',
      map['towers'] ?? [],
      map['recreationArea'] ?? 0,
      map['cooperator'],
      map['dtCreated'] ??
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      map['dtUpdated'] != null
          ? DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
          : null,
      map['idCondo'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'towers': towers,
      'recreationArea': recreationArea,
      'cooperator': cooperator,
      'dtCreated': dtCreated,
      'dtUpdated': dtUpdated,
      'idCondo': idCondo
    };
  }

  Map toJson() => {
        'id': id,
        'towers': towers,
        'recreationArea': recreationArea,
        'cooperator': cooperator,
        'dtCreated': dtCreated,
        'dtUpdated': dtUpdated,
        'idCondo': idCondo
      };
}
