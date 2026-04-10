import 'package:isar/isar.dart';
import 'hojita_item.dart';

part 'hojita.g.dart';

@collection
class Hojita {
  Id id = Isar.autoIncrement;
  late String uuid;
  late String titulo;
  late DateTime fecha;
  late String tipoMisa;
  String? parroquiaNombre;
  String? parroquiaLogo;
  late List<HojitaItem> cantos;
  String template = 'clasico';
  String? notas;
  late DateTime creadoEn;
  late DateTime actualizadoEn;
  DateTime? exportadaEn;
}
