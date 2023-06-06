class BillModel {
  int? id;
  int? idCondo;
  int? idResident;
  String? month;
  String? year;
  String? urlPdf;
  double? dueValue;
  String? dueDate;
  String? dtSent;
  bool? hasOpened;
  String? dtOpened;

  BillModel();

  factory BillModel.fromMap(Map map) {
    return BillModel()
      ..id = int.parse(map['id'])
      ..idCondo = int.parse(map['idCondo'])
      ..idResident = int.parse(map['idResident'])
      ..month = map['month']
      ..year = map['year']
      ..urlPdf = map['urlPdf']
      ..dueValue = double.parse(map['dueValue'])
      ..dueDate = map['dueDate']
      ..dtSent = map['dtSent']
      ..hasOpened = map['hasOpened'] == "1" ? true : false
      ..dtOpened = map['dtOpened'];
  }

  factory BillModel.fromRequest(Map map) {
    return BillModel()
      ..id = map['id']
      ..idCondo = int.tryParse(map['idCondo'] ?? '')
      ..idResident = map['idResident']
      ..month = map['month']
      ..year = map['year']
      ..urlPdf = map['urlPdf']
      ..dueValue = double.tryParse(map['dueValue'] ?? '')
      ..dueDate = map['dueDate']
      ..dtSent = map['dtSent']
      ..hasOpened = map['hasOpened']
      ..dtOpened = map['dtOpened'];
  }

  Map toJson() => {
    'id': id,
    'idCondo': idCondo,
    'idResident': idResident,
    'month': month,
    'year': year,
    'urlPdf': urlPdf,
    'dueValue': dueValue,
    'dueDate': dueDate,
    'dtSent': dtSent,
    'hasOpened': hasOpened,
    'dtOpened': dtOpened
  };

  @override
  String toString() {
    return 'BillModel(id: $id, idCondo: $idCondo, idResident: $idResident, month: $month, year: $year, urlPdf: $urlPdf, dueValue: $dueValue, dueDate: $dueDate, dtSent: $dtSent, hasOpened: $hasOpened, dtOpened: $dtOpened)';
  }
}
