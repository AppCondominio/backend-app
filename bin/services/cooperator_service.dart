import '../models/cooperator_model.dart';
import 'generic_service.dart';

class CooperatorService implements GenericService<CooperatorModel> {
  final List<CooperatorModel> _fakeDB = [];

  @override
  bool delete(int id) {
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  List<CooperatorModel> findAll() {
    return _fakeDB;
  }

  @override
  CooperatorModel findOne(int id) {
    return _fakeDB.firstWhere((e) => e.id == id);
  }

  @override
  bool save(CooperatorModel value) {
    _fakeDB.add(value);
    return true;
  }
  
  @override
  bool deleteAll() {
    _fakeDB.clear();
    return true;
  }
}
