import 'package:cantor_app/features/cantos/domain/canto.dart';

abstract class CantoRepository {
  Future<List<Canto>> getAll();
  Stream<List<Canto>> watchAll();
  Future<Canto?> getById(int id);
  Future<Canto?> getByUuid(String uuid);
  Future<List<Canto>> search(String query);
  Future<List<Canto>> getByCategoria(String categoria);
  Future<List<Canto>> getByTiempo(String tiempo);
  Future<int> save(Canto canto);
  Future<bool> delete(int id);
}
