import '../infra/database/db_configuration.dart';
import '../models/cooperator_model.dart';
import 'dao.dart';

class CooperatorSettingsDAO implements DAO<CooperatorModel> {
  final DBConfiguration _dbConfiguration;
  CooperatorSettingsDAO(this._dbConfiguration);

  @override
  Future<bool> create(CooperatorModel value) async {
    var result = await _dbConfiguration.execQuery(
        'INSERT INTO tb_cooperators_settings (name,document,job,idSettingCondo) VALUES (:name,:document,:job,:idSettingCondo)',
        {'name': value.name, 'document': value.document, 'job': value.job, 'idSettingCondo': value.idSettingCondo});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery('DELETE FROM tb_cooperators_settings WHERE id = :id', {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<CooperatorModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_cooperators_settings');
    return result.rows.map((r) => CooperatorModel.fromMap(r.assoc())).toList().cast<CooperatorModel>();
  }

  @override
  Future<CooperatorModel?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_cooperators_settings WHERE id = :id', {'id': id});
    return result.rows.isEmpty ? null : CooperatorModel.fromMap(result.rows.first.assoc());
  }

  @override
  Future<bool> update(CooperatorModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE tb_cooperators_settings SET name = :name, document = :document, job = :job, dtUpdated = :dtUpdated WHERE id = :id',
      {'name': value.name, 'document': value.document, 'job': value.job, 'dtUpdated': DateTime.now(), 'id': value.id},
    );
    return result.affectedRows.toInt() > 0;
  }

  Future<List<CooperatorModel>> findAllBySetting(int idSettingCondo) async {
    var result =
        await _dbConfiguration.execQuery('SELECT * FROM tb_cooperators_settings WHERE idSettingCondo = :idSettingCondo', {'idSettingCondo': idSettingCondo});
    return result.rows.map((r) => CooperatorModel.fromMap(r.assoc())).toList().cast<CooperatorModel>();
  }
}
