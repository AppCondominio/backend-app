import '../models/warning_model.dart';
import 'generic_service.dart';

class WarningService implements GenericService<WarningModel> {
  final List<WarningModel> _fakeDB = [];

  @override
  Future<bool> delete(int id) async {
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  Future<List<WarningModel>> findAll() async {
    return _fakeDB;
  }

  @override
  Future<WarningModel?> findOne(int idCondo) async {
    return _fakeDB.firstWhere((e) => e.idCondo == idCondo);
  }

  @override
  Future<bool> save(WarningModel value) async {
    _fakeDB.add(value);
    return true;
  }
}
