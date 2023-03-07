
import '../models/user_model.dart';
import 'generic_service.dart';

class RegisterUserService implements GenericService<UserModel> {
  final List<UserModel> _fakeDB = [];

  @override
  Future<bool> delete(int id) async {
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  Future<List<UserModel>> findAll() async {
    return _fakeDB;
  }

  @override
  Future<UserModel?> findOne(int id) async {
    return _fakeDB.firstWhere((e) => e.id == id);
  }

  @override
  Future<bool> save(UserModel value) async {
      _fakeDB.add(value);
    return true;
  }
}