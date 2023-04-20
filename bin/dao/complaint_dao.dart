import '../infra/database/db_configuration.dart';
import '../models/complaint_model.dart';
import 'dao.dart';

class ComplaintDAO implements DAO<ComplaintModel> {
  final DBConfiguration _dbConfiguration;
  ComplaintDAO(this._dbConfiguration);

  // Ao Criar a reclamacao preciso adicionar o nome, sobrenome e telefone de quem realizou, além do idResident
  // Caso o `Resident` nao esteja mais disponivel (null) mostrar uma observacao em amarelo, onde diz que ATUALMENTE não a morador

  @override
  Future<bool> create(ComplaintModel value) async {
    var result = await _dbConfiguration.execQuery(
        'INSERT INTO tb_complaint (namePersonCreated,lastNamePersonCreated,phonePersonCreated,topic,description,attached,idCondo,idResident) VALUES (:namePersonCreated,:lastNamePersonCreated,:phonePersonCreated,:topic,:description,:attached,:idCondo,:idResident)',
        {
          'namePersonCreated': value.namePersonCreated,
          'lastNamePersonCreated': value.lastNamePersonCreated,
          'phonePersonCreated': value.phonePersonCreated,
          'topic': value.topic,
          'description': value.description,
          'attached': value.attached,
          'idCondo': value.idCondo,
          'idResident': value.idResident
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
    var result = await _dbConfiguration.execQuery(
        'SELECT c.*, r.apartament, r.optApartament, u.name, u.lastName ,u.phone FROM tb_complaint AS c JOIN tb_resident AS r ON r.id = c.idResident JOIN tb_user as u on u.id = r.idUser WHERE c.id = :id',
        {'id': id});
    if (result.rows.isEmpty) {
      result = await _dbConfiguration.execQuery('SELECT c.*, r.apartament, r.optApartament FROM tb_complaint AS c JOIN tb_resident AS r ON r.id = c.idResident WHERE c.id = :id', {'id': id});
    }
    return result.rows.isEmpty ? null : ComplaintModel.fromMap(result.rows.first.assoc());
  }

  @override
  Future<bool> update(ComplaintModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE tb_complaint SET obs = :obs, status = :status WHERE id = :id',
      {'obs': value.obs, 'status': value.status, 'id': value.id},
    );
    return result.affectedRows.toInt() > 0;
  }

  Future<List<ComplaintModel>> findAllByIdCondo(int idCondo) async {
    var result = await _dbConfiguration
        .execQuery('SELECT c.*, r.apartament, r.optApartament FROM tb_complaint AS c JOIN tb_resident AS r ON r.id = c.idResident WHERE c.idCondo = :idCondo', {'idCondo': idCondo});
    return result.rows.map((r) => ComplaintModel.fromMap(r.assoc())).toList().cast<ComplaintModel>();
  }

  Future<List<ComplaintModel>> findAllByIdResident(int idResident) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_complaint WHERE idResident = :idResident', {'idResident': idResident});
    return result.rows.map((r) => ComplaintModel.fromMap(r.assoc())).toList().cast<ComplaintModel>();
  }
}
