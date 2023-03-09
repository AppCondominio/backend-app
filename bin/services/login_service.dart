import 'dart:developer';

import 'package:password_dart/password_dart.dart';

import '../to/auth_to.dart';
import 'register_condo_service.dart';
import 'register_user_service.dart';

class LoginService {
  final RegisterCondoService _registerCondoService;
  final RegisterUserService _registerUserService;
  LoginService(this._registerCondoService, this._registerUserService);

  Future<int> authenticate(AuthTO to) async {
    // buscar pelo documento
    try {
      var user = await _registerUserService.findByDocument(to.document);
      var condo = await _registerCondoService.findByDocument(to.document);
      if (condo == null && user == null) {
        return -1;
      } else if (condo != null && Password.verify(to.password, condo.password!)) {
        return condo.id!;
      } else if (user != null && Password.verify(to.password, user.password!)) {
        return user.id!;
      } else {
        return -1;
      }
    } catch (e) {
      log('ERROR/DB -> Cant validate the request');
    }
    return -1;
  }
}
