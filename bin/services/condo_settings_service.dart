import '../dao/settings_condo_dao.dart';
import '../models/condo_settings_model.dart';
import 'generic_service.dart';

class CondoSettingsService implements GenericService<CondoSettingsModel> {
  final SettingsCondoDAO _settingsCondoDAO;
  CondoSettingsService(this._settingsCondoDAO);

  @override
  Future<bool> delete(int id) async => await _settingsCondoDAO.delete(id);

  @override
  Future<List<CondoSettingsModel>> findAll() async => await _settingsCondoDAO.findAll();

  @override
  Future<CondoSettingsModel?> findOne(int idCondo) async => await _settingsCondoDAO.findOne(idCondo);

  @override
  Future<bool> save(CondoSettingsModel value) async {
    if (value.id != null) {
      return await _settingsCondoDAO.update(value);
    } else {
      return await _settingsCondoDAO.create(value);
    }
  }
}
