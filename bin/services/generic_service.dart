abstract class GenericService<T> {
  T findOne(int id);
  List<T> findAll();
  bool save(T value);
  bool delete(int id);
  bool deleteAll();
  //bool update(int id);
}
