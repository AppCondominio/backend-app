import 'dart:convert';

class AuthTO {
  final String document;
  final String password;

  AuthTO(this.document, this.password);

  factory AuthTO.fromRequest(String body) {
    var map = jsonDecode(body);
    return AuthTO(map['document'], map['password']);
  }
}
