import '../dao/schedule_dao.dart';
import '../models/schedule_model.dart';
import 'generic_service.dart';

class ScheduleService implements GenericService<ScheduleModel> {
  final ScheduleDAO _scheduleDAO;
  ScheduleService(this._scheduleDAO);

  @override
  Future<bool> delete(int id) async => await _scheduleDAO.delete(id);

  @override
  Future<List<ScheduleModel>> findAll() async => await _scheduleDAO.findAll();

  @override
  Future<ScheduleModel?> findOne(int id) async => await _scheduleDAO.findOne(id);

  @override
  Future<bool> save(ScheduleModel value) async {
    if (value.id != null) {
      return await _scheduleDAO.update(value);
    } else {
      return await _scheduleDAO.create(value);
    }
  }

  Future<List<ScheduleModel>> findAllByIdCondo(int idCondo) async => await _scheduleDAO.findAllByIdCondo(idCondo);

  Future<List<ScheduleModel>> findAllByUser(int idUser) async => await _scheduleDAO.findAllByUser(idUser);

  Future<List<ScheduleModel>> findAllByRecreation(int idRecreation) async => await _scheduleDAO.findAllByRecration(idRecreation);

  Future<int?> getLastInsertedId() async => await _scheduleDAO.getLastInsertedId();
}
