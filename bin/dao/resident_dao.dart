import '../infra/database/db_configuration.dart';
import '../models/resident_model.dart';
import 'dao.dart';

class ResidentDAO implements DAO<ResidentModel> {
  final DBConfiguration _dbConfiguration;
  ResidentDAO(this._dbConfiguration);

  @override
  Future<bool> create(ResidentModel value) async {
    var result = await _dbConfiguration.execQuery(
        'INSERT INTO tb_resident (apartament, optApartament, isRental, idUser, idCondo) VALUES (:apartament, :optApartament, :isRental, :idUser, :idCondo)',
        {
          'apartament': value.apartament,
          'optApartament': value.optApartament,
          'isRental': value.isRental,
          'idUser': value.idUser,
          'idCondo': value.idCondo
        });
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery('DELETE FROM tb_resident WHERE id = :id', {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<ResidentModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_resident');
    return result.rows.map((r) => ResidentModel.fromMap(r.assoc())).toList().cast<ResidentModel>();
  }

  @override
  Future<ResidentModel?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_resident WHERE id = :id', {'id': id});
    return result.rows.isEmpty ? null : ResidentModel.fromMap(result.rows.first.assoc());
  }

  @override
  Future<bool> update(ResidentModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE tb_resident SET isRental = :isRental, idUser = :idUser WHERE id = :id',
      {'isRental': value.isRental, 'idUser': value.idUser, 'id': value.id},
    );
    return result.affectedRows.toInt() > 0;
  }

  Future<List<ResidentModel>> findAllByCondo(int idCondo) async {
    var result =
        await _dbConfiguration.execQuery('SELECT * FROM tb_resident WHERE idCondo = :idCondo', {'idCondo': idCondo});
    return result.rows.map((r) => ResidentModel.fromMap(r.assoc())).toList().cast<ResidentModel>();
  }
}