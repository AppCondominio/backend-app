import 'dart:async';

import '../infra/database/db_configuration.dart';
import '../models/reminder_model.dart';
import 'dao.dart';

class ReminderDAO implements DAO<ReminderModel> {
  final DBConfiguration _dbConfiguration;
  ReminderDAO(this._dbConfiguration);

  @override
  Future<bool> create(ReminderModel value) async {
    var result = await _dbConfiguration
        .execQuery('INSERT INTO tb_reminder (title, description, idCondo) VALUES (:title, :description, :idCondo)', {'title': value.title, 'description': value.description, 'idCondo': value.idCondo});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery('DELETE FROM tb_reminder WHERE id = :id', {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<ReminderModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_reminder');
    return result.rows.map((r) => ReminderModel.fromMap(r.assoc())).toList().cast<ReminderModel>();
  }

  @override
  Future<ReminderModel?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_reminder WHERE id = :id', {'id': id});
    return result.rows.isEmpty ? null : ReminderModel.fromMap(result.rows.first.assoc());
  }

  @override
  Future<bool> update(ReminderModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE tb_reminder SET title = :title, description = :description WHERE id = :id',
      {'title': value.title, 'description': value.description, 'id': value.id},
    );
    return result.affectedRows.toInt() > 0;
  }

  Future<List<ReminderModel>> findAllByIdCondo(int idCondo) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_reminder WHERE idCondo = :idCondo', {'idCondo': idCondo});
    return result.rows.map((r) => ReminderModel.fromMap(r.assoc())).toList().cast<ReminderModel>();
  }

  Future<void> deleteOldRecord() async {
    final sixtyDays = DateTime.now().add(Duration(days: 60));
    await _dbConfiguration.execQuery('DELETE FROM tb_reminder WHERE dtCreated < :date', {'date': sixtyDays.toString()});
  }

  void scheduleDeleteReminder() {
    const dayDuration = Duration(hours: 24);
    print('${DateTime.now()} [Trying to delete reminder]');
    Timer.periodic(dayDuration, (_) async {
      try {
        await deleteOldRecord();
        print('[DELETE] -> ${DateTime.now()} - Delete old record');
      } catch (e) {
        print('[ERROR] [DELETE/REMINDER] -> $e');
      }
    });
  }
}
