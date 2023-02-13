// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

class RecreationModel {
  final int? id;
  final String name;
  final double? price;
  final List availability;
  final String dtCreated;
  final String? dtUpdated;
  final String? status;

  RecreationModel(
    this.id,
    this.name,
    this.price,
    this.availability,
    this.dtCreated,
    this.dtUpdated,
    this.status,
  );

  factory RecreationModel.fromJson(Map map) {
    return RecreationModel(
        map['id'] ?? '',
        map['name'],
        map['price'] ?? 0.00,
        map['availability'],
        map['dtCreated'] ??
            DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        map['dtUpdated'] != null
            ? DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
            : null,
        map['status'] ?? 'A');
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'availability': availability,
      'dtCreated': dtCreated,
      'dtUpdated': dtUpdated,
      'status': status,
    };
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'availability': availability,
        'dtCreated': dtCreated,
        'dtUpdated': dtUpdated,
        'status': status,
      };

  @override
  String toString() {
    return 'RecreationModel(id: $id, nome: $name, price: $price, availability: $availability, dtCreated: $dtCreated, dtUpdated: $dtUpdated, status: $status)';
  }
}
