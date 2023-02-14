import '../models/recreation_model.dart';
import 'generic_service.dart';

class RecreationService implements GenericService<RecreationModel> {
  final List<RecreationModel> _fakeDB = [];

  @override
  bool delete(int id) {
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  List<RecreationModel> findAll() {
    return _fakeDB;
  }

  @override
  RecreationModel findOne(int id) {
    return _fakeDB.firstWhere((e) => e.id == id);
  }

  @override
  bool save(RecreationModel value) {
    _fakeDB.add(value);
    return true;
  }

  @override
  bool deleteAll() {
    _fakeDB.clear();
    return true;
  }
}
