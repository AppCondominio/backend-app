import '../dao/select_apt_dao.dart';
import '../models/condo_model.dart';
import '../models/resident_model.dart';
import '../models/user_model.dart';

class SelectAptService {
  final SelectAptDAO _dao;
  SelectAptService(this._dao);

  Future<UserModel> findUser(int id) async => await _dao.getUserById(id);
  Future<List<ResidentModel>> findResidents(int idUser) async => await _dao.getResidentByIdUser(idUser);
  Future<CondoModel> findCondo(int idCondo) async => await _dao.getCondoById(idCondo);
}
