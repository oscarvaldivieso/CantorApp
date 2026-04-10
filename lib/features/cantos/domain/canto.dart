import 'package:isar/isar.dart';

part 'canto.g.dart';

@collection
class Canto {
  Id id = Isar.autoIncrement;
  late String uuid;

  @Index(type: IndexType.value)
  late String titulo;

  late String letra;
  String? acordes;
  String? tonalidad;
  String? audioUrl;
  String? autor;
  late List<String> categorias;
  late List<String> tiempos;
  bool esLocal = false;
  bool esGlobal = true;
  String? parroquiaId;
  late DateTime creadoEn;
  late DateTime actualizadoEn;
}
