import '../dao/complaint_dao.dart';
import '../models/complaint_model.dart';
import 'generic_service.dart';

class ComplaintService implements GenericService<ComplaintModel> {
  final ComplaintDAO _complaintDAO;
  ComplaintService(this._complaintDAO);

  @override
  Future<bool> delete(int id) async => _complaintDAO.delete(id);

  @override
  Future<List<ComplaintModel>> findAll() async => _complaintDAO.findAll();

  @override
  Future<ComplaintModel?> findOne(int id) async => await _complaintDAO.findOne(id);

  @override
  Future<bool> save(ComplaintModel value) async {
    if (value.id != null) {
      return await _complaintDAO.update(value);
    } else {
      return await _complaintDAO.create(value);
    }
  }

  Future<List<ComplaintModel>> findAllByIdCondo(int idCondo) async => _complaintDAO.findAllByIdCondo(idCondo);

  Future<List<ComplaintModel>> findAllByIdResident(int idResident) async => _complaintDAO.findAllByIdResident(idResident);

}