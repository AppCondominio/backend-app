import '../dao/condo_dao.dart';
import '../models/condo_model.dart';
import 'generic_service.dart';

class RegisterCondoService implements GenericService<CondoModel> {
  final CondoDAO _condoDAO;
  RegisterCondoService(this._condoDAO);

  @override
  Future<bool> delete(int id) async => await _condoDAO.delete(id);

  @override
  Future<List<CondoModel>> findAll() async => await _condoDAO.findAll();

  @override
  Future<CondoModel?> findOne(int id) async => await _condoDAO.findOne(id);

  @override
  Future<bool> save(CondoModel value) async {
    if (value.id != null) {
      return _condoDAO.update(value);
    } else {
      return _condoDAO.create(value);
    }
  }
}
