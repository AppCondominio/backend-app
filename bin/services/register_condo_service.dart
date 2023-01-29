import '../models/condo_model.dart';
import 'generic_service.dart';

class RegisterCondoService implements GenericService<CondoModel> {
  final List<CondoModel> _fakeDB = [];

  @override
  bool delete(int id) {
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  List<CondoModel> findAll() {
    return _fakeDB;
  }

  @override
  CondoModel findOne(int id) {
    return _fakeDB.firstWhere((e) => e.id == id);
  }

  @override
  bool save(CondoModel value) {
      _fakeDB.add(value);
    return true;
  }
}