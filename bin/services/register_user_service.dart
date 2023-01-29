import '../models/user_model.dart';
import 'generic_service.dart';

class RegisterUserService implements GenericService<UserModel> {
  final List<UserModel> _fakeDB = [];

  @override
  bool delete(int id) {
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  List<UserModel> findAll() {
    return _fakeDB;
  }

  @override
  UserModel findOne(int id) {
    return _fakeDB.firstWhere((e) => e.id == id);
  }

  @override
  bool save(UserModel value) {
      _fakeDB.add(value);
    return true;
  }
}