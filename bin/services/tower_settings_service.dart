import '../dao/tower_settings_dao.dart';
import '../models/tower_settings_model.dart';
import 'generic_service.dart';

class TowerSettingService implements GenericService<TowerSettingsModel> {
  final TowerSettingDAO _towerSettingDAO;
  TowerSettingService(this._towerSettingDAO);

  @override
  Future<bool> delete(int id) async => await _towerSettingDAO.delete(id);

  @override
  Future<List<TowerSettingsModel>> findAll() async => await _towerSettingDAO.findAll();

  @override
  Future<TowerSettingsModel?> findOne(int id) async => await _towerSettingDAO.findOne(id);

  @override
  Future<bool> save(TowerSettingsModel value) async {
    if (value.id != null) {
      return await _towerSettingDAO.update(value);
    } else {
      return await _towerSettingDAO.create(value);
    }
  }

  Future<List<TowerSettingsModel>> findAllBySetting(int idSettingCondo) async =>
      _towerSettingDAO.findAllBySetting(idSettingCondo);
}
