// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hojita_item.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const HojitaItemSchema = Schema(
  name: r'HojitaItem',
  id: 6809312169641120803,
  properties: {
    r'cantoAutor': PropertySchema(
      id: 0,
      name: r'cantoAutor',
      type: IsarType.string,
    ),
    r'cantoCategoria': PropertySchema(
      id: 1,
      name: r'cantoCategoria',
      type: IsarType.string,
    ),
    r'cantoTitulo': PropertySchema(
      id: 2,
      name: r'cantoTitulo',
      type: IsarType.string,
    ),
    r'cantoUuid': PropertySchema(
      id: 3,
      name: r'cantoUuid',
      type: IsarType.string,
    ),
    r'incluirAcordes': PropertySchema(
      id: 4,
      name: r'incluirAcordes',
      type: IsarType.bool,
    ),
    r'notaDirector': PropertySchema(
      id: 5,
      name: r'notaDirector',
      type: IsarType.string,
    ),
    r'orden': PropertySchema(
      id: 6,
      name: r'orden',
      type: IsarType.long,
    ),
    r'tonalidad': PropertySchema(
      id: 7,
      name: r'tonalidad',
      type: IsarType.string,
    )
  },
  estimateSize: _hojitaItemEstimateSize,
  serialize: _hojitaItemSerialize,
  deserialize: _hojitaItemDeserialize,
  deserializeProp: _hojitaItemDeserializeProp,
);

int _hojitaItemEstimateSize(
  HojitaItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cantoAutor.length * 3;
  bytesCount += 3 + object.cantoCategoria.length * 3;
  bytesCount += 3 + object.cantoTitulo.length * 3;
  bytesCount += 3 + object.cantoUuid.length * 3;
  {
    final value = object.notaDirector;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tonalidad;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _hojitaItemSerialize(
  HojitaItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.cantoAutor);
  writer.writeString(offsets[1], object.cantoCategoria);
  writer.writeString(offsets[2], object.cantoTitulo);
  writer.writeString(offsets[3], object.cantoUuid);
  writer.writeBool(offsets[4], object.incluirAcordes);
  writer.writeString(offsets[5], object.notaDirector);
  writer.writeLong(offsets[6], object.orden);
  writer.writeString(offsets[7], object.tonalidad);
}

HojitaItem _hojitaItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HojitaItem();
  object.cantoAutor = reader.readString(offsets[0]);
  object.cantoCategoria = reader.readString(offsets[1]);
  object.cantoTitulo = reader.readString(offsets[2]);
  object.cantoUuid = reader.readString(offsets[3]);
  object.incluirAcordes = reader.readBool(offsets[4]);
  object.notaDirector = reader.readStringOrNull(offsets[5]);
  object.orden = reader.readLong(offsets[6]);
  object.tonalidad = reader.readStringOrNull(offsets[7]);
  return object;
}

P _hojitaItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension HojitaItemQueryFilter
    on QueryBuilder<HojitaItem, HojitaItem, QFilterCondition> {
  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> cantoAutorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantoAutor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoAutorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantoAutor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoAutorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantoAutor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> cantoAutorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantoAutor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoAutorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cantoAutor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoAutorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cantoAutor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoAutorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cantoAutor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> cantoAutorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cantoAutor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoAutorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantoAutor',
        value: '',
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoAutorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cantoAutor',
        value: '',
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoCategoriaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantoCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoCategoriaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantoCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoCategoriaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantoCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoCategoriaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantoCategoria',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoCategoriaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cantoCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoCategoriaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cantoCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoCategoriaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cantoCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoCategoriaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cantoCategoria',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoCategoriaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantoCategoria',
        value: '',
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoCategoriaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cantoCategoria',
        value: '',
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoTituloEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantoTitulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoTituloGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantoTitulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoTituloLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantoTitulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoTituloBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantoTitulo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoTituloStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cantoTitulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoTituloEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cantoTitulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoTituloContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cantoTitulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoTituloMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cantoTitulo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoTituloIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantoTitulo',
        value: '',
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoTituloIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cantoTitulo',
        value: '',
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> cantoUuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantoUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoUuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantoUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> cantoUuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantoUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> cantoUuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantoUuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoUuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cantoUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> cantoUuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cantoUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> cantoUuidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cantoUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> cantoUuidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cantoUuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoUuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantoUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      cantoUuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cantoUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      incluirAcordesEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'incluirAcordes',
        value: value,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      notaDirectorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notaDirector',
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      notaDirectorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notaDirector',
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      notaDirectorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notaDirector',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      notaDirectorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notaDirector',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      notaDirectorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notaDirector',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      notaDirectorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notaDirector',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      notaDirectorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notaDirector',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      notaDirectorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notaDirector',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      notaDirectorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notaDirector',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      notaDirectorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notaDirector',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      notaDirectorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notaDirector',
        value: '',
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      notaDirectorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notaDirector',
        value: '',
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> ordenEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orden',
        value: value,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> ordenGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orden',
        value: value,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> ordenLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orden',
        value: value,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> ordenBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orden',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      tonalidadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tonalidad',
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      tonalidadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tonalidad',
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> tonalidadEqualTo(
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

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      tonalidadGreaterThan(
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

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> tonalidadLessThan(
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

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> tonalidadBetween(
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

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      tonalidadStartsWith(
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

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> tonalidadEndsWith(
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

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> tonalidadContains(
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

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition> tonalidadMatches(
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

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      tonalidadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tonalidad',
        value: '',
      ));
    });
  }

  QueryBuilder<HojitaItem, HojitaItem, QAfterFilterCondition>
      tonalidadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tonalidad',
        value: '',
      ));
    });
  }
}

extension HojitaItemQueryObject
    on QueryBuilder<HojitaItem, HojitaItem, QFilterCondition> {}
