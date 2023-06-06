// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  int? id;
  String? name;
  String? lastName;
  String? document;
  String? password;
  String? email;
  String? phone;
  String? dtCreated;
  String? dtUpdated;
  String? deviceToken;
  String? status;
  String? uidFirebase;

  UserModel();

  factory UserModel.fromMap(Map map) {
    return UserModel()
      ..id = int.parse(map['id'])
      ..name = map['name']
      ..lastName = map['lastName']
      ..document = map['document']
      ..email = map['email']
      ..phone = map['phone']
      ..dtCreated = map['dtCreated']
      ..dtUpdated = map['dtUpdated']
      ..status = map['status']
      ..deviceToken = map['deviceToken'];
  }

  factory UserModel.fromMapForBill(Map map) {
    return UserModel()
      ..id = int.parse(map['id'])
      ..name = map['name']
      ..lastName = map['lastName']
      ..document = map['document'];
  }

  factory UserModel.fromRequest(Map map) {
    return UserModel()
      ..id = map['id']
      ..name = map['name']
      ..lastName = map['lastName']
      ..document = map['document']
      ..email = map['email']
      ..phone = map['phone']
      ..deviceToken = map['deviceToken']
      ..uidFirebase = map['uidFirebase'];
  }

  factory UserModel.fromDocument(Map map) {
    return UserModel()
      ..id = int.parse(map['id'])
      ..document = map['document']
      ..password = map['password'];
  }

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'deviceToken': deviceToken
    };
  }

  Map toJsonLogin() => {'id': id, 'document': document};

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, lastName: $lastName, document: $document, phone: $phone, email: $email, password: $password, dtCreated: $dtCreated, dtUpdated: $dtUpdated, deviceToken: $deviceToken, status: $status)';
  }
}
