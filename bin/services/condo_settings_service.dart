import '../models/condo_settings_model.dart';
import 'generic_service.dart';

class CondoSettingsService implements GenericService<CondoSettingsModel> {
  final List<CondoSettingsModel> _fakeDB = [];

  @override
  Future<bool> delete(int id) async {
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  Future<List<CondoSettingsModel>> findAll() async {
    return _fakeDB;
  }

  @override
  Future<CondoSettingsModel?> findOne(int idCondo) async {
    return _fakeDB.firstWhere((e) => e.idCondo == idCondo);
  }

  @override
  Future<bool> save(CondoSettingsModel value) async {
    _fakeDB.add(value);
    return true;
  }
}
