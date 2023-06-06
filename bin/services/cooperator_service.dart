import '../dao/cooperator_settings_dao.dart';
import '../models/cooperator_model.dart';
import 'generic_service.dart';

class CooperatorService implements GenericService<CooperatorModel> {
  final CooperatorSettingsDAO _cooperatorSettingsDAO;
  CooperatorService(this._cooperatorSettingsDAO);

  @override
  Future<bool> delete(int id) async => await _cooperatorSettingsDAO.delete(id);

  @override
  Future<List<CooperatorModel>> findAll() async => await _cooperatorSettingsDAO.findAll();

  @override
  Future<CooperatorModel?> findOne(int id) async => await _cooperatorSettingsDAO.findOne(id);

  @override
  Future<bool> save(CooperatorModel value) async {
    if (value.id != null) {
      return await _cooperatorSettingsDAO.update(value);
    } else {
      return await _cooperatorSettingsDAO.create(value);
    }
  }

  Future<List<CooperatorModel>> findAllBySetting(int idSettingCondo) async => await _cooperatorSettingsDAO.findAllBySetting(idSettingCondo);

}
