import '../infra/database/db_configuration.dart';
import '../models/tower_settings_model.dart';
import 'dao.dart';

class TowerSettingDAO implements DAO<TowerSettingsModel> {
  final DBConfiguration _dbConfiguration;
  TowerSettingDAO(this._dbConfiguration);

  @override
  Future<bool> create(TowerSettingsModel value) async {
    var result = await _dbConfiguration.execQuery(
        'INSERT INTO tb_tower_settings (name, idSettingCondo) VALUES (:name, :idSettingCondo)',
        {
          'name': value.name,
          'idSettingCondo': value.idSettingCondo
        });
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery('DELETE FROM tb_tower_settings WHERE id = :id', {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<TowerSettingsModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_tower_settings');
    return result.rows.map((r) => TowerSettingsModel.fromMap(r.assoc())).toList().cast<TowerSettingsModel>();
  }

  @override
  Future<TowerSettingsModel?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_tower_settings WHERE id = :id', {'id': id});
    return result.rows.isEmpty ? null : TowerSettingsModel.fromMap(result.rows.first.assoc());
  }

  @override
  Future<bool> update(TowerSettingsModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE tb_tower_settings SET name = :name, dtUpdated = :dtUpdated WHERE id = :id',
      {'name': value.name, 'dtUpdated': DateTime.now(), 'id': value.id},
    );
    return result.affectedRows.toInt() > 0;
  }

  Future<List<TowerSettingsModel>> findAllBySetting(int idSettingCondo) async {
    var result =
        await _dbConfiguration.execQuery('SELECT * FROM tb_tower_settings WHERE idSettingCondo = :idSettingCondo', {'idSettingCondo': idSettingCondo});
    return result.rows.map((r) => TowerSettingsModel.fromMap(r.assoc())).toList().cast<TowerSettingsModel>();
  }
}