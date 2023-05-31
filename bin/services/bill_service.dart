import '../dao/bill_dao.dart';
import '../models/bill_model.dart';
import 'generic_service.dart';

class BillService implements GenericService<BillModel> {
  final BillDAO _billDAO;
  BillService(this._billDAO);

  @override
  Future<bool> delete(int id) async => await _billDAO.delete(id);

  @override
  Future<List<BillModel>> findAll() async => await _billDAO.findAll();

  @override
  Future<BillModel?> findOne(int id) async => await _billDAO.findOne(id);

  @override
  Future<bool> save(BillModel value) async {
    if (value.id != null) {
      return await _billDAO.update(value);
    } else {
      return await _billDAO.create(value);
    }
  }

  Future<List<BillModel>> findAllByIdCondo(int idCondo) async => await _billDAO.findAllByIdCondo(idCondo);

  Future<List<Map<String, dynamic>>> findAllForBillTable(int idCondo) async => await _billDAO.findAllForBillTable(idCondo);

  Future<List<BillModel>> findAllByIdResident(int idResident, String year) async => await _billDAO.findAllByIdResident(idResident, year);
}
