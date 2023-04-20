import 'dart:collection';
import 'dart:convert';

class RecreationModel {
  int? id;
  String? name;
  double? price;
  Map<String, dynamic>? availability;
  String? dtCreated;
  String? dtUpdated;
  String? status;
  int? idSettingCondo;

  RecreationModel();

  factory RecreationModel.fromMap(Map map) {
    return RecreationModel()
      ..id = int.parse(map['id'])
      ..name = map['name']
      ..price = double.parse(map['price'])
      ..availability = jsonDecode(map['availability'])
      ..dtCreated = map['dtCreated']
      ..dtUpdated = map['dtUpdated']
      ..status = map['status']
      ..idSettingCondo = int.parse(map['idSettingCondo']);
  }

  factory RecreationModel.fromRequest(Map map) {
    return RecreationModel()
      ..id = map['id']
      ..name = map['name']
      ..price = map['price']
      ..availability = map['availability']
      ..idSettingCondo = map['idSettingCondo'];
  }

  Map toJson() {
    Map<String, bool> diasDaSemana = LinkedHashMap<String, bool>();
    for (String dia in ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab']) {
      diasDaSemana[dia] = availability![dia];
    }
    return {
      'id': id,
      'name': name,
      'price': price,
      'availability': diasDaSemana,
      'dtCreated': dtCreated,
      'dtUpdated': dtUpdated,
      'status': status,
      'idSettingCondo': idSettingCondo
    };
  }

  @override
  String toString() {
    return 'RecreationModel(id: $id, nome: $name, price: $price, availability: $availability, dtCreated: $dtCreated, dtUpdated: $dtUpdated, status: $status)';
  }
}
