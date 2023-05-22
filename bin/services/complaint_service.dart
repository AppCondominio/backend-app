import 'package:intl/intl.dart';

import '../dao/complaint_dao.dart';
import '../models/complaint_model.dart';
import 'generic_service.dart';

class ComplaintService implements GenericService<ComplaintModel> {
  final ComplaintDAO _complaintDAO;
  ComplaintService(this._complaintDAO);

  @override
  Future<bool> delete(int id) async => await _complaintDAO.delete(id);

  @override
  Future<List<ComplaintModel>> findAll() async => await _complaintDAO.findAll();

  @override
  Future<ComplaintModel?> findOne(int id) async {
    var complaint = await _complaintDAO.findOne(id);
    if (complaint == null) return null;
    DateTime? dtCreatedDT = DateTime.tryParse(complaint.dtCreated!);
    complaint.dtCreated = DateFormat('dd/MM/yyyy - HH:mm').format(dtCreatedDT!);
    if (complaint.status == 'A') complaint.status = 'Ativo';
    if (complaint.status == 'R') complaint.status = 'Resolvido';
    if (complaint.status == 'U') complaint.status = 'Não resolvido';
    if (complaint.status == 'L') complaint.status = 'Lido';
    if (complaint.status == 'N') complaint.status = 'Não lido';
    return complaint;
  }

  @override
  Future<bool> save(ComplaintModel value) async {
    if (value.id != null) {
      return await _complaintDAO.update(value);
    } else {
      return await _complaintDAO.create(value);
    }
  }

  Future<List<ComplaintModel>> findAllByIdCondo(int idCondo) async {
    // A = Ativo
    // R = Resolvido
    // L = Lido
    // N = Não Lido

    var complaints = await _complaintDAO.findAllByIdCondo(idCondo);
    for (var c in complaints) {
      DateTime? dtCreatedDT = DateTime.tryParse(c.dtCreated!);
      DateTime? dtUpdatedDT;
      if (c.dtUpdated != null) {
        dtUpdatedDT = DateTime.tryParse(c.dtUpdated!);
        c.dtUpdated = DateFormat('dd/MM/yyyy - HH:mm').format(dtUpdatedDT!);
      }
      c.dtCreated = DateFormat('dd/MM/yyyy - HH:mm').format(dtCreatedDT!);
      if (c.status == 'A') c.status = 'Ativo';
      if (c.status == 'R') c.status = 'Resolvido';
      if (c.status == 'U') c.status = 'Não resolvido';
      if (c.status == 'L') c.status = 'Lido';
      if (c.status == 'N') c.status = 'Não lido';
    }
    return complaints;
  }

  Future<List<ComplaintModel>> findAllByIdResident(int idResident) async => _complaintDAO.findAllByIdResident(idResident);
}
