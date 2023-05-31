import 'package:intl/intl.dart';

import '../infra/database/db_configuration.dart';
import '../models/bill_model.dart';
import 'dao.dart';

class BillDAO implements DAO<BillModel> {
  final DBConfiguration _dbConfiguration;
  BillDAO(this._dbConfiguration);

  String _formatDateToMySQL(String dateStr) {
    DateTime date = DateFormat('dd/MM/yyyy').parse(dateStr);
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }

  @override
  Future<bool> create(BillModel value) async {
    var result = await _dbConfiguration.execQuery(
      'INSERT INTO tb_bill (idCondo, idResident, month, year, urlPdf, dueValue, dueDate, hasOpened, dtOpened) VALUES (:idCondo, :idResident, :month, :year, :urlPdf, :dueValue, :dueDate, :hasOpened, :dtOpened)',
      {
        'idCondo': value.idCondo,
        'idResident': value.idResident,
        'month': value.month,
        'year': value.year,
        'urlPdf': value.urlPdf,
        'dueValue': value.dueValue,
        'dueDate': _formatDateToMySQL(value.dueDate!),
        'hasOpened': false,
        'dtOpened': null
      },
    );
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery('DELETE FROM tb_bill WHERE id = :id', {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<BillModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_bill');
    return result.rows.map((r) => BillModel.fromMap(r.assoc())).toList().cast<BillModel>();
  }

  @override
  Future<BillModel?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_bill WHERE id = :id', {'id': id});
    return result.rows.map((r) => BillModel.fromMap(r.assoc())).toList().cast<BillModel>();
  }

  @override
  Future<bool> update(BillModel value) async {
    var result =
        await _dbConfiguration.execQuery('UPDATE tb_bill SET hasOpened = :hasOpened, dtOpened = :dtOpened WHERE id = :id', {'hasOpened': value.hasOpened, 'dtOpened': value.dtOpened, 'id': value.id});
    return result.affectedRows.toInt() > 0;
  }

  Future<List<BillModel>> findAllByIdCondo(int idCondo) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_bill WHERE idCondo = :idCondo', {'idCondo': idCondo});
    return result.rows.map((r) => BillModel.fromMap(r.assoc())).toList().cast<BillModel>();
  }

  Future<List<Map<String, dynamic>>> findAllForBillTable(int idCondo) async {
    var result = await _dbConfiguration.execQuery('SELECT bill.month, bill.year, bill.dtSent, bill.hasOpened, bill.dtOpened, resident.apartament, resident.optApartament FROM tb_bill AS bill JOIN tb_resident AS resident ON resident.id = bill.idResident WHERE bill.idCondo = :idCondo', {'idCondo': idCondo});
    return result.rows.map((r) => r.assoc()).toList().cast<Map<String,dynamic>>();
  }

  Future<List<BillModel>> findAllByIdResident(int idResident, String year) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_bill WHERE idResident = :idResident AND year = :year', {'idResident': idResident, 'year': year});
    return result.rows.map((r) => BillModel.fromMap(r.assoc())).toList().cast<BillModel>();
  }
}
