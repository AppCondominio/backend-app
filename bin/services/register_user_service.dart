import 'package:password_dart/password_dart.dart';

import '../dao/user_dao.dart';
import '../models/user_model.dart';
import 'generic_service.dart';

class RegisterUserService implements GenericService<UserModel> {
  final UserDAO _userDAO;
  RegisterUserService(this._userDAO);

  @override
  Future<bool> delete(int id) async {
    return await _userDAO.delete(id);
  }

  @override
  Future<List<UserModel>> findAll() async {
    return await _userDAO.findAll();
  }

  @override
  Future<UserModel?> findOne(int id) async {
    return await _userDAO.findOne(id);
  }

  @override
  Future<bool> save(UserModel value) async {
    if (value.id != null) {
      return await _userDAO.update(value);
    } else {
      final String generatedPassword = '${value.name}${value.document!.substring(0, 3)}';
      print(generatedPassword);
      final hash = Password.hash(generatedPassword, PBKDF2());
      value.password = hash;
      return await _userDAO.create(value);
    }
  }

  Future<UserModel?> findByDocument(String document) async => await _userDAO.findByDocument(document);
}
