import 'package:cantor_app/features/cantos/domain/canto.dart';
import 'package:cantor_app/features/cantos/domain/canto_repository.dart';
import 'canto_isar_dao.dart';

class CantoRepositoryImpl implements CantoRepository {
  final CantoIsarDao _dao;

  CantoRepositoryImpl(this._dao);

  @override
  Future<List<Canto>> getAll() => _dao.getAll();

  @override
  Stream<List<Canto>> watchAll() => _dao.watchAll();

  @override
  Future<Canto?> getById(int id) => _dao.getById(id);

  @override
  Future<Canto?> getByUuid(String uuid) => _dao.getByUuid(uuid);

  @override
  Future<List<Canto>> search(String query) => _dao.search(query);

  @override
  Future<List<Canto>> getByCategoria(String categoria) =>
      _dao.getByCategoria(categoria);

  @override
  Future<List<Canto>> getByTiempo(String tiempo) async {
    final all = await _dao.getAll();
    return all.where((c) => c.tiempos.contains(tiempo)).toList();
  }

  @override
  Future<int> save(Canto canto) => _dao.save(canto);

  @override
  Future<bool> delete(int id) => _dao.delete(id);
}
