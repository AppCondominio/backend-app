import '../models/warning_model.dart';
import 'generic_service.dart';

class WarningService implements GenericService<WarningModel> {
  final List<WarningModel> _fakeDB = [];

  @override
  bool delete(int id) {
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  List<WarningModel> findAll() {
    return _fakeDB;
  }

  @override
  WarningModel findOne(int idCondo) {
    return _fakeDB.firstWhere((e) => e.idCondo == idCondo);
  }

  @override
  bool save(WarningModel value) {
    _fakeDB.add(value);
    return true;
  }

  @override
  bool deleteAll() {
    _fakeDB.clear();
    return true;
  }
}
