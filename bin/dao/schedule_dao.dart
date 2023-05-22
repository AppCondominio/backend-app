import '../infra/database/db_configuration.dart';
import '../models/schedule_model.dart';
import 'dao.dart';

class ScheduleDAO implements DAO<ScheduleModel> {
  final DBConfiguration _dbConfiguration;
  ScheduleDAO(this._dbConfiguration);

  @override
  Future<bool> create(ScheduleModel value) async {
    var result = await _dbConfiguration.execQuery(
      'INSERT INTO tb_schedules (local, dtScheduled, wasPaid, idUser, idCondo, idResident, idRecreation) VALUES (:local,:dtScheduled,:wasPaid,:idUser,:idCondo,:idResident,:idRecreation)',
      {'local': value.local, 'dtScheduled': value.dtScheduled, 'wasPaid': value.wasPaid, 'idUser': value.idUser, 'idCondo': value.idCondo, 'idResident': value.idResident,'idRecreation':value.idRecreation},
    );
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery('DELETE FROM tb_schedules WHERE id = :id', {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<ScheduleModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_schedules');
    return result.rows.map((r) => ScheduleModel.fromMap(r.assoc())).toList().cast<ScheduleModel>();
  }

  @override
  Future<ScheduleModel?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_schedules WHERE id = :id', {'id': id});
    return result.rows.isEmpty ? null : ScheduleModel.fromMap(result.rows.first.assoc());
  }

  @override
  Future<bool> update(ScheduleModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE tb_schedules SET wasPaid = :wasPaid WHERE id = :id',
      {'wasPaid': value.wasPaid, 'id': value.id},
    );
    return result.affectedRows.toInt() > 0;
  }

  Future<List<ScheduleModel>> findAllByIdCondo(int idCondo) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_schedules WHERE idCondo = :idCondo', {'idCondo': idCondo});
    return result.rows.map((r) => ScheduleModel.fromMap(r.assoc())).toList().cast<ScheduleModel>();
  }

  Future<List<ScheduleModel>> findAllByUser(int idUser) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_schedules WHERE idUser = :idUser', {'idUser': idUser});
    return result.rows.map((r) => ScheduleModel.fromMap(r.assoc())).toList().cast<ScheduleModel>();
  }

  Future<List<ScheduleModel>> findAllByRecration(int idRecreation) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_schedules WHERE idRecreation = :idRecreation', {'idRecreation': idRecreation});
    return result.rows.map((r) => ScheduleModel.fromMap(r.assoc())).toList().cast<ScheduleModel>();
  }

  Future<int?> getLastInsertedId() async {
    var result = await _dbConfiguration.execQuery('SELECT LAST_INSERT_ID() as id');
    final row = result.rows.first.assoc();
    final insertedId = int.parse(row?['id']);
    return insertedId;
  }
}
