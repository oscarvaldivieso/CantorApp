import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cantor_app/features/cantos/presentation/providers/cantos_provider.dart';
import 'package:cantor_app/features/hojitas/domain/hojita.dart';

final hojitasStreamProvider = StreamProvider<List<Hojita>>((ref) {
  final isar = ref.watch(isarServiceProvider);
  return isar.watchAllHojitas();
});
