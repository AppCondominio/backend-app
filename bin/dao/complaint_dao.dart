import '../infra/database/db_configuration.dart';
import '../models/complaint_model.dart';
import 'dao.dart';

class ComplaintDAO implements DAO<ComplaintModel> {
  final DBConfiguration _dbConfiguration;
  ComplaintDAO(this._dbConfiguration);

  @override
  Future<bool> create(ComplaintModel value) async {
    var result = await _dbConfiguration.execQuery(
        'INSERT INTO tb_complaint (topic,description,attached,idCondo,idResident) VALUES (:topic,:description,:attached,:idCondo,:idResident)',
        {
          'topic': value.topic,
          'description': value.description,
          'attached': value.attached,
          'idCondo': value.idCondo,
          'idResident':value.idResident
        });
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery('DELETE FROM tb_complaint WHERE id = :id', {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<ComplaintModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_complaint');
    return result.rows.map((r) => ComplaintModel.fromMap(r.assoc())).toList().cast<ComplaintModel>();
  }

  @override
  Future<ComplaintModel?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_complaint WHERE id = :id', {'id': id});
    return result.rows.isEmpty ? null : ComplaintModel.fromMap(result.rows.first.assoc());
  }

  @override
  Future<bool> update(ComplaintModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE tb_complaint SET status = :status WHERE id = :id',
      {'status': value.status, 'id': value.id},
    );
    return result.affectedRows.toInt() > 0;
  }

  Future<List<ComplaintModel>> findAllByIdCondo(int idCondo) async {
    var result =
        await _dbConfiguration.execQuery('SELECT * FROM tb_complaint WHERE idCondo = :idCondo', {'idCondo': idCondo});
    return result.rows.map((r) => ComplaintModel.fromMap(r.assoc())).toList().cast<ComplaintModel>();
  }

  Future<List<ComplaintModel>> findAllByIdResident(int idResident) async {
    var result =
        await _dbConfiguration.execQuery('SELECT * FROM tb_complaint WHERE idResident = :idResident', {'idResident': idResident});
    return result.rows.map((r) => ComplaintModel.fromMap(r.assoc())).toList().cast<ComplaintModel>();
  }
}
