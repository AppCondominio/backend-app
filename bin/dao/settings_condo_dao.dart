import '../infra/database/db_configuration.dart';
import '../models/condo_settings_model.dart';
import 'dao.dart';

class SettingsCondoDAO implements DAO<CondoSettingsModel> {
  final DBConfiguration _dbConfiguration;
  SettingsCondoDAO(this._dbConfiguration);

  @override
  Future<bool> create(CondoSettingsModel value) async {
    var result = await _dbConfiguration.execQuery(
        'INSERT INTO tb_setting_condo (isConfigurated, idCondo) VALUES (:isConfigurated, :idCondo)',
        {
          'isConfigurated': value.isConfigurated,
          'idCondo': value.idCondo
        });
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery('DELETE FROM tb_setting_condo WHERE id = :id', {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<CondoSettingsModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_setting_condo');
    return result.rows.map((r) => CondoSettingsModel.fromMap(r.assoc())).toList().cast<CondoSettingsModel>();
  }

  @override
  Future<CondoSettingsModel?> findOne(int idCondo) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_setting_condo WHERE idCondo = :idCondo', {'idCondo': idCondo});
    return result.rows.isEmpty ? null : CondoSettingsModel.fromMap(result.rows.first.assoc());
  }

  @override
  Future<bool> update(CondoSettingsModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE tb_setting_condo SET isConfigurated = :isConfigurated WHERE id = :id',
      {'isConfigurated': value.isConfigurated, 'id': value.id},
    );
    return result.affectedRows.toInt() > 0;
  }

}