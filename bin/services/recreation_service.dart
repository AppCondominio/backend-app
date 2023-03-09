import '../dao/recreation_settings_dao.dart';
import '../models/recreation_model.dart';
import 'generic_service.dart';

class RecreationService implements GenericService<RecreationModel> {
  final RecreationSettingDAO _recreationSettingDAO;
  RecreationService(this._recreationSettingDAO);

  @override
  Future<bool> delete(int id) async => await _recreationSettingDAO.delete(id);

  @override
  Future<List<RecreationModel>> findAll() async => await _recreationSettingDAO.findAll();

  @override
  Future<RecreationModel?> findOne(int id) async => await _recreationSettingDAO.findOne(id);

  @override
  Future<bool> save(RecreationModel value) async {
    if (value.id != null) {
      return await _recreationSettingDAO.update(value);
    } else {
      return await _recreationSettingDAO.create(value);
    }
  }

  Future<List<RecreationModel>> findAllBySetting(int idSettingCondo) async => await _recreationSettingDAO.findAllBySetting(idSettingCondo);
}
