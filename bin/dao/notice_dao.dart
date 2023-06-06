import 'dart:async';

import '../infra/database/db_configuration.dart';
import '../models/notice_model.dart';
import 'dao.dart';

class NoticeDAO implements DAO<NoticeModel> {
  final DBConfiguration _dbConfiguration;
  NoticeDAO(this._dbConfiguration);

  @override
  Future<bool> create(NoticeModel value) async {
    DateTime today = DateTime.now();
    int days = int.parse(value.dtToDelete!);
    value.dtToDelete = today.add(Duration(days: days)).toString();
    var result = await _dbConfiguration.execQuery(
      'INSERT INTO tb_notices (title,description,attached,dtToDelete,idCondo) VALUES (:title,:description,:attached,:dtToDelete,:idCondo)',
      {'title': value.title, 'description': value.description, 'attached': value.attached, 'dtToDelete': value.dtToDelete, 'idCondo': value.idCondo},
    );
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery('DELETE FROM tb_notices WHERE id = :id', {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<NoticeModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_notices');
    return result.rows.map((r) => NoticeModel.fromMap(r.assoc())).toList().cast<NoticeModel>();
  }

  @override
  Future<NoticeModel?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_notices WHERE id = :id', {'id': id});
    return result.rows.isEmpty ? null : NoticeModel.fromMap(result.rows.first.assoc());
  }

  @override
  Future<bool> update(NoticeModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE tb_notices SET status = :status, dtUpdated = :dtUpdated WHERE id = :id',
      {'status': value.status, 'dtUpdated': DateTime.now(), 'id': value.id},
    );
    return result.affectedRows.toInt() > 0;
  }

  Future<List<NoticeModel>> findAllByIdCondo(int idCondo) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_notices WHERE idCondo = :idCondo', {'idCondo': idCondo});
    return result.rows.map((r) => NoticeModel.fromMap(r.assoc())).toList().cast<NoticeModel>();
  }

  Future<List<NoticeModel>> findAllByStatus(int idCondo, String stauts) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_notices WHERE idCondo = :idCondo AND status = :status', {'idCondo': idCondo, 'status':stauts});
    return result.rows.map((r) => NoticeModel.fromMap(r.assoc())).toList().cast<NoticeModel>();
  }

  Future<bool> deleteByDate() async {
    var result = await _dbConfiguration.execQuery('DELETE FROM tb_notices WHERE dtToDelete <= :today AND status = :status', {'today': DateTime.now(), 'status': 'A'});
    return result.affectedRows.toInt() > 0;
  }

  void scheduleDeleteNotice() {
    const dayDuration = Duration(hours: 24);
    print('${DateTime.now()} [Trying to delete notices]');
    Timer.periodic(dayDuration, (_) async {
      try {
        await deleteByDate();
        print('[DELETE] -> ${DateTime.now()} - Deleted notice');
      } catch (e) {
        print('[ERROR] [DELETE/REMINDER] -> $e');
      }
    });
  }
}
