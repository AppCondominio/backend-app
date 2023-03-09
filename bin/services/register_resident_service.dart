import '../dao/resident_dao.dart';
import '../models/resident_model.dart';
import 'generic_service.dart';

class RegisterResidentService implements GenericService<ResidentModel> {
  final ResidentDAO _residentDAO;
  RegisterResidentService(this._residentDAO);

  @override
  Future<bool> delete(int id) async => await _residentDAO.delete(id);

  @override
  Future<List<ResidentModel>> findAll() async => await _residentDAO.findAll();

  @override
  Future<ResidentModel?> findOne(int id) async => await _residentDAO.findOne(id);

  @override
  Future<bool> save(ResidentModel value) async {
    if (value.id != null) {
      return await _residentDAO.update(value);
    } else {
      return await _residentDAO.create(value);
    }
  }

  Future<List<ResidentModel>> findAllByCondo(int idCondo) async => await _residentDAO.findAllByCondo(idCondo);
}
