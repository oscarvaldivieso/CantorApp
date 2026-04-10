import 'package:cantor_app/features/hojitas/domain/hojita.dart';

abstract class HojitaRepository {
  Future<List<Hojita>> getAll();
  Stream<List<Hojita>> watchAll();
  Future<Hojita?> getById(int id);
  Future<Hojita?> getByUuid(String uuid);
  Future<int> save(Hojita hojita);
  Future<bool> delete(int id);
}
