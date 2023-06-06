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
      return await _userDAO.create(value);
    }
  }
  Future<UserModel?> findByUid(String uid) async => await _userDAO.findByUid(uid);

  Future<UserModel?> findByDocument(String document) async => await _userDAO.findByDocument(document);

  Future<UserModel?> findByDocumentSearch(String document) async => await _userDAO.findByDocumentSearch(document);
}
