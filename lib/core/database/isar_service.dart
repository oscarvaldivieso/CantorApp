import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cantor_app/features/cantos/domain/canto.dart';
import 'package:cantor_app/features/hojitas/domain/hojita.dart';
import 'seed_data.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = _openDb();
  }

  Future<Isar> _openDb() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [CantoSchema, HojitaSchema],
      directory: dir.path,
    );
    await _seedIfEmpty(isar);
    return isar;
  }

  Future<void> _seedIfEmpty(Isar isar) async {
    final count = await isar.cantos.count();
    if (count == 0) {
      final cantos = SeedData.cantos();
      await isar.writeTxn(() async {
        await isar.cantos.putAll(cantos);
      });
    }
  }

  // ─── Cantos ───

  Stream<List<Canto>> watchAllCantos() async* {
    final isar = await db;
    yield* isar.cantos
        .where()
        .sortByTitulo()
        .watch(fireImmediately: true);
  }

  Future<List<Canto>> getAllCantos() async {
    final isar = await db;
    return isar.cantos.where().sortByTitulo().findAll();
  }

  Future<Canto?> getCantoById(int id) async {
    final isar = await db;
    return isar.cantos.get(id);
  }

  Future<Canto?> getCantoByUuid(String uuid) async {
    final isar = await db;
    final results =
        await isar.cantos.filter().uuidEqualTo(uuid).findAll();
    return results.isEmpty ? null : results.first;
  }

  Future<List<Canto>> searchCantos(String query) async {
    final isar = await db;
    return isar.cantos
        .filter()
        .tituloContains(query, caseSensitive: false)
        .or()
        .autorContains(query, caseSensitive: false)
        .sortByTitulo()
        .findAll();
  }

  Future<List<Canto>> getCantosByCategoria(String categoria) async {
    final isar = await db;
    return isar.cantos
        .filter()
        .categoriasElementContains(categoria)
        .sortByTitulo()
        .findAll();
  }

  Future<int> saveCanto(Canto canto) async {
    final isar = await db;
    return isar.writeTxn(() => isar.cantos.put(canto));
  }

  Future<bool> deleteCanto(int id) async {
    final isar = await db;
    return isar.writeTxn(() => isar.cantos.delete(id));
  }

  // ─── Hojitas ───

  Stream<List<Hojita>> watchAllHojitas() async* {
    final isar = await db;
    yield* isar.hojitas
        .where()
        .sortByFechaDesc()
        .watch(fireImmediately: true);
  }

  Future<List<Hojita>> getAllHojitas() async {
    final isar = await db;
    return isar.hojitas.where().sortByFechaDesc().findAll();
  }

  Future<Hojita?> getHojitaById(int id) async {
    final isar = await db;
    return isar.hojitas.get(id);
  }

  Future<int> saveHojita(Hojita hojita) async {
    final isar = await db;
    return isar.writeTxn(() => isar.hojitas.put(hojita));
  }

  Future<bool> deleteHojita(int id) async {
    final isar = await db;
    return isar.writeTxn(() => isar.hojitas.delete(id));
  }
}
