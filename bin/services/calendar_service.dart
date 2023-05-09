import '../dao/calendar_dao.dart';
import '../models/calendar_model.dart';
import 'generic_service.dart';

class CalendarService implements GenericService<CalendarModel> {
  final CalendarDAO _calendarDAO;
  CalendarService(this._calendarDAO);

  @override
  Future<bool> delete(int id) async => await _calendarDAO.delete(id);

  @override
  Future<List<CalendarModel>> findAll() async => await _calendarDAO.findAll();

  @override
  Future<CalendarModel?> findOne(int id) async => await _calendarDAO.findOne(id);

  @override
  Future<bool> save(CalendarModel value) async {
    if (value.id != null) {
      return await _calendarDAO.update(value);
    } else {
      return await _calendarDAO.create(value);
    }
  }

  Future<List<CalendarModel>> findAllByIdCondo(int idCondo) async => await _calendarDAO.findAllByIdCondo(idCondo);
}