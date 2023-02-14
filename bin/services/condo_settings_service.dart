import '../models/condo_settings_model.dart';
import 'generic_service.dart';

class CondoSettingsService implements GenericService<CondoSettingsModel> {
  final List<CondoSettingsModel> _fakeDB = [];

  @override
  bool delete(int id) {
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  List<CondoSettingsModel> findAll() {
    return _fakeDB;
  }

  @override
  CondoSettingsModel findOne(int id) {
    return _fakeDB.firstWhere((e) => e.id == id);
  }

  @override
  bool save(CondoSettingsModel value) {
    _fakeDB.add(value);
    return true;
  }
  
  @override
  bool deleteAll() {
    _fakeDB.clear();
    return true;
  }
}
