// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hojita.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHojitaCollection on Isar {
  IsarCollection<Hojita> get hojitas => this.collection();
}

const HojitaSchema = CollectionSchema(
  name: r'Hojita',
  id: 725098349410365865,
  properties: {
    r'actualizadoEn': PropertySchema(
      id: 0,
      name: r'actualizadoEn',
      type: IsarType.dateTime,
    ),
    r'cantos': PropertySchema(
      id: 1,
      name: r'cantos',
      type: IsarType.objectList,
      target: r'HojitaItem',
    ),
    r'creadoEn': PropertySchema(
      id: 2,
      name: r'creadoEn',
      type: IsarType.dateTime,
    ),
    r'exportadaEn': PropertySchema(
      id: 3,
      name: r'exportadaEn',
      type: IsarType.dateTime,
    ),
    r'fecha': PropertySchema(
      id: 4,
      name: r'fecha',
      type: IsarType.dateTime,
    ),
    r'notas': PropertySchema(
      id: 5,
      name: r'notas',
      type: IsarType.string,
    ),
    r'parroquiaLogo': PropertySchema(
      id: 6,
      name: r'parroquiaLogo',
      type: IsarType.string,
    ),
    r'parroquiaNombre': PropertySchema(
      id: 7,
      name: r'parroquiaNombre',
      type: IsarType.string,
    ),
    r'template': PropertySchema(
      id: 8,
      name: r'template',
      type: IsarType.string,
    ),
    r'tipoMisa': PropertySchema(
      id: 9,
      name: r'tipoMisa',
      type: IsarType.string,
    ),
    r'titulo': PropertySchema(
      id: 10,
      name: r'titulo',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 11,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _hojitaEstimateSize,
  serialize: _hojitaSerialize,
  deserialize: _hojitaDeserialize,
  deserializeProp: _hojitaDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'HojitaItem': HojitaItemSchema},
  getId: _hojitaGetId,
  getLinks: _hojitaGetLinks,
  attach: _hojitaAttach,
  version: '3.1.0+1',
);

int _hojitaEstimateSize(
  Hojita object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cantos.length * 3;
  {
    final offsets = allOffsets[HojitaItem]!;
    for (var i = 0; i < object.cantos.length; i++) {
      final value = object.cantos[i];
      bytesCount += HojitaItemSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  {
    final value = object.notas;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.parroquiaLogo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.parroquiaNombre;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.template.length * 3;
  bytesCount += 3 + object.tipoMisa.length * 3;
  bytesCount += 3 + object.titulo.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _hojitaSerialize(
  Hojita object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.actualizadoEn);
  writer.writeObjectList<HojitaItem>(
    offsets[1],
    allOffsets,
    HojitaItemSchema.serialize,
    object.cantos,
  );
  writer.writeDateTime(offsets[2], object.creadoEn);
  writer.writeDateTime(offsets[3], object.exportadaEn);
  writer.writeDateTime(offsets[4], object.fecha);
  writer.writeString(offsets[5], object.notas);
  writer.writeString(offsets[6], object.parroquiaLogo);
  writer.writeString(offsets[7], object.parroquiaNombre);
  writer.writeString(offsets[8], object.template);
  writer.writeString(offsets[9], object.tipoMisa);
  writer.writeString(offsets[10], object.titulo);
  writer.writeString(offsets[11], object.uuid);
}

Hojita _hojitaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Hojita();
  object.actualizadoEn = reader.readDateTime(offsets[0]);
  object.cantos = reader.readObjectList<HojitaItem>(
        offsets[1],
        HojitaItemSchema.deserialize,
        allOffsets,
        HojitaItem(),
      ) ??
      [];
  object.creadoEn = reader.readDateTime(offsets[2]);
  object.exportadaEn = reader.readDateTimeOrNull(offsets[3]);
  object.fecha = reader.readDateTime(offsets[4]);
  object.id = id;
  object.notas = reader.readStringOrNull(offsets[5]);
  object.parroquiaLogo = reader.readStringOrNull(offsets[6]);
  object.parroquiaNombre = reader.readStringOrNull(offsets[7]);
  object.template = reader.readString(offsets[8]);
  object.tipoMisa = reader.readString(offsets[9]);
  object.titulo = reader.readString(offsets[10]);
  object.uuid = reader.readString(offsets[11]);
  return object;
}

P _hojitaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readObjectList<HojitaItem>(
            offset,
            HojitaItemSchema.deserialize,
            allOffsets,
            HojitaItem(),
          ) ??
          []) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _hojitaGetId(Hojita object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _hojitaGetLinks(Hojita object) {
  return [];
}

void _hojitaAttach(IsarCollection<dynamic> col, Id id, Hojita object) {
  object.id = id;
}

extension HojitaQueryWhereSort on QueryBuilder<Hojita, Hojita, QWhere> {
  QueryBuilder<Hojita, Hojita, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HojitaQueryWhere on QueryBuilder<Hojita, Hojita, QWhereClause> {
  QueryBuilder<Hojita, Hojita, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension HojitaQueryFilter on QueryBuilder<Hojita, Hojita, QFilterCondition> {
  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> actualizadoEnEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'actualizadoEn',
        value: value,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> actualizadoEnGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'actualizadoEn',
        value: value,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> actualizadoEnLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'actualizadoEn',
        value: value,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> actualizadoEnBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'actualizadoEn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> cantosLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cantos',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> cantosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cantos',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> cantosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cantos',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> cantosLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cantos',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> cantosLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cantos',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> cantosLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cantos',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> creadoEnEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creadoEn',
        value: value,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> creadoEnGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creadoEn',
        value: value,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> creadoEnLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creadoEn',
        value: value,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> creadoEnBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creadoEn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> exportadaEnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'exportadaEn',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> exportadaEnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'exportadaEn',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> exportadaEnEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exportadaEn',
        value: value,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> exportadaEnGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exportadaEn',
        value: value,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> exportadaEnLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exportadaEn',
        value: value,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> exportadaEnBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exportadaEn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> fechaEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> fechaGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> fechaLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> fechaBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fecha',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> notasIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notas',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> notasIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notas',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> notasEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> notasGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> notasLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> notasBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notas',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> notasStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> notasEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> notasContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> notasMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notas',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> notasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notas',
        value: '',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> notasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notas',
        value: '',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaLogoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parroquiaLogo',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaLogoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parroquiaLogo',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaLogoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parroquiaLogo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaLogoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parroquiaLogo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaLogoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parroquiaLogo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaLogoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parroquiaLogo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaLogoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parroquiaLogo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaLogoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parroquiaLogo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaLogoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parroquiaLogo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaLogoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parroquiaLogo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaLogoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parroquiaLogo',
        value: '',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition>
      parroquiaLogoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parroquiaLogo',
        value: '',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaNombreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parroquiaNombre',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition>
      parroquiaNombreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parroquiaNombre',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaNombreEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parroquiaNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition>
      parroquiaNombreGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parroquiaNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaNombreLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parroquiaNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaNombreBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parroquiaNombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaNombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parroquiaNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaNombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parroquiaNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaNombreContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parroquiaNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaNombreMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parroquiaNombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> parroquiaNombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parroquiaNombre',
        value: '',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition>
      parroquiaNombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parroquiaNombre',
        value: '',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> templateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'template',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> templateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'template',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> templateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'template',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> templateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'template',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> templateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'template',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> templateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'template',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> templateContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'template',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> templateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'template',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> templateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'template',
        value: '',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> templateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'template',
        value: '',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tipoMisaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoMisa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tipoMisaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipoMisa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tipoMisaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipoMisa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tipoMisaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipoMisa',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tipoMisaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tipoMisa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tipoMisaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tipoMisa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tipoMisaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipoMisa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tipoMisaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipoMisa',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tipoMisaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoMisa',
        value: '',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tipoMisaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoMisa',
        value: '',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tituloEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tituloGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tituloLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tituloBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'titulo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tituloStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tituloEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tituloContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tituloMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'titulo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tituloIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titulo',
        value: '',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> tituloIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titulo',
        value: '',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> uuidContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> uuidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension HojitaQueryObject on QueryBuilder<Hojita, Hojita, QFilterCondition> {
  QueryBuilder<Hojita, Hojita, QAfterFilterCondition> cantosElement(
      FilterQuery<HojitaItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'cantos');
    });
  }
}

extension HojitaQueryLinks on QueryBuilder<Hojita, Hojita, QFilterCondition> {}

extension HojitaQuerySortBy on QueryBuilder<Hojita, Hojita, QSortBy> {
  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByActualizadoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualizadoEn', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByActualizadoEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualizadoEn', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByCreadoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creadoEn', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByCreadoEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creadoEn', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByExportadaEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportadaEn', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByExportadaEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportadaEn', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByNotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByNotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByParroquiaLogo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parroquiaLogo', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByParroquiaLogoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parroquiaLogo', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByParroquiaNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parroquiaNombre', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByParroquiaNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parroquiaNombre', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByTemplate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'template', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByTemplateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'template', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByTipoMisa() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoMisa', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByTipoMisaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoMisa', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByTitulo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByTituloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension HojitaQuerySortThenBy on QueryBuilder<Hojita, Hojita, QSortThenBy> {
  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByActualizadoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualizadoEn', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByActualizadoEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualizadoEn', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByCreadoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creadoEn', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByCreadoEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creadoEn', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByExportadaEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportadaEn', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByExportadaEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportadaEn', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByNotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByNotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByParroquiaLogo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parroquiaLogo', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByParroquiaLogoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parroquiaLogo', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByParroquiaNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parroquiaNombre', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByParroquiaNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parroquiaNombre', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByTemplate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'template', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByTemplateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'template', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByTipoMisa() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoMisa', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByTipoMisaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoMisa', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByTitulo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByTituloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.desc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Hojita, Hojita, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension HojitaQueryWhereDistinct on QueryBuilder<Hojita, Hojita, QDistinct> {
  QueryBuilder<Hojita, Hojita, QDistinct> distinctByActualizadoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'actualizadoEn');
    });
  }

  QueryBuilder<Hojita, Hojita, QDistinct> distinctByCreadoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creadoEn');
    });
  }

  QueryBuilder<Hojita, Hojita, QDistinct> distinctByExportadaEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exportadaEn');
    });
  }

  QueryBuilder<Hojita, Hojita, QDistinct> distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<Hojita, Hojita, QDistinct> distinctByNotas(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notas', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Hojita, Hojita, QDistinct> distinctByParroquiaLogo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parroquiaLogo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Hojita, Hojita, QDistinct> distinctByParroquiaNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parroquiaNombre',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Hojita, Hojita, QDistinct> distinctByTemplate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'template', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Hojita, Hojita, QDistinct> distinctByTipoMisa(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoMisa', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Hojita, Hojita, QDistinct> distinctByTitulo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titulo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Hojita, Hojita, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension HojitaQueryProperty on QueryBuilder<Hojita, Hojita, QQueryProperty> {
  QueryBuilder<Hojita, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Hojita, DateTime, QQueryOperations> actualizadoEnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'actualizadoEn');
    });
  }

  QueryBuilder<Hojita, List<HojitaItem>, QQueryOperations> cantosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantos');
    });
  }

  QueryBuilder<Hojita, DateTime, QQueryOperations> creadoEnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creadoEn');
    });
  }

  QueryBuilder<Hojita, DateTime?, QQueryOperations> exportadaEnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exportadaEn');
    });
  }

  QueryBuilder<Hojita, DateTime, QQueryOperations> fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<Hojita, String?, QQueryOperations> notasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notas');
    });
  }

  QueryBuilder<Hojita, String?, QQueryOperations> parroquiaLogoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parroquiaLogo');
    });
  }

  QueryBuilder<Hojita, String?, QQueryOperations> parroquiaNombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parroquiaNombre');
    });
  }

  QueryBuilder<Hojita, String, QQueryOperations> templateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'template');
    });
  }

  QueryBuilder<Hojita, String, QQueryOperations> tipoMisaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoMisa');
    });
  }

  QueryBuilder<Hojita, String, QQueryOperations> tituloProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titulo');
    });
  }

  QueryBuilder<Hojita, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
