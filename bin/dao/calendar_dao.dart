import 'package:intl/intl.dart';

import '../infra/database/db_configuration.dart';
import '../models/calendar_model.dart';
import 'dao.dart';

class CalendarDAO implements DAO<CalendarModel> {
  final DBConfiguration _dbConfiguration;
  CalendarDAO(this._dbConfiguration);

  @override
  Future<bool> create(CalendarModel value) async {
    DateTime dateTime = DateTime.parse(value.day!);
    String formatted = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    var result = await _dbConfiguration.execQuery(
      'INSERT INTO tb_calendar (day, event, idCondo) VALUES (:day, :event, :idCondo)',
      {'day': formatted, 'event': value.event, 'idCondo': value.idCondo},
    );
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery('DELETE FROM tb_calendar WHERE id = :id', {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<CalendarModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_calendar');
    return result.rows.map((r) => CalendarModel.fromMap(r.assoc())).toList().cast<CalendarModel>();
  }

  @override
  Future<CalendarModel?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_calendar WHERE id = :id', {'id': id});
    return result.rows.isEmpty ? null : CalendarModel.fromMap(result.rows.first.assoc());
  }

  @override
  Future<bool> update(CalendarModel value) async {
    var result = await _dbConfiguration.execQuery('UPDATE tb_calendar SET event = :event WHERE id = :id', {'event': value.event, 'id': value.id});
    return result.affectedRows.toInt() > 0;
  }

  Future<List<CalendarModel>> findAllByIdCondo(int idCondo) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_calendar WHERE idCondo = :idCondo', {'idCondo': idCondo});
    return result.rows.map((r) => CalendarModel.fromMap(r.assoc())).toList().cast<CalendarModel>();
  }
}
