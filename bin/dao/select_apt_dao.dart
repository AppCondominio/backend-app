import '../infra/database/db_configuration.dart';
import '../models/condo_model.dart';
import '../models/resident_model.dart';
import '../models/user_model.dart';

class SelectAptDAO {
  final DBConfiguration _dbConfiguration;
  SelectAptDAO(this._dbConfiguration);

  Future<UserModel> getUserById(int id) async {
    var result = await _dbConfiguration.execQuery('SELECT id, name FROM tb_user WHERE id = :id', {'id': id});
    final row = result.rows.first.assoc();
    return UserModel()
      ..id = int.parse(row['id'])
      ..name = row['name'];
  }

  Future<List<ResidentModel>> getResidentByIdUser(int idUser) async {
    var results = await _dbConfiguration.execQuery('SELECT * FROM tb_resident WHERE idUser = :idUser OR idUserRental = :idUserRental', {'idUser': idUser, 'idUserRental':idUser});
    var converted = results.rows.map((r) => r.assoc()).toList();
    var residents = <ResidentModel>[];
    for (final row in converted) {
      residents.add(ResidentModel()
        ..id = int.parse(row['id'])
        ..apartament = row['apartament']
        ..optApartament = row['optApartament']
        ..idUser = int.parse(row['idUser'])
        ..idCondo = int.parse(row['idCondo']));
    }
    return residents;
  }

  Future<CondoModel> getCondoById(int idCondo) async {
    var results = await _dbConfiguration.execQuery('SELECT id, name, zipCode FROM tb_condo WHERE id = :idCondo', {'idCondo': idCondo});
    final row = results.rows.first.assoc();
    return CondoModel()
      ..id = int.parse(row['id'])
      ..name = row['name']
      ..zipCode = row['zipCode'];
  }
}
