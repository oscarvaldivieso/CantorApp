// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canto.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCantoCollection on Isar {
  IsarCollection<Canto> get cantos => this.collection();
}

const CantoSchema = CollectionSchema(
  name: r'Canto',
  id: -4247285775786631108,
  properties: {
    r'acordes': PropertySchema(
      id: 0,
      name: r'acordes',
      type: IsarType.string,
    ),
    r'actualizadoEn': PropertySchema(
      id: 1,
      name: r'actualizadoEn',
      type: IsarType.dateTime,
    ),
    r'audioUrl': PropertySchema(
      id: 2,
      name: r'audioUrl',
      type: IsarType.string,
    ),
    r'autor': PropertySchema(
      id: 3,
      name: r'autor',
      type: IsarType.string,
    ),
    r'categorias': PropertySchema(
      id: 4,
      name: r'categorias',
      type: IsarType.stringList,
    ),
    r'creadoEn': PropertySchema(
      id: 5,
      name: r'creadoEn',
      type: IsarType.dateTime,
    ),
    r'esGlobal': PropertySchema(
      id: 6,
      name: r'esGlobal',
      type: IsarType.bool,
    ),
    r'esLocal': PropertySchema(
      id: 7,
      name: r'esLocal',
      type: IsarType.bool,
    ),
    r'letra': PropertySchema(
      id: 8,
      name: r'letra',
      type: IsarType.string,
    ),
    r'parroquiaId': PropertySchema(
      id: 9,
      name: r'parroquiaId',
      type: IsarType.string,
    ),
    r'tiempos': PropertySchema(
      id: 10,
      name: r'tiempos',
      type: IsarType.stringList,
    ),
    r'titulo': PropertySchema(
      id: 11,
      name: r'titulo',
      type: IsarType.string,
    ),
    r'tonalidad': PropertySchema(
      id: 12,
      name: r'tonalidad',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 13,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _cantoEstimateSize,
  serialize: _cantoSerialize,
  deserialize: _cantoDeserialize,
  deserializeProp: _cantoDeserializeProp,
  idName: r'id',
  indexes: {
    r'titulo': IndexSchema(
      id: 6803526659352100783,
      name: r'titulo',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'titulo',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _cantoGetId,
  getLinks: _cantoGetLinks,
  attach: _cantoAttach,
  version: '3.1.0+1',
);

int _cantoEstimateSize(
  Canto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.acordes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.audioUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.autor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.categorias.length * 3;
  {
    for (var i = 0; i < object.categorias.length; i++) {
      final value = object.categorias[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.letra.length * 3;
  {
    final value = object.parroquiaId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.tiempos.length * 3;
  {
    for (var i = 0; i < object.tiempos.length; i++) {
      final value = object.tiempos[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.titulo.length * 3;
  {
    final value = object.tonalidad;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _cantoSerialize(
  Canto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.acordes);
  writer.writeDateTime(offsets[1], object.actualizadoEn);
  writer.writeString(offsets[2], object.audioUrl);
  writer.writeString(offsets[3], object.autor);
  writer.writeStringList(offsets[4], object.categorias);
  writer.writeDateTime(offsets[5], object.creadoEn);
  writer.writeBool(offsets[6], object.esGlobal);
  writer.writeBool(offsets[7], object.esLocal);
  writer.writeString(offsets[8], object.letra);
  writer.writeString(offsets[9], object.parroquiaId);
  writer.writeStringList(offsets[10], object.tiempos);
  writer.writeString(offsets[11], object.titulo);
  writer.writeString(offsets[12], object.tonalidad);
  writer.writeString(offsets[13], object.uuid);
}

Canto _cantoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Canto();
  object.acordes = reader.readStringOrNull(offsets[0]);
  object.actualizadoEn = reader.readDateTime(offsets[1]);
  object.audioUrl = reader.readStringOrNull(offsets[2]);
  object.autor = reader.readStringOrNull(offsets[3]);
  object.categorias = reader.readStringList(offsets[4]) ?? [];
  object.creadoEn = reader.readDateTime(offsets[5]);
  object.esGlobal = reader.readBool(offsets[6]);
  object.esLocal = reader.readBool(offsets[7]);
  object.id = id;
  object.letra = reader.readString(offsets[8]);
  object.parroquiaId = reader.readStringOrNull(offsets[9]);
  object.tiempos = reader.readStringList(offsets[10]) ?? [];
  object.titulo = reader.readString(offsets[11]);
  object.tonalidad = reader.readStringOrNull(offsets[12]);
  object.uuid = reader.readString(offsets[13]);
  return object;
}

P _cantoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringList(offset) ?? []) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringList(offset) ?? []) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cantoGetId(Canto object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cantoGetLinks(Canto object) {
  return [];
}

void _cantoAttach(IsarCollection<dynamic> col, Id id, Canto object) {
  object.id = id;
}

extension CantoQueryWhereSort on QueryBuilder<Canto, Canto, QWhere> {
  QueryBuilder<Canto, Canto, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Canto, Canto, QAfterWhere> anyTitulo() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'titulo'),
      );
    });
  }
}

extension CantoQueryWhere on QueryBuilder<Canto, Canto, QWhereClause> {
  QueryBuilder<Canto, Canto, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Canto, Canto, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Canto, Canto, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Canto, Canto, QAfterWhereClause> idBetween(
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

  QueryBuilder<Canto, Canto, QAfterWhereClause> tituloEqualTo(String titulo) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'titulo',
        value: [titulo],
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterWhereClause> tituloNotEqualTo(
      String titulo) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'titulo',
              lower: [],
              upper: [titulo],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'titulo',
              lower: [titulo],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'titulo',
              lower: [titulo],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'titulo',
              lower: [],
              upper: [titulo],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Canto, Canto, QAfterWhereClause> tituloGreaterThan(
    String titulo, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'titulo',
        lower: [titulo],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterWhereClause> tituloLessThan(
    String titulo, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'titulo',
        lower: [],
        upper: [titulo],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterWhereClause> tituloBetween(
    String lowerTitulo,
    String upperTitulo, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'titulo',
        lower: [lowerTitulo],
        includeLower: includeLower,
        upper: [upperTitulo],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterWhereClause> tituloStartsWith(
      String TituloPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'titulo',
        lower: [TituloPrefix],
        upper: ['$TituloPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterWhereClause> tituloIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'titulo',
        value: [''],
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterWhereClause> tituloIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'titulo',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'titulo',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'titulo',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'titulo',
              upper: [''],
            ));
      }
    });
  }
}

extension CantoQueryFilter on QueryBuilder<Canto, Canto, QFilterCondition> {
  QueryBuilder<Canto, Canto, QAfterFilterCondition> acordesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'acordes',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> acordesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'acordes',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> acordesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'acordes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> acordesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'acordes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> acordesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'acordes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> acordesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'acordes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> acordesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'acordes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> acordesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'acordes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> acordesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'acordes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> acordesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'acordes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> acordesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'acordes',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> acordesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'acordes',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> actualizadoEnEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'actualizadoEn',
        value: value,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> actualizadoEnGreaterThan(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> actualizadoEnLessThan(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> actualizadoEnBetween(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> audioUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'audioUrl',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> audioUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'audioUrl',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> audioUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> audioUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> audioUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> audioUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> audioUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> audioUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> audioUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> audioUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'audioUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> audioUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> audioUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'audioUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> autorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'autor',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> autorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'autor',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> autorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> autorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'autor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> autorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'autor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> autorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'autor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> autorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'autor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> autorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'autor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> autorContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'autor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> autorMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'autor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> autorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autor',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> autorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'autor',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> categoriasElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categorias',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition>
      categoriasElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categorias',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> categoriasElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categorias',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> categoriasElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categorias',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> categoriasElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'categorias',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> categoriasElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'categorias',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> categoriasElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'categorias',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> categoriasElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'categorias',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> categoriasElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categorias',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition>
      categoriasElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'categorias',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> categoriasLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categorias',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> categoriasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categorias',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> categoriasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categorias',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> categoriasLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categorias',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> categoriasLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categorias',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> categoriasLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categorias',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> creadoEnEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creadoEn',
        value: value,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> creadoEnGreaterThan(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> creadoEnLessThan(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> creadoEnBetween(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> esGlobalEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'esGlobal',
        value: value,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> esLocalEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'esLocal',
        value: value,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> letraEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'letra',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> letraGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'letra',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> letraLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'letra',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> letraBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'letra',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> letraStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'letra',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> letraEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'letra',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> letraContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'letra',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> letraMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'letra',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> letraIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'letra',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> letraIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'letra',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> parroquiaIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parroquiaId',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> parroquiaIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parroquiaId',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> parroquiaIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parroquiaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> parroquiaIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parroquiaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> parroquiaIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parroquiaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> parroquiaIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parroquiaId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> parroquiaIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parroquiaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> parroquiaIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parroquiaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> parroquiaIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parroquiaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> parroquiaIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parroquiaId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> parroquiaIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parroquiaId',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> parroquiaIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parroquiaId',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tiemposElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tiempos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tiemposElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tiempos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tiemposElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tiempos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tiemposElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tiempos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tiemposElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tiempos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tiemposElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tiempos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tiemposElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tiempos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tiemposElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tiempos',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tiemposElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tiempos',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tiemposElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tiempos',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tiemposLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tiempos',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tiemposIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tiempos',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tiemposIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tiempos',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tiemposLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tiempos',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tiemposLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tiempos',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tiemposLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tiempos',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tituloEqualTo(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tituloGreaterThan(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tituloLessThan(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tituloBetween(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tituloStartsWith(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tituloEndsWith(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tituloContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tituloMatches(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tituloIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titulo',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tituloIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titulo',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tonalidadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tonalidad',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tonalidadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tonalidad',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tonalidadEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tonalidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tonalidadGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tonalidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tonalidadLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tonalidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tonalidadBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tonalidad',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tonalidadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tonalidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tonalidadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tonalidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tonalidadContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tonalidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tonalidadMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tonalidad',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tonalidadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tonalidad',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> tonalidadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tonalidad',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> uuidEqualTo(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> uuidGreaterThan(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> uuidLessThan(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> uuidBetween(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> uuidStartsWith(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> uuidEndsWith(
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

  QueryBuilder<Canto, Canto, QAfterFilterCondition> uuidContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> uuidMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<Canto, Canto, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension CantoQueryObject on QueryBuilder<Canto, Canto, QFilterCondition> {}

extension CantoQueryLinks on QueryBuilder<Canto, Canto, QFilterCondition> {}

extension CantoQuerySortBy on QueryBuilder<Canto, Canto, QSortBy> {
  QueryBuilder<Canto, Canto, QAfterSortBy> sortByAcordes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acordes', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByAcordesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acordes', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByActualizadoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualizadoEn', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByActualizadoEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualizadoEn', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByAudioUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByAudioUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByAutor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autor', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByAutorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autor', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByCreadoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creadoEn', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByCreadoEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creadoEn', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByEsGlobal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esGlobal', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByEsGlobalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esGlobal', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByEsLocal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esLocal', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByEsLocalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esLocal', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByLetra() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letra', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByLetraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letra', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByParroquiaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parroquiaId', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByParroquiaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parroquiaId', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByTitulo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByTituloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByTonalidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tonalidad', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByTonalidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tonalidad', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension CantoQuerySortThenBy on QueryBuilder<Canto, Canto, QSortThenBy> {
  QueryBuilder<Canto, Canto, QAfterSortBy> thenByAcordes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acordes', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByAcordesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acordes', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByActualizadoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualizadoEn', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByActualizadoEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualizadoEn', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByAudioUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByAudioUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByAutor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autor', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByAutorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autor', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByCreadoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creadoEn', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByCreadoEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creadoEn', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByEsGlobal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esGlobal', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByEsGlobalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esGlobal', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByEsLocal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esLocal', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByEsLocalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esLocal', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByLetra() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letra', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByLetraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letra', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByParroquiaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parroquiaId', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByParroquiaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parroquiaId', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByTitulo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByTituloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByTonalidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tonalidad', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByTonalidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tonalidad', Sort.desc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Canto, Canto, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension CantoQueryWhereDistinct on QueryBuilder<Canto, Canto, QDistinct> {
  QueryBuilder<Canto, Canto, QDistinct> distinctByAcordes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'acordes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Canto, Canto, QDistinct> distinctByActualizadoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'actualizadoEn');
    });
  }

  QueryBuilder<Canto, Canto, QDistinct> distinctByAudioUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Canto, Canto, QDistinct> distinctByAutor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'autor', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Canto, Canto, QDistinct> distinctByCategorias() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categorias');
    });
  }

  QueryBuilder<Canto, Canto, QDistinct> distinctByCreadoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creadoEn');
    });
  }

  QueryBuilder<Canto, Canto, QDistinct> distinctByEsGlobal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'esGlobal');
    });
  }

  QueryBuilder<Canto, Canto, QDistinct> distinctByEsLocal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'esLocal');
    });
  }

  QueryBuilder<Canto, Canto, QDistinct> distinctByLetra(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'letra', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Canto, Canto, QDistinct> distinctByParroquiaId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parroquiaId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Canto, Canto, QDistinct> distinctByTiempos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tiempos');
    });
  }

  QueryBuilder<Canto, Canto, QDistinct> distinctByTitulo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titulo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Canto, Canto, QDistinct> distinctByTonalidad(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tonalidad', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Canto, Canto, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension CantoQueryProperty on QueryBuilder<Canto, Canto, QQueryProperty> {
  QueryBuilder<Canto, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Canto, String?, QQueryOperations> acordesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'acordes');
    });
  }

  QueryBuilder<Canto, DateTime, QQueryOperations> actualizadoEnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'actualizadoEn');
    });
  }

  QueryBuilder<Canto, String?, QQueryOperations> audioUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioUrl');
    });
  }

  QueryBuilder<Canto, String?, QQueryOperations> autorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autor');
    });
  }

  QueryBuilder<Canto, List<String>, QQueryOperations> categoriasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categorias');
    });
  }

  QueryBuilder<Canto, DateTime, QQueryOperations> creadoEnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creadoEn');
    });
  }

  QueryBuilder<Canto, bool, QQueryOperations> esGlobalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'esGlobal');
    });
  }

  QueryBuilder<Canto, bool, QQueryOperations> esLocalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'esLocal');
    });
  }

  QueryBuilder<Canto, String, QQueryOperations> letraProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'letra');
    });
  }

  QueryBuilder<Canto, String?, QQueryOperations> parroquiaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parroquiaId');
    });
  }

  QueryBuilder<Canto, List<String>, QQueryOperations> tiemposProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tiempos');
    });
  }

  QueryBuilder<Canto, String, QQueryOperations> tituloProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titulo');
    });
  }

  QueryBuilder<Canto, String?, QQueryOperations> tonalidadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tonalidad');
    });
  }

  QueryBuilder<Canto, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
