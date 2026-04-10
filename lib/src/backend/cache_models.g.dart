// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_models.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarCategoryEntryCollection on Isar {
  IsarCollection<IsarCategoryEntry> get isarCategoryEntrys => this.collection();
}

const IsarCategoryEntrySchema = CollectionSchema(
  name: r'IsarCategoryEntry',
  id: -7635638701600849303,
  properties: {
    r'accentValue': PropertySchema(
      id: 0,
      name: r'accentValue',
      type: IsarType.long,
    ),
    r'label': PropertySchema(
      id: 1,
      name: r'label',
      type: IsarType.string,
    )
  },
  estimateSize: _isarCategoryEntryEstimateSize,
  serialize: _isarCategoryEntrySerialize,
  deserialize: _isarCategoryEntryDeserialize,
  deserializeProp: _isarCategoryEntryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarCategoryEntryGetId,
  getLinks: _isarCategoryEntryGetLinks,
  attach: _isarCategoryEntryAttach,
  version: '3.1.0+1',
);

int _isarCategoryEntryEstimateSize(
  IsarCategoryEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.label.length * 3;
  return bytesCount;
}

void _isarCategoryEntrySerialize(
  IsarCategoryEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.accentValue);
  writer.writeString(offsets[1], object.label);
}

IsarCategoryEntry _isarCategoryEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarCategoryEntry();
  object.accentValue = reader.readLong(offsets[0]);
  object.id = id;
  object.label = reader.readString(offsets[1]);
  return object;
}

P _isarCategoryEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarCategoryEntryGetId(IsarCategoryEntry object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarCategoryEntryGetLinks(
    IsarCategoryEntry object) {
  return [];
}

void _isarCategoryEntryAttach(
    IsarCollection<dynamic> col, Id id, IsarCategoryEntry object) {
  object.id = id;
}

extension IsarCategoryEntryQueryWhereSort
    on QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QWhere> {
  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarCategoryEntryQueryWhere
    on QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QWhereClause> {
  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterWhereClause>
      idBetween(
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

extension IsarCategoryEntryQueryFilter
    on QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QFilterCondition> {
  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      accentValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accentValue',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      accentValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accentValue',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      accentValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accentValue',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      accentValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accentValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
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

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      idLessThan(
    Id? value, {
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

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      idBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      labelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      labelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      labelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      labelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'label',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      labelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      labelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      labelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      labelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'label',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      labelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterFilterCondition>
      labelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'label',
        value: '',
      ));
    });
  }
}

extension IsarCategoryEntryQueryObject
    on QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QFilterCondition> {}

extension IsarCategoryEntryQueryLinks
    on QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QFilterCondition> {}

extension IsarCategoryEntryQuerySortBy
    on QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QSortBy> {
  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterSortBy>
      sortByAccentValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accentValue', Sort.asc);
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterSortBy>
      sortByAccentValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accentValue', Sort.desc);
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterSortBy>
      sortByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterSortBy>
      sortByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }
}

extension IsarCategoryEntryQuerySortThenBy
    on QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QSortThenBy> {
  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterSortBy>
      thenByAccentValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accentValue', Sort.asc);
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterSortBy>
      thenByAccentValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accentValue', Sort.desc);
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterSortBy>
      thenByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QAfterSortBy>
      thenByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }
}

extension IsarCategoryEntryQueryWhereDistinct
    on QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QDistinct> {
  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QDistinct>
      distinctByAccentValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accentValue');
    });
  }

  QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'label', caseSensitive: caseSensitive);
    });
  }
}

extension IsarCategoryEntryQueryProperty
    on QueryBuilder<IsarCategoryEntry, IsarCategoryEntry, QQueryProperty> {
  QueryBuilder<IsarCategoryEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarCategoryEntry, int, QQueryOperations> accentValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accentValue');
    });
  }

  QueryBuilder<IsarCategoryEntry, String, QQueryOperations> labelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'label');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarTrendEntryCollection on Isar {
  IsarCollection<IsarTrendEntry> get isarTrendEntrys => this.collection();
}

const IsarTrendEntrySchema = CollectionSchema(
  name: r'IsarTrendEntry',
  id: 3989935937727297277,
  properties: {
    r'accentValue': PropertySchema(
      id: 0,
      name: r'accentValue',
      type: IsarType.long,
    ),
    r'label': PropertySchema(
      id: 1,
      name: r'label',
      type: IsarType.string,
    ),
    r'meta': PropertySchema(
      id: 2,
      name: r'meta',
      type: IsarType.string,
    )
  },
  estimateSize: _isarTrendEntryEstimateSize,
  serialize: _isarTrendEntrySerialize,
  deserialize: _isarTrendEntryDeserialize,
  deserializeProp: _isarTrendEntryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarTrendEntryGetId,
  getLinks: _isarTrendEntryGetLinks,
  attach: _isarTrendEntryAttach,
  version: '3.1.0+1',
);

int _isarTrendEntryEstimateSize(
  IsarTrendEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.label.length * 3;
  bytesCount += 3 + object.meta.length * 3;
  return bytesCount;
}

void _isarTrendEntrySerialize(
  IsarTrendEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.accentValue);
  writer.writeString(offsets[1], object.label);
  writer.writeString(offsets[2], object.meta);
}

IsarTrendEntry _isarTrendEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarTrendEntry();
  object.accentValue = reader.readLong(offsets[0]);
  object.id = id;
  object.label = reader.readString(offsets[1]);
  object.meta = reader.readString(offsets[2]);
  return object;
}

P _isarTrendEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarTrendEntryGetId(IsarTrendEntry object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarTrendEntryGetLinks(IsarTrendEntry object) {
  return [];
}

void _isarTrendEntryAttach(
    IsarCollection<dynamic> col, Id id, IsarTrendEntry object) {
  object.id = id;
}

extension IsarTrendEntryQueryWhereSort
    on QueryBuilder<IsarTrendEntry, IsarTrendEntry, QWhere> {
  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarTrendEntryQueryWhere
    on QueryBuilder<IsarTrendEntry, IsarTrendEntry, QWhereClause> {
  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterWhereClause> idBetween(
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

extension IsarTrendEntryQueryFilter
    on QueryBuilder<IsarTrendEntry, IsarTrendEntry, QFilterCondition> {
  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      accentValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accentValue',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      accentValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accentValue',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      accentValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accentValue',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      accentValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accentValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
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

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      idLessThan(
    Id? value, {
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

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      labelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      labelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      labelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      labelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'label',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      labelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      labelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      labelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      labelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'label',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      labelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      labelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      metaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      metaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'meta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      metaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'meta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      metaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'meta',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      metaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'meta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      metaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'meta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      metaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'meta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      metaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'meta',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      metaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meta',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterFilterCondition>
      metaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'meta',
        value: '',
      ));
    });
  }
}

extension IsarTrendEntryQueryObject
    on QueryBuilder<IsarTrendEntry, IsarTrendEntry, QFilterCondition> {}

extension IsarTrendEntryQueryLinks
    on QueryBuilder<IsarTrendEntry, IsarTrendEntry, QFilterCondition> {}

extension IsarTrendEntryQuerySortBy
    on QueryBuilder<IsarTrendEntry, IsarTrendEntry, QSortBy> {
  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterSortBy>
      sortByAccentValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accentValue', Sort.asc);
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterSortBy>
      sortByAccentValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accentValue', Sort.desc);
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterSortBy> sortByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterSortBy> sortByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterSortBy> sortByMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meta', Sort.asc);
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterSortBy> sortByMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meta', Sort.desc);
    });
  }
}

extension IsarTrendEntryQuerySortThenBy
    on QueryBuilder<IsarTrendEntry, IsarTrendEntry, QSortThenBy> {
  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterSortBy>
      thenByAccentValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accentValue', Sort.asc);
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterSortBy>
      thenByAccentValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accentValue', Sort.desc);
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterSortBy> thenByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterSortBy> thenByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterSortBy> thenByMeta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meta', Sort.asc);
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QAfterSortBy> thenByMetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meta', Sort.desc);
    });
  }
}

extension IsarTrendEntryQueryWhereDistinct
    on QueryBuilder<IsarTrendEntry, IsarTrendEntry, QDistinct> {
  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QDistinct>
      distinctByAccentValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accentValue');
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'label', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarTrendEntry, IsarTrendEntry, QDistinct> distinctByMeta(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'meta', caseSensitive: caseSensitive);
    });
  }
}

extension IsarTrendEntryQueryProperty
    on QueryBuilder<IsarTrendEntry, IsarTrendEntry, QQueryProperty> {
  QueryBuilder<IsarTrendEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarTrendEntry, int, QQueryOperations> accentValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accentValue');
    });
  }

  QueryBuilder<IsarTrendEntry, String, QQueryOperations> labelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'label');
    });
  }

  QueryBuilder<IsarTrendEntry, String, QQueryOperations> metaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'meta');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarActiveTrackEntryCollection on Isar {
  IsarCollection<IsarActiveTrackEntry> get isarActiveTrackEntrys =>
      this.collection();
}

const IsarActiveTrackEntrySchema = CollectionSchema(
  name: r'IsarActiveTrackEntry',
  id: 200571407655079997,
  properties: {
    r'cachedAtMs': PropertySchema(
      id: 0,
      name: r'cachedAtMs',
      type: IsarType.long,
    ),
    r'composer': PropertySchema(
      id: 1,
      name: r'composer',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'sceneTag': PropertySchema(
      id: 3,
      name: r'sceneTag',
      type: IsarType.string,
    ),
    r'source': PropertySchema(
      id: 4,
      name: r'source',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 5,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _isarActiveTrackEntryEstimateSize,
  serialize: _isarActiveTrackEntrySerialize,
  deserialize: _isarActiveTrackEntryDeserialize,
  deserializeProp: _isarActiveTrackEntryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarActiveTrackEntryGetId,
  getLinks: _isarActiveTrackEntryGetLinks,
  attach: _isarActiveTrackEntryAttach,
  version: '3.1.0+1',
);

int _isarActiveTrackEntryEstimateSize(
  IsarActiveTrackEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.composer.length * 3;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.sceneTag.length * 3;
  bytesCount += 3 + object.source.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _isarActiveTrackEntrySerialize(
  IsarActiveTrackEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.cachedAtMs);
  writer.writeString(offsets[1], object.composer);
  writer.writeString(offsets[2], object.description);
  writer.writeString(offsets[3], object.sceneTag);
  writer.writeString(offsets[4], object.source);
  writer.writeString(offsets[5], object.title);
}

IsarActiveTrackEntry _isarActiveTrackEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarActiveTrackEntry();
  object.cachedAtMs = reader.readLong(offsets[0]);
  object.composer = reader.readString(offsets[1]);
  object.description = reader.readString(offsets[2]);
  object.id = id;
  object.sceneTag = reader.readString(offsets[3]);
  object.source = reader.readString(offsets[4]);
  object.title = reader.readString(offsets[5]);
  return object;
}

P _isarActiveTrackEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarActiveTrackEntryGetId(IsarActiveTrackEntry object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarActiveTrackEntryGetLinks(
    IsarActiveTrackEntry object) {
  return [];
}

void _isarActiveTrackEntryAttach(
    IsarCollection<dynamic> col, Id id, IsarActiveTrackEntry object) {
  object.id = id;
}

extension IsarActiveTrackEntryQueryWhereSort
    on QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QWhere> {
  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarActiveTrackEntryQueryWhere
    on QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QWhereClause> {
  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterWhereClause>
      idBetween(
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

extension IsarActiveTrackEntryQueryFilter on QueryBuilder<IsarActiveTrackEntry,
    IsarActiveTrackEntry, QFilterCondition> {
  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> cachedAtMsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cachedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> cachedAtMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cachedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> cachedAtMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cachedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> cachedAtMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cachedAtMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> composerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'composer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> composerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'composer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> composerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'composer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> composerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'composer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> composerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'composer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> composerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'composer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
          QAfterFilterCondition>
      composerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'composer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
          QAfterFilterCondition>
      composerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'composer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> composerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'composer',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> composerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'composer',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
          QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
          QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> idGreaterThan(
    Id? value, {
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

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> idLessThan(
    Id? value, {
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

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> sceneTagEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sceneTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> sceneTagGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sceneTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> sceneTagLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sceneTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> sceneTagBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sceneTag',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> sceneTagStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sceneTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> sceneTagEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sceneTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
          QAfterFilterCondition>
      sceneTagContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sceneTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
          QAfterFilterCondition>
      sceneTagMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sceneTag',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> sceneTagIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sceneTag',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> sceneTagIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sceneTag',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> sourceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> sourceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> sourceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> sourceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'source',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> sourceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> sourceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
          QAfterFilterCondition>
      sourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
          QAfterFilterCondition>
      sourceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'source',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> sourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> sourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'source',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
          QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
          QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry,
      QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension IsarActiveTrackEntryQueryObject on QueryBuilder<IsarActiveTrackEntry,
    IsarActiveTrackEntry, QFilterCondition> {}

extension IsarActiveTrackEntryQueryLinks on QueryBuilder<IsarActiveTrackEntry,
    IsarActiveTrackEntry, QFilterCondition> {}

extension IsarActiveTrackEntryQuerySortBy
    on QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QSortBy> {
  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      sortByCachedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAtMs', Sort.asc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      sortByCachedAtMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAtMs', Sort.desc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      sortByComposer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composer', Sort.asc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      sortByComposerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composer', Sort.desc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      sortBySceneTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sceneTag', Sort.asc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      sortBySceneTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sceneTag', Sort.desc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      sortBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      sortBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension IsarActiveTrackEntryQuerySortThenBy
    on QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QSortThenBy> {
  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      thenByCachedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAtMs', Sort.asc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      thenByCachedAtMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAtMs', Sort.desc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      thenByComposer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composer', Sort.asc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      thenByComposerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composer', Sort.desc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      thenBySceneTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sceneTag', Sort.asc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      thenBySceneTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sceneTag', Sort.desc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      thenBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      thenBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension IsarActiveTrackEntryQueryWhereDistinct
    on QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QDistinct> {
  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QDistinct>
      distinctByCachedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cachedAtMs');
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QDistinct>
      distinctByComposer({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'composer', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QDistinct>
      distinctBySceneTag({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sceneTag', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QDistinct>
      distinctBySource({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'source', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarActiveTrackEntry, IsarActiveTrackEntry, QDistinct>
      distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension IsarActiveTrackEntryQueryProperty on QueryBuilder<
    IsarActiveTrackEntry, IsarActiveTrackEntry, QQueryProperty> {
  QueryBuilder<IsarActiveTrackEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarActiveTrackEntry, int, QQueryOperations>
      cachedAtMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cachedAtMs');
    });
  }

  QueryBuilder<IsarActiveTrackEntry, String, QQueryOperations>
      composerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'composer');
    });
  }

  QueryBuilder<IsarActiveTrackEntry, String, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<IsarActiveTrackEntry, String, QQueryOperations>
      sceneTagProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sceneTag');
    });
  }

  QueryBuilder<IsarActiveTrackEntry, String, QQueryOperations>
      sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'source');
    });
  }

  QueryBuilder<IsarActiveTrackEntry, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarMascotEntryCollection on Isar {
  IsarCollection<IsarMascotEntry> get isarMascotEntrys => this.collection();
}

const IsarMascotEntrySchema = CollectionSchema(
  name: r'IsarMascotEntry',
  id: -618130299118927108,
  properties: {
    r'artistName': PropertySchema(
      id: 0,
      name: r'artistName',
      type: IsarType.string,
    ),
    r'assetColorValue': PropertySchema(
      id: 1,
      name: r'assetColorValue',
      type: IsarType.long,
    ),
    r'availableUntilLabel': PropertySchema(
      id: 2,
      name: r'availableUntilLabel',
      type: IsarType.string,
    ),
    r'cachedAtMs': PropertySchema(
      id: 3,
      name: r'cachedAtMs',
      type: IsarType.long,
    ),
    r'composerName': PropertySchema(
      id: 4,
      name: r'composerName',
      type: IsarType.string,
    ),
    r'concept': PropertySchema(
      id: 5,
      name: r'concept',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 6,
      name: r'description',
      type: IsarType.string,
    ),
    r'editionCap': PropertySchema(
      id: 7,
      name: r'editionCap',
      type: IsarType.long,
    ),
    r'editionsSold': PropertySchema(
      id: 8,
      name: r'editionsSold',
      type: IsarType.long,
    ),
    r'frameCount': PropertySchema(
      id: 9,
      name: r'frameCount',
      type: IsarType.long,
    ),
    r'frameDurationMs': PropertySchema(
      id: 10,
      name: r'frameDurationMs',
      type: IsarType.long,
    ),
    r'isFeatured': PropertySchema(
      id: 11,
      name: r'isFeatured',
      type: IsarType.bool,
    ),
    r'isFoundingExclusive': PropertySchema(
      id: 12,
      name: r'isFoundingExclusive',
      type: IsarType.bool,
    ),
    r'isRetired': PropertySchema(
      id: 13,
      name: r'isRetired',
      type: IsarType.bool,
    ),
    r'mascotId': PropertySchema(
      id: 14,
      name: r'mascotId',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 15,
      name: r'name',
      type: IsarType.string,
    ),
    r'priceCents': PropertySchema(
      id: 16,
      name: r'priceCents',
      type: IsarType.long,
    ),
    r'tier': PropertySchema(
      id: 17,
      name: r'tier',
      type: IsarType.string,
    )
  },
  estimateSize: _isarMascotEntryEstimateSize,
  serialize: _isarMascotEntrySerialize,
  deserialize: _isarMascotEntryDeserialize,
  deserializeProp: _isarMascotEntryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarMascotEntryGetId,
  getLinks: _isarMascotEntryGetLinks,
  attach: _isarMascotEntryAttach,
  version: '3.1.0+1',
);

int _isarMascotEntryEstimateSize(
  IsarMascotEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.artistName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.availableUntilLabel;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.composerName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.concept.length * 3;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.mascotId.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.tier.length * 3;
  return bytesCount;
}

void _isarMascotEntrySerialize(
  IsarMascotEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.artistName);
  writer.writeLong(offsets[1], object.assetColorValue);
  writer.writeString(offsets[2], object.availableUntilLabel);
  writer.writeLong(offsets[3], object.cachedAtMs);
  writer.writeString(offsets[4], object.composerName);
  writer.writeString(offsets[5], object.concept);
  writer.writeString(offsets[6], object.description);
  writer.writeLong(offsets[7], object.editionCap);
  writer.writeLong(offsets[8], object.editionsSold);
  writer.writeLong(offsets[9], object.frameCount);
  writer.writeLong(offsets[10], object.frameDurationMs);
  writer.writeBool(offsets[11], object.isFeatured);
  writer.writeBool(offsets[12], object.isFoundingExclusive);
  writer.writeBool(offsets[13], object.isRetired);
  writer.writeString(offsets[14], object.mascotId);
  writer.writeString(offsets[15], object.name);
  writer.writeLong(offsets[16], object.priceCents);
  writer.writeString(offsets[17], object.tier);
}

IsarMascotEntry _isarMascotEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarMascotEntry();
  object.artistName = reader.readStringOrNull(offsets[0]);
  object.assetColorValue = reader.readLong(offsets[1]);
  object.availableUntilLabel = reader.readStringOrNull(offsets[2]);
  object.cachedAtMs = reader.readLong(offsets[3]);
  object.composerName = reader.readStringOrNull(offsets[4]);
  object.concept = reader.readString(offsets[5]);
  object.description = reader.readString(offsets[6]);
  object.editionCap = reader.readLongOrNull(offsets[7]);
  object.editionsSold = reader.readLongOrNull(offsets[8]);
  object.frameCount = reader.readLong(offsets[9]);
  object.frameDurationMs = reader.readLong(offsets[10]);
  object.id = id;
  object.isFeatured = reader.readBool(offsets[11]);
  object.isFoundingExclusive = reader.readBool(offsets[12]);
  object.isRetired = reader.readBool(offsets[13]);
  object.mascotId = reader.readString(offsets[14]);
  object.name = reader.readString(offsets[15]);
  object.priceCents = reader.readLong(offsets[16]);
  object.tier = reader.readString(offsets[17]);
  return object;
}

P _isarMascotEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readBool(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readLong(offset)) as P;
    case 17:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarMascotEntryGetId(IsarMascotEntry object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarMascotEntryGetLinks(IsarMascotEntry object) {
  return [];
}

void _isarMascotEntryAttach(
    IsarCollection<dynamic> col, Id id, IsarMascotEntry object) {
  object.id = id;
}

extension IsarMascotEntryQueryWhereSort
    on QueryBuilder<IsarMascotEntry, IsarMascotEntry, QWhere> {
  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarMascotEntryQueryWhere
    on QueryBuilder<IsarMascotEntry, IsarMascotEntry, QWhereClause> {
  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterWhereClause> idBetween(
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

extension IsarMascotEntryQueryFilter
    on QueryBuilder<IsarMascotEntry, IsarMascotEntry, QFilterCondition> {
  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      artistNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'artistName',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      artistNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'artistName',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      artistNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artistName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      artistNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'artistName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      artistNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'artistName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      artistNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'artistName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      artistNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'artistName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      artistNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'artistName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      artistNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'artistName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      artistNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'artistName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      artistNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artistName',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      artistNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'artistName',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      assetColorValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assetColorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      assetColorValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assetColorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      assetColorValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assetColorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      assetColorValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assetColorValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      availableUntilLabelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'availableUntilLabel',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      availableUntilLabelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'availableUntilLabel',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      availableUntilLabelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'availableUntilLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      availableUntilLabelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'availableUntilLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      availableUntilLabelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'availableUntilLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      availableUntilLabelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'availableUntilLabel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      availableUntilLabelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'availableUntilLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      availableUntilLabelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'availableUntilLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      availableUntilLabelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'availableUntilLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      availableUntilLabelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'availableUntilLabel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      availableUntilLabelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'availableUntilLabel',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      availableUntilLabelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'availableUntilLabel',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      cachedAtMsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cachedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      cachedAtMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cachedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      cachedAtMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cachedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      cachedAtMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cachedAtMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      composerNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'composerName',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      composerNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'composerName',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      composerNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'composerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      composerNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'composerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      composerNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'composerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      composerNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'composerName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      composerNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'composerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      composerNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'composerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      composerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'composerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      composerNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'composerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      composerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'composerName',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      composerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'composerName',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      conceptEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'concept',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      conceptGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'concept',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      conceptLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'concept',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      conceptBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'concept',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      conceptStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'concept',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      conceptEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'concept',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      conceptContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'concept',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      conceptMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'concept',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      conceptIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'concept',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      conceptIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'concept',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      editionCapIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'editionCap',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      editionCapIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'editionCap',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      editionCapEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editionCap',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      editionCapGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'editionCap',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      editionCapLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'editionCap',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      editionCapBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'editionCap',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      editionsSoldIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'editionsSold',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      editionsSoldIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'editionsSold',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      editionsSoldEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editionsSold',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      editionsSoldGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'editionsSold',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      editionsSoldLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'editionsSold',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      editionsSoldBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'editionsSold',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      frameCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frameCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      frameCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frameCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      frameCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frameCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      frameCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frameCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      frameDurationMsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frameDurationMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      frameDurationMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frameDurationMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      frameDurationMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frameDurationMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      frameDurationMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frameDurationMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
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

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      idLessThan(
    Id? value, {
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

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      idBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      isFeaturedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFeatured',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      isFoundingExclusiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFoundingExclusive',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      isRetiredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRetired',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      mascotIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mascotId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      mascotIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mascotId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      mascotIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mascotId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      mascotIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mascotId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      mascotIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mascotId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      mascotIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mascotId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      mascotIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mascotId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      mascotIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mascotId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      mascotIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mascotId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      mascotIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mascotId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      priceCentsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priceCents',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      priceCentsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'priceCents',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      priceCentsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'priceCents',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      priceCentsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'priceCents',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      tierEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      tierGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      tierLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      tierBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tier',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      tierStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      tierEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      tierContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      tierMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tier',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      tierIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tier',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterFilterCondition>
      tierIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tier',
        value: '',
      ));
    });
  }
}

extension IsarMascotEntryQueryObject
    on QueryBuilder<IsarMascotEntry, IsarMascotEntry, QFilterCondition> {}

extension IsarMascotEntryQueryLinks
    on QueryBuilder<IsarMascotEntry, IsarMascotEntry, QFilterCondition> {}

extension IsarMascotEntryQuerySortBy
    on QueryBuilder<IsarMascotEntry, IsarMascotEntry, QSortBy> {
  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByArtistName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistName', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByArtistNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistName', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByAssetColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetColorValue', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByAssetColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetColorValue', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByAvailableUntilLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'availableUntilLabel', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByAvailableUntilLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'availableUntilLabel', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByCachedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAtMs', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByCachedAtMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAtMs', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByComposerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composerName', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByComposerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composerName', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy> sortByConcept() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'concept', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByConceptDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'concept', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByEditionCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editionCap', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByEditionCapDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editionCap', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByEditionsSold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editionsSold', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByEditionsSoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editionsSold', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByFrameCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frameCount', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByFrameCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frameCount', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByFrameDurationMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frameDurationMs', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByFrameDurationMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frameDurationMs', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByIsFeatured() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFeatured', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByIsFeaturedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFeatured', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByIsFoundingExclusive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFoundingExclusive', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByIsFoundingExclusiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFoundingExclusive', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByIsRetired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRetired', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByIsRetiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRetired', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByMascotId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mascotId', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByMascotIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mascotId', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByPriceCents() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priceCents', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByPriceCentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priceCents', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy> sortByTier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tier', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      sortByTierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tier', Sort.desc);
    });
  }
}

extension IsarMascotEntryQuerySortThenBy
    on QueryBuilder<IsarMascotEntry, IsarMascotEntry, QSortThenBy> {
  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByArtistName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistName', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByArtistNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistName', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByAssetColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetColorValue', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByAssetColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetColorValue', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByAvailableUntilLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'availableUntilLabel', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByAvailableUntilLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'availableUntilLabel', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByCachedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAtMs', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByCachedAtMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAtMs', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByComposerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composerName', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByComposerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composerName', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy> thenByConcept() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'concept', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByConceptDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'concept', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByEditionCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editionCap', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByEditionCapDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editionCap', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByEditionsSold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editionsSold', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByEditionsSoldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editionsSold', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByFrameCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frameCount', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByFrameCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frameCount', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByFrameDurationMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frameDurationMs', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByFrameDurationMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frameDurationMs', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByIsFeatured() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFeatured', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByIsFeaturedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFeatured', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByIsFoundingExclusive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFoundingExclusive', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByIsFoundingExclusiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFoundingExclusive', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByIsRetired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRetired', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByIsRetiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRetired', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByMascotId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mascotId', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByMascotIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mascotId', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByPriceCents() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priceCents', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByPriceCentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priceCents', Sort.desc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy> thenByTier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tier', Sort.asc);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QAfterSortBy>
      thenByTierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tier', Sort.desc);
    });
  }
}

extension IsarMascotEntryQueryWhereDistinct
    on QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct> {
  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct>
      distinctByArtistName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'artistName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct>
      distinctByAssetColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assetColorValue');
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct>
      distinctByAvailableUntilLabel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'availableUntilLabel',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct>
      distinctByCachedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cachedAtMs');
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct>
      distinctByComposerName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'composerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct> distinctByConcept(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'concept', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct>
      distinctByEditionCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'editionCap');
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct>
      distinctByEditionsSold() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'editionsSold');
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct>
      distinctByFrameCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frameCount');
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct>
      distinctByFrameDurationMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frameDurationMs');
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct>
      distinctByIsFeatured() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFeatured');
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct>
      distinctByIsFoundingExclusive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFoundingExclusive');
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct>
      distinctByIsRetired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRetired');
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct> distinctByMascotId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mascotId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct>
      distinctByPriceCents() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priceCents');
    });
  }

  QueryBuilder<IsarMascotEntry, IsarMascotEntry, QDistinct> distinctByTier(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tier', caseSensitive: caseSensitive);
    });
  }
}

extension IsarMascotEntryQueryProperty
    on QueryBuilder<IsarMascotEntry, IsarMascotEntry, QQueryProperty> {
  QueryBuilder<IsarMascotEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarMascotEntry, String?, QQueryOperations>
      artistNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'artistName');
    });
  }

  QueryBuilder<IsarMascotEntry, int, QQueryOperations>
      assetColorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assetColorValue');
    });
  }

  QueryBuilder<IsarMascotEntry, String?, QQueryOperations>
      availableUntilLabelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'availableUntilLabel');
    });
  }

  QueryBuilder<IsarMascotEntry, int, QQueryOperations> cachedAtMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cachedAtMs');
    });
  }

  QueryBuilder<IsarMascotEntry, String?, QQueryOperations>
      composerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'composerName');
    });
  }

  QueryBuilder<IsarMascotEntry, String, QQueryOperations> conceptProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'concept');
    });
  }

  QueryBuilder<IsarMascotEntry, String, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<IsarMascotEntry, int?, QQueryOperations> editionCapProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'editionCap');
    });
  }

  QueryBuilder<IsarMascotEntry, int?, QQueryOperations> editionsSoldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'editionsSold');
    });
  }

  QueryBuilder<IsarMascotEntry, int, QQueryOperations> frameCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frameCount');
    });
  }

  QueryBuilder<IsarMascotEntry, int, QQueryOperations>
      frameDurationMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frameDurationMs');
    });
  }

  QueryBuilder<IsarMascotEntry, bool, QQueryOperations> isFeaturedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFeatured');
    });
  }

  QueryBuilder<IsarMascotEntry, bool, QQueryOperations>
      isFoundingExclusiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFoundingExclusive');
    });
  }

  QueryBuilder<IsarMascotEntry, bool, QQueryOperations> isRetiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRetired');
    });
  }

  QueryBuilder<IsarMascotEntry, String, QQueryOperations> mascotIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mascotId');
    });
  }

  QueryBuilder<IsarMascotEntry, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<IsarMascotEntry, int, QQueryOperations> priceCentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priceCents');
    });
  }

  QueryBuilder<IsarMascotEntry, String, QQueryOperations> tierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tier');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarProfileEntryCollection on Isar {
  IsarCollection<IsarProfileEntry> get isarProfileEntrys => this.collection();
}

const IsarProfileEntrySchema = CollectionSchema(
  name: r'IsarProfileEntry',
  id: -14784219236447172,
  properties: {
    r'bio': PropertySchema(
      id: 0,
      name: r'bio',
      type: IsarType.string,
    ),
    r'cachedAtMs': PropertySchema(
      id: 1,
      name: r'cachedAtMs',
      type: IsarType.long,
    ),
    r'ratings': PropertySchema(
      id: 2,
      name: r'ratings',
      type: IsarType.long,
    ),
    r'topComposer': PropertySchema(
      id: 3,
      name: r'topComposer',
      type: IsarType.string,
    ),
    r'username': PropertySchema(
      id: 4,
      name: r'username',
      type: IsarType.string,
    )
  },
  estimateSize: _isarProfileEntryEstimateSize,
  serialize: _isarProfileEntrySerialize,
  deserialize: _isarProfileEntryDeserialize,
  deserializeProp: _isarProfileEntryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarProfileEntryGetId,
  getLinks: _isarProfileEntryGetLinks,
  attach: _isarProfileEntryAttach,
  version: '3.1.0+1',
);

int _isarProfileEntryEstimateSize(
  IsarProfileEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.bio.length * 3;
  bytesCount += 3 + object.topComposer.length * 3;
  bytesCount += 3 + object.username.length * 3;
  return bytesCount;
}

void _isarProfileEntrySerialize(
  IsarProfileEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.bio);
  writer.writeLong(offsets[1], object.cachedAtMs);
  writer.writeLong(offsets[2], object.ratings);
  writer.writeString(offsets[3], object.topComposer);
  writer.writeString(offsets[4], object.username);
}

IsarProfileEntry _isarProfileEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarProfileEntry();
  object.bio = reader.readString(offsets[0]);
  object.cachedAtMs = reader.readLong(offsets[1]);
  object.id = id;
  object.ratings = reader.readLong(offsets[2]);
  object.topComposer = reader.readString(offsets[3]);
  object.username = reader.readString(offsets[4]);
  return object;
}

P _isarProfileEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarProfileEntryGetId(IsarProfileEntry object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarProfileEntryGetLinks(IsarProfileEntry object) {
  return [];
}

void _isarProfileEntryAttach(
    IsarCollection<dynamic> col, Id id, IsarProfileEntry object) {
  object.id = id;
}

extension IsarProfileEntryQueryWhereSort
    on QueryBuilder<IsarProfileEntry, IsarProfileEntry, QWhere> {
  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarProfileEntryQueryWhere
    on QueryBuilder<IsarProfileEntry, IsarProfileEntry, QWhereClause> {
  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterWhereClause> idBetween(
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

extension IsarProfileEntryQueryFilter
    on QueryBuilder<IsarProfileEntry, IsarProfileEntry, QFilterCondition> {
  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      bioEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      bioGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      bioLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      bioBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      bioStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      bioEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      bioContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      bioMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bio',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      bioIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bio',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      bioIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bio',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      cachedAtMsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cachedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      cachedAtMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cachedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      cachedAtMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cachedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      cachedAtMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cachedAtMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
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

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      idLessThan(
    Id? value, {
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

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      idBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      ratingsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ratings',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      ratingsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ratings',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      ratingsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ratings',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      ratingsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ratings',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      topComposerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topComposer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      topComposerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'topComposer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      topComposerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'topComposer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      topComposerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'topComposer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      topComposerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'topComposer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      topComposerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'topComposer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      topComposerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'topComposer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      topComposerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'topComposer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      topComposerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topComposer',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      topComposerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'topComposer',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      usernameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      usernameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      usernameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      usernameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'username',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      usernameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      usernameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      usernameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      usernameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'username',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      usernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterFilterCondition>
      usernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'username',
        value: '',
      ));
    });
  }
}

extension IsarProfileEntryQueryObject
    on QueryBuilder<IsarProfileEntry, IsarProfileEntry, QFilterCondition> {}

extension IsarProfileEntryQueryLinks
    on QueryBuilder<IsarProfileEntry, IsarProfileEntry, QFilterCondition> {}

extension IsarProfileEntryQuerySortBy
    on QueryBuilder<IsarProfileEntry, IsarProfileEntry, QSortBy> {
  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy> sortByBio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bio', Sort.asc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      sortByBioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bio', Sort.desc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      sortByCachedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAtMs', Sort.asc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      sortByCachedAtMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAtMs', Sort.desc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      sortByRatings() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratings', Sort.asc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      sortByRatingsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratings', Sort.desc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      sortByTopComposer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topComposer', Sort.asc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      sortByTopComposerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topComposer', Sort.desc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      sortByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      sortByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension IsarProfileEntryQuerySortThenBy
    on QueryBuilder<IsarProfileEntry, IsarProfileEntry, QSortThenBy> {
  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy> thenByBio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bio', Sort.asc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      thenByBioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bio', Sort.desc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      thenByCachedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAtMs', Sort.asc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      thenByCachedAtMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAtMs', Sort.desc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      thenByRatings() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratings', Sort.asc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      thenByRatingsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratings', Sort.desc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      thenByTopComposer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topComposer', Sort.asc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      thenByTopComposerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topComposer', Sort.desc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      thenByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QAfterSortBy>
      thenByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension IsarProfileEntryQueryWhereDistinct
    on QueryBuilder<IsarProfileEntry, IsarProfileEntry, QDistinct> {
  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QDistinct> distinctByBio(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bio', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QDistinct>
      distinctByCachedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cachedAtMs');
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QDistinct>
      distinctByRatings() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ratings');
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QDistinct>
      distinctByTopComposer({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'topComposer', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarProfileEntry, IsarProfileEntry, QDistinct>
      distinctByUsername({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'username', caseSensitive: caseSensitive);
    });
  }
}

extension IsarProfileEntryQueryProperty
    on QueryBuilder<IsarProfileEntry, IsarProfileEntry, QQueryProperty> {
  QueryBuilder<IsarProfileEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarProfileEntry, String, QQueryOperations> bioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bio');
    });
  }

  QueryBuilder<IsarProfileEntry, int, QQueryOperations> cachedAtMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cachedAtMs');
    });
  }

  QueryBuilder<IsarProfileEntry, int, QQueryOperations> ratingsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ratings');
    });
  }

  QueryBuilder<IsarProfileEntry, String, QQueryOperations>
      topComposerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'topComposer');
    });
  }

  QueryBuilder<IsarProfileEntry, String, QQueryOperations> usernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'username');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarMediaSearchResultCollection on Isar {
  IsarCollection<IsarMediaSearchResult> get isarMediaSearchResults =>
      this.collection();
}

const IsarMediaSearchResultSchema = CollectionSchema(
  name: r'IsarMediaSearchResult',
  id: 1904009672870891584,
  properties: {
    r'alias': PropertySchema(
      id: 0,
      name: r'alias',
      type: IsarType.string,
    ),
    r'cachedAtMs': PropertySchema(
      id: 1,
      name: r'cachedAtMs',
      type: IsarType.long,
    ),
    r'query': PropertySchema(
      id: 2,
      name: r'query',
      type: IsarType.string,
    ),
    r'source': PropertySchema(
      id: 3,
      name: r'source',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 4,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _isarMediaSearchResultEstimateSize,
  serialize: _isarMediaSearchResultSerialize,
  deserialize: _isarMediaSearchResultDeserialize,
  deserializeProp: _isarMediaSearchResultDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarMediaSearchResultGetId,
  getLinks: _isarMediaSearchResultGetLinks,
  attach: _isarMediaSearchResultAttach,
  version: '3.1.0+1',
);

int _isarMediaSearchResultEstimateSize(
  IsarMediaSearchResult object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.alias.length * 3;
  bytesCount += 3 + object.query.length * 3;
  bytesCount += 3 + object.source.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _isarMediaSearchResultSerialize(
  IsarMediaSearchResult object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.alias);
  writer.writeLong(offsets[1], object.cachedAtMs);
  writer.writeString(offsets[2], object.query);
  writer.writeString(offsets[3], object.source);
  writer.writeString(offsets[4], object.title);
}

IsarMediaSearchResult _isarMediaSearchResultDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarMediaSearchResult();
  object.alias = reader.readString(offsets[0]);
  object.cachedAtMs = reader.readLong(offsets[1]);
  object.id = id;
  object.query = reader.readString(offsets[2]);
  object.source = reader.readString(offsets[3]);
  object.title = reader.readString(offsets[4]);
  return object;
}

P _isarMediaSearchResultDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarMediaSearchResultGetId(IsarMediaSearchResult object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarMediaSearchResultGetLinks(
    IsarMediaSearchResult object) {
  return [];
}

void _isarMediaSearchResultAttach(
    IsarCollection<dynamic> col, Id id, IsarMediaSearchResult object) {
  object.id = id;
}

extension IsarMediaSearchResultQueryWhereSort
    on QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QWhere> {
  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarMediaSearchResultQueryWhere on QueryBuilder<IsarMediaSearchResult,
    IsarMediaSearchResult, QWhereClause> {
  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterWhereClause>
      idBetween(
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

extension IsarMediaSearchResultQueryFilter on QueryBuilder<
    IsarMediaSearchResult, IsarMediaSearchResult, QFilterCondition> {
  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> aliasEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alias',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> aliasGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'alias',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> aliasLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'alias',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> aliasBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'alias',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> aliasStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'alias',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> aliasEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'alias',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
          QAfterFilterCondition>
      aliasContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'alias',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
          QAfterFilterCondition>
      aliasMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'alias',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> aliasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alias',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> aliasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'alias',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> cachedAtMsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cachedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> cachedAtMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cachedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> cachedAtMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cachedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> cachedAtMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cachedAtMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> idGreaterThan(
    Id? value, {
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

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> idLessThan(
    Id? value, {
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

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> queryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'query',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> queryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'query',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> queryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'query',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> queryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'query',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> queryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'query',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> queryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'query',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
          QAfterFilterCondition>
      queryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'query',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
          QAfterFilterCondition>
      queryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'query',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> queryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'query',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> queryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'query',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> sourceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> sourceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> sourceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> sourceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'source',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> sourceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> sourceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
          QAfterFilterCondition>
      sourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
          QAfterFilterCondition>
      sourceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'source',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> sourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> sourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'source',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
          QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
          QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult,
      QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension IsarMediaSearchResultQueryObject on QueryBuilder<
    IsarMediaSearchResult, IsarMediaSearchResult, QFilterCondition> {}

extension IsarMediaSearchResultQueryLinks on QueryBuilder<IsarMediaSearchResult,
    IsarMediaSearchResult, QFilterCondition> {}

extension IsarMediaSearchResultQuerySortBy
    on QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QSortBy> {
  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      sortByAlias() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alias', Sort.asc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      sortByAliasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alias', Sort.desc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      sortByCachedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAtMs', Sort.asc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      sortByCachedAtMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAtMs', Sort.desc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      sortByQuery() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'query', Sort.asc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      sortByQueryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'query', Sort.desc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      sortBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      sortBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension IsarMediaSearchResultQuerySortThenBy
    on QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QSortThenBy> {
  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      thenByAlias() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alias', Sort.asc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      thenByAliasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alias', Sort.desc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      thenByCachedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAtMs', Sort.asc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      thenByCachedAtMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAtMs', Sort.desc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      thenByQuery() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'query', Sort.asc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      thenByQueryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'query', Sort.desc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      thenBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      thenBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension IsarMediaSearchResultQueryWhereDistinct
    on QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QDistinct> {
  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QDistinct>
      distinctByAlias({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alias', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QDistinct>
      distinctByCachedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cachedAtMs');
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QDistinct>
      distinctByQuery({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'query', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QDistinct>
      distinctBySource({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'source', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMediaSearchResult, IsarMediaSearchResult, QDistinct>
      distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension IsarMediaSearchResultQueryProperty on QueryBuilder<
    IsarMediaSearchResult, IsarMediaSearchResult, QQueryProperty> {
  QueryBuilder<IsarMediaSearchResult, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarMediaSearchResult, String, QQueryOperations>
      aliasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alias');
    });
  }

  QueryBuilder<IsarMediaSearchResult, int, QQueryOperations>
      cachedAtMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cachedAtMs');
    });
  }

  QueryBuilder<IsarMediaSearchResult, String, QQueryOperations>
      queryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'query');
    });
  }

  QueryBuilder<IsarMediaSearchResult, String, QQueryOperations>
      sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'source');
    });
  }

  QueryBuilder<IsarMediaSearchResult, String, QQueryOperations>
      titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarShelfCollection on Isar {
  IsarCollection<IsarShelf> get isarShelfs => this.collection();
}

const IsarShelfSchema = CollectionSchema(
  name: r'IsarShelf',
  id: 1746930855754820243,
  properties: {
    r'createdAtMs': PropertySchema(
      id: 0,
      name: r'createdAtMs',
      type: IsarType.long,
    ),
    r'description': PropertySchema(
      id: 1,
      name: r'description',
      type: IsarType.string,
    ),
    r'isPublic': PropertySchema(
      id: 2,
      name: r'isPublic',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'shelfId': PropertySchema(
      id: 4,
      name: r'shelfId',
      type: IsarType.string,
    ),
    r'trackCount': PropertySchema(
      id: 5,
      name: r'trackCount',
      type: IsarType.long,
    ),
    r'updatedAtMs': PropertySchema(
      id: 6,
      name: r'updatedAtMs',
      type: IsarType.long,
    )
  },
  estimateSize: _isarShelfEstimateSize,
  serialize: _isarShelfSerialize,
  deserialize: _isarShelfDeserialize,
  deserializeProp: _isarShelfDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarShelfGetId,
  getLinks: _isarShelfGetLinks,
  attach: _isarShelfAttach,
  version: '3.1.0+1',
);

int _isarShelfEstimateSize(
  IsarShelf object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.shelfId.length * 3;
  return bytesCount;
}

void _isarShelfSerialize(
  IsarShelf object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.createdAtMs);
  writer.writeString(offsets[1], object.description);
  writer.writeBool(offsets[2], object.isPublic);
  writer.writeString(offsets[3], object.name);
  writer.writeString(offsets[4], object.shelfId);
  writer.writeLong(offsets[5], object.trackCount);
  writer.writeLong(offsets[6], object.updatedAtMs);
}

IsarShelf _isarShelfDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarShelf();
  object.createdAtMs = reader.readLong(offsets[0]);
  object.description = reader.readString(offsets[1]);
  object.id = id;
  object.isPublic = reader.readBool(offsets[2]);
  object.name = reader.readString(offsets[3]);
  object.shelfId = reader.readString(offsets[4]);
  object.trackCount = reader.readLong(offsets[5]);
  object.updatedAtMs = reader.readLong(offsets[6]);
  return object;
}

P _isarShelfDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarShelfGetId(IsarShelf object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarShelfGetLinks(IsarShelf object) {
  return [];
}

void _isarShelfAttach(IsarCollection<dynamic> col, Id id, IsarShelf object) {
  object.id = id;
}

extension IsarShelfQueryWhereSort
    on QueryBuilder<IsarShelf, IsarShelf, QWhere> {
  QueryBuilder<IsarShelf, IsarShelf, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarShelfQueryWhere
    on QueryBuilder<IsarShelf, IsarShelf, QWhereClause> {
  QueryBuilder<IsarShelf, IsarShelf, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<IsarShelf, IsarShelf, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterWhereClause> idBetween(
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

extension IsarShelfQueryFilter
    on QueryBuilder<IsarShelf, IsarShelf, QFilterCondition> {
  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> createdAtMsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition>
      createdAtMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> createdAtMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> createdAtMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAtMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> idGreaterThan(
    Id? value, {
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

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> idLessThan(
    Id? value, {
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

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> isPublicEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPublic',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> shelfIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shelfId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> shelfIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shelfId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> shelfIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shelfId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> shelfIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shelfId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> shelfIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shelfId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> shelfIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shelfId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> shelfIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shelfId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> shelfIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shelfId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> shelfIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shelfId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition>
      shelfIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shelfId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> trackCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition>
      trackCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trackCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> trackCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trackCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> trackCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trackCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> updatedAtMsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition>
      updatedAtMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> updatedAtMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterFilterCondition> updatedAtMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAtMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarShelfQueryObject
    on QueryBuilder<IsarShelf, IsarShelf, QFilterCondition> {}

extension IsarShelfQueryLinks
    on QueryBuilder<IsarShelf, IsarShelf, QFilterCondition> {}

extension IsarShelfQuerySortBy on QueryBuilder<IsarShelf, IsarShelf, QSortBy> {
  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> sortByCreatedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtMs', Sort.asc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> sortByCreatedAtMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtMs', Sort.desc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> sortByIsPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.asc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> sortByIsPublicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.desc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> sortByShelfId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shelfId', Sort.asc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> sortByShelfIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shelfId', Sort.desc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> sortByTrackCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackCount', Sort.asc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> sortByTrackCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackCount', Sort.desc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> sortByUpdatedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAtMs', Sort.asc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> sortByUpdatedAtMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAtMs', Sort.desc);
    });
  }
}

extension IsarShelfQuerySortThenBy
    on QueryBuilder<IsarShelf, IsarShelf, QSortThenBy> {
  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> thenByCreatedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtMs', Sort.asc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> thenByCreatedAtMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtMs', Sort.desc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> thenByIsPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.asc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> thenByIsPublicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.desc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> thenByShelfId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shelfId', Sort.asc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> thenByShelfIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shelfId', Sort.desc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> thenByTrackCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackCount', Sort.asc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> thenByTrackCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackCount', Sort.desc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> thenByUpdatedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAtMs', Sort.asc);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QAfterSortBy> thenByUpdatedAtMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAtMs', Sort.desc);
    });
  }
}

extension IsarShelfQueryWhereDistinct
    on QueryBuilder<IsarShelf, IsarShelf, QDistinct> {
  QueryBuilder<IsarShelf, IsarShelf, QDistinct> distinctByCreatedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtMs');
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QDistinct> distinctByIsPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPublic');
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QDistinct> distinctByShelfId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shelfId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QDistinct> distinctByTrackCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackCount');
    });
  }

  QueryBuilder<IsarShelf, IsarShelf, QDistinct> distinctByUpdatedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAtMs');
    });
  }
}

extension IsarShelfQueryProperty
    on QueryBuilder<IsarShelf, IsarShelf, QQueryProperty> {
  QueryBuilder<IsarShelf, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarShelf, int, QQueryOperations> createdAtMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtMs');
    });
  }

  QueryBuilder<IsarShelf, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<IsarShelf, bool, QQueryOperations> isPublicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPublic');
    });
  }

  QueryBuilder<IsarShelf, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<IsarShelf, String, QQueryOperations> shelfIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shelfId');
    });
  }

  QueryBuilder<IsarShelf, int, QQueryOperations> trackCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackCount');
    });
  }

  QueryBuilder<IsarShelf, int, QQueryOperations> updatedAtMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAtMs');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarShelfTrackCollection on Isar {
  IsarCollection<IsarShelfTrack> get isarShelfTracks => this.collection();
}

const IsarShelfTrackSchema = CollectionSchema(
  name: r'IsarShelfTrack',
  id: 6324096919825504936,
  properties: {
    r'addedAtMs': PropertySchema(
      id: 0,
      name: r'addedAtMs',
      type: IsarType.long,
    ),
    r'composerName': PropertySchema(
      id: 1,
      name: r'composerName',
      type: IsarType.string,
    ),
    r'shelfId': PropertySchema(
      id: 2,
      name: r'shelfId',
      type: IsarType.string,
    ),
    r'sourceName': PropertySchema(
      id: 3,
      name: r'sourceName',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 4,
      name: r'title',
      type: IsarType.string,
    ),
    r'trackId': PropertySchema(
      id: 5,
      name: r'trackId',
      type: IsarType.string,
    )
  },
  estimateSize: _isarShelfTrackEstimateSize,
  serialize: _isarShelfTrackSerialize,
  deserialize: _isarShelfTrackDeserialize,
  deserializeProp: _isarShelfTrackDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarShelfTrackGetId,
  getLinks: _isarShelfTrackGetLinks,
  attach: _isarShelfTrackAttach,
  version: '3.1.0+1',
);

int _isarShelfTrackEstimateSize(
  IsarShelfTrack object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.composerName.length * 3;
  bytesCount += 3 + object.shelfId.length * 3;
  bytesCount += 3 + object.sourceName.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.trackId.length * 3;
  return bytesCount;
}

void _isarShelfTrackSerialize(
  IsarShelfTrack object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.addedAtMs);
  writer.writeString(offsets[1], object.composerName);
  writer.writeString(offsets[2], object.shelfId);
  writer.writeString(offsets[3], object.sourceName);
  writer.writeString(offsets[4], object.title);
  writer.writeString(offsets[5], object.trackId);
}

IsarShelfTrack _isarShelfTrackDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarShelfTrack();
  object.addedAtMs = reader.readLong(offsets[0]);
  object.composerName = reader.readString(offsets[1]);
  object.id = id;
  object.shelfId = reader.readString(offsets[2]);
  object.sourceName = reader.readString(offsets[3]);
  object.title = reader.readString(offsets[4]);
  object.trackId = reader.readString(offsets[5]);
  return object;
}

P _isarShelfTrackDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarShelfTrackGetId(IsarShelfTrack object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarShelfTrackGetLinks(IsarShelfTrack object) {
  return [];
}

void _isarShelfTrackAttach(
    IsarCollection<dynamic> col, Id id, IsarShelfTrack object) {
  object.id = id;
}

extension IsarShelfTrackQueryWhereSort
    on QueryBuilder<IsarShelfTrack, IsarShelfTrack, QWhere> {
  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarShelfTrackQueryWhere
    on QueryBuilder<IsarShelfTrack, IsarShelfTrack, QWhereClause> {
  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterWhereClause> idBetween(
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

extension IsarShelfTrackQueryFilter
    on QueryBuilder<IsarShelfTrack, IsarShelfTrack, QFilterCondition> {
  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      addedAtMsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      addedAtMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'addedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      addedAtMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'addedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      addedAtMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'addedAtMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      composerNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'composerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      composerNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'composerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      composerNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'composerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      composerNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'composerName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      composerNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'composerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      composerNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'composerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      composerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'composerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      composerNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'composerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      composerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'composerName',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      composerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'composerName',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
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

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      idLessThan(
    Id? value, {
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

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      shelfIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shelfId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      shelfIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shelfId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      shelfIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shelfId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      shelfIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shelfId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      shelfIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shelfId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      shelfIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shelfId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      shelfIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shelfId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      shelfIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shelfId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      shelfIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shelfId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      shelfIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shelfId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      sourceNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      sourceNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      sourceNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      sourceNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourceName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      sourceNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      sourceNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      sourceNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      sourceNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      sourceNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceName',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      sourceNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceName',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      trackIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      trackIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      trackIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      trackIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trackId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      trackIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      trackIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      trackIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      trackIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'trackId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      trackIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterFilterCondition>
      trackIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trackId',
        value: '',
      ));
    });
  }
}

extension IsarShelfTrackQueryObject
    on QueryBuilder<IsarShelfTrack, IsarShelfTrack, QFilterCondition> {}

extension IsarShelfTrackQueryLinks
    on QueryBuilder<IsarShelfTrack, IsarShelfTrack, QFilterCondition> {}

extension IsarShelfTrackQuerySortBy
    on QueryBuilder<IsarShelfTrack, IsarShelfTrack, QSortBy> {
  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy> sortByAddedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAtMs', Sort.asc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy>
      sortByAddedAtMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAtMs', Sort.desc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy>
      sortByComposerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composerName', Sort.asc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy>
      sortByComposerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composerName', Sort.desc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy> sortByShelfId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shelfId', Sort.asc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy>
      sortByShelfIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shelfId', Sort.desc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy>
      sortBySourceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.asc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy>
      sortBySourceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.desc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy> sortByTrackId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.asc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy>
      sortByTrackIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.desc);
    });
  }
}

extension IsarShelfTrackQuerySortThenBy
    on QueryBuilder<IsarShelfTrack, IsarShelfTrack, QSortThenBy> {
  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy> thenByAddedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAtMs', Sort.asc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy>
      thenByAddedAtMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAtMs', Sort.desc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy>
      thenByComposerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composerName', Sort.asc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy>
      thenByComposerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composerName', Sort.desc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy> thenByShelfId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shelfId', Sort.asc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy>
      thenByShelfIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shelfId', Sort.desc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy>
      thenBySourceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.asc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy>
      thenBySourceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.desc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy> thenByTrackId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.asc);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QAfterSortBy>
      thenByTrackIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.desc);
    });
  }
}

extension IsarShelfTrackQueryWhereDistinct
    on QueryBuilder<IsarShelfTrack, IsarShelfTrack, QDistinct> {
  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QDistinct>
      distinctByAddedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'addedAtMs');
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QDistinct>
      distinctByComposerName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'composerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QDistinct> distinctByShelfId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shelfId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QDistinct> distinctBySourceName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarShelfTrack, IsarShelfTrack, QDistinct> distinctByTrackId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackId', caseSensitive: caseSensitive);
    });
  }
}

extension IsarShelfTrackQueryProperty
    on QueryBuilder<IsarShelfTrack, IsarShelfTrack, QQueryProperty> {
  QueryBuilder<IsarShelfTrack, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarShelfTrack, int, QQueryOperations> addedAtMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'addedAtMs');
    });
  }

  QueryBuilder<IsarShelfTrack, String, QQueryOperations>
      composerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'composerName');
    });
  }

  QueryBuilder<IsarShelfTrack, String, QQueryOperations> shelfIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shelfId');
    });
  }

  QueryBuilder<IsarShelfTrack, String, QQueryOperations> sourceNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceName');
    });
  }

  QueryBuilder<IsarShelfTrack, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<IsarShelfTrack, String, QQueryOperations> trackIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarTrackRatingCollection on Isar {
  IsarCollection<IsarTrackRating> get isarTrackRatings => this.collection();
}

const IsarTrackRatingSchema = CollectionSchema(
  name: r'IsarTrackRating',
  id: -1386167645177574070,
  properties: {
    r'ratedAtMs': PropertySchema(
      id: 0,
      name: r'ratedAtMs',
      type: IsarType.long,
    ),
    r'rating': PropertySchema(
      id: 1,
      name: r'rating',
      type: IsarType.double,
    ),
    r'trackId': PropertySchema(
      id: 2,
      name: r'trackId',
      type: IsarType.string,
    )
  },
  estimateSize: _isarTrackRatingEstimateSize,
  serialize: _isarTrackRatingSerialize,
  deserialize: _isarTrackRatingDeserialize,
  deserializeProp: _isarTrackRatingDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarTrackRatingGetId,
  getLinks: _isarTrackRatingGetLinks,
  attach: _isarTrackRatingAttach,
  version: '3.1.0+1',
);

int _isarTrackRatingEstimateSize(
  IsarTrackRating object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.trackId.length * 3;
  return bytesCount;
}

void _isarTrackRatingSerialize(
  IsarTrackRating object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.ratedAtMs);
  writer.writeDouble(offsets[1], object.rating);
  writer.writeString(offsets[2], object.trackId);
}

IsarTrackRating _isarTrackRatingDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarTrackRating();
  object.id = id;
  object.ratedAtMs = reader.readLong(offsets[0]);
  object.rating = reader.readDouble(offsets[1]);
  object.trackId = reader.readString(offsets[2]);
  return object;
}

P _isarTrackRatingDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarTrackRatingGetId(IsarTrackRating object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarTrackRatingGetLinks(IsarTrackRating object) {
  return [];
}

void _isarTrackRatingAttach(
    IsarCollection<dynamic> col, Id id, IsarTrackRating object) {
  object.id = id;
}

extension IsarTrackRatingQueryWhereSort
    on QueryBuilder<IsarTrackRating, IsarTrackRating, QWhere> {
  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarTrackRatingQueryWhere
    on QueryBuilder<IsarTrackRating, IsarTrackRating, QWhereClause> {
  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterWhereClause> idBetween(
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

extension IsarTrackRatingQueryFilter
    on QueryBuilder<IsarTrackRating, IsarTrackRating, QFilterCondition> {
  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
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

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      idLessThan(
    Id? value, {
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

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      idBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      ratedAtMsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ratedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      ratedAtMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ratedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      ratedAtMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ratedAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      ratedAtMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ratedAtMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      ratingEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      ratingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      ratingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      ratingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      trackIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      trackIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      trackIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      trackIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trackId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      trackIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      trackIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      trackIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      trackIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'trackId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      trackIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterFilterCondition>
      trackIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trackId',
        value: '',
      ));
    });
  }
}

extension IsarTrackRatingQueryObject
    on QueryBuilder<IsarTrackRating, IsarTrackRating, QFilterCondition> {}

extension IsarTrackRatingQueryLinks
    on QueryBuilder<IsarTrackRating, IsarTrackRating, QFilterCondition> {}

extension IsarTrackRatingQuerySortBy
    on QueryBuilder<IsarTrackRating, IsarTrackRating, QSortBy> {
  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterSortBy>
      sortByRatedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratedAtMs', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterSortBy>
      sortByRatedAtMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratedAtMs', Sort.desc);
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterSortBy> sortByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterSortBy>
      sortByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterSortBy> sortByTrackId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterSortBy>
      sortByTrackIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.desc);
    });
  }
}

extension IsarTrackRatingQuerySortThenBy
    on QueryBuilder<IsarTrackRating, IsarTrackRating, QSortThenBy> {
  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterSortBy>
      thenByRatedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratedAtMs', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterSortBy>
      thenByRatedAtMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratedAtMs', Sort.desc);
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterSortBy> thenByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterSortBy>
      thenByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterSortBy> thenByTrackId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QAfterSortBy>
      thenByTrackIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.desc);
    });
  }
}

extension IsarTrackRatingQueryWhereDistinct
    on QueryBuilder<IsarTrackRating, IsarTrackRating, QDistinct> {
  QueryBuilder<IsarTrackRating, IsarTrackRating, QDistinct>
      distinctByRatedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ratedAtMs');
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QDistinct> distinctByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rating');
    });
  }

  QueryBuilder<IsarTrackRating, IsarTrackRating, QDistinct> distinctByTrackId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackId', caseSensitive: caseSensitive);
    });
  }
}

extension IsarTrackRatingQueryProperty
    on QueryBuilder<IsarTrackRating, IsarTrackRating, QQueryProperty> {
  QueryBuilder<IsarTrackRating, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarTrackRating, int, QQueryOperations> ratedAtMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ratedAtMs');
    });
  }

  QueryBuilder<IsarTrackRating, double, QQueryOperations> ratingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rating');
    });
  }

  QueryBuilder<IsarTrackRating, String, QQueryOperations> trackIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarPendingMutationCollection on Isar {
  IsarCollection<IsarPendingMutation> get isarPendingMutations =>
      this.collection();
}

const IsarPendingMutationSchema = CollectionSchema(
  name: r'IsarPendingMutation',
  id: -1063806532586055357,
  properties: {
    r'attemptCount': PropertySchema(
      id: 0,
      name: r'attemptCount',
      type: IsarType.long,
    ),
    r'createdAtMs': PropertySchema(
      id: 1,
      name: r'createdAtMs',
      type: IsarType.long,
    ),
    r'errorMessage': PropertySchema(
      id: 2,
      name: r'errorMessage',
      type: IsarType.string,
    ),
    r'isRetrying': PropertySchema(
      id: 3,
      name: r'isRetrying',
      type: IsarType.bool,
    ),
    r'lastAttemptMs': PropertySchema(
      id: 4,
      name: r'lastAttemptMs',
      type: IsarType.long,
    ),
    r'mutationId': PropertySchema(
      id: 5,
      name: r'mutationId',
      type: IsarType.string,
    ),
    r'payload': PropertySchema(
      id: 6,
      name: r'payload',
      type: IsarType.string,
    ),
    r'retryDelayMs': PropertySchema(
      id: 7,
      name: r'retryDelayMs',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 8,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _isarPendingMutationEstimateSize,
  serialize: _isarPendingMutationSerialize,
  deserialize: _isarPendingMutationDeserialize,
  deserializeProp: _isarPendingMutationDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarPendingMutationGetId,
  getLinks: _isarPendingMutationGetLinks,
  attach: _isarPendingMutationAttach,
  version: '3.1.0+1',
);

int _isarPendingMutationEstimateSize(
  IsarPendingMutation object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.errorMessage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.mutationId.length * 3;
  bytesCount += 3 + object.payload.length * 3;
  bytesCount += 3 + object.type.length * 3;
  return bytesCount;
}

void _isarPendingMutationSerialize(
  IsarPendingMutation object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.attemptCount);
  writer.writeLong(offsets[1], object.createdAtMs);
  writer.writeString(offsets[2], object.errorMessage);
  writer.writeBool(offsets[3], object.isRetrying);
  writer.writeLong(offsets[4], object.lastAttemptMs);
  writer.writeString(offsets[5], object.mutationId);
  writer.writeString(offsets[6], object.payload);
  writer.writeLong(offsets[7], object.retryDelayMs);
  writer.writeString(offsets[8], object.type);
}

IsarPendingMutation _isarPendingMutationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarPendingMutation();
  object.attemptCount = reader.readLong(offsets[0]);
  object.createdAtMs = reader.readLong(offsets[1]);
  object.errorMessage = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.isRetrying = reader.readBool(offsets[3]);
  object.lastAttemptMs = reader.readLong(offsets[4]);
  object.mutationId = reader.readString(offsets[5]);
  object.payload = reader.readString(offsets[6]);
  object.retryDelayMs = reader.readLong(offsets[7]);
  object.type = reader.readString(offsets[8]);
  return object;
}

P _isarPendingMutationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarPendingMutationGetId(IsarPendingMutation object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarPendingMutationGetLinks(
    IsarPendingMutation object) {
  return [];
}

void _isarPendingMutationAttach(
    IsarCollection<dynamic> col, Id id, IsarPendingMutation object) {
  object.id = id;
}

extension IsarPendingMutationQueryWhereSort
    on QueryBuilder<IsarPendingMutation, IsarPendingMutation, QWhere> {
  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarPendingMutationQueryWhere
    on QueryBuilder<IsarPendingMutation, IsarPendingMutation, QWhereClause> {
  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterWhereClause>
      idBetween(
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

extension IsarPendingMutationQueryFilter on QueryBuilder<IsarPendingMutation,
    IsarPendingMutation, QFilterCondition> {
  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      attemptCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'attemptCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      attemptCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'attemptCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      attemptCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'attemptCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      attemptCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'attemptCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      createdAtMsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      createdAtMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      createdAtMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAtMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      createdAtMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAtMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      errorMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'errorMessage',
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      errorMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'errorMessage',
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      errorMessageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'errorMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      errorMessageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'errorMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      errorMessageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'errorMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      errorMessageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'errorMessage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      errorMessageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'errorMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      errorMessageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'errorMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      errorMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'errorMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      errorMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'errorMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      errorMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'errorMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      errorMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'errorMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
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

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      idLessThan(
    Id? value, {
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

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      idBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      isRetryingEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRetrying',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      lastAttemptMsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastAttemptMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      lastAttemptMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastAttemptMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      lastAttemptMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastAttemptMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      lastAttemptMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastAttemptMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      mutationIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mutationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      mutationIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mutationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      mutationIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mutationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      mutationIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mutationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      mutationIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mutationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      mutationIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mutationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      mutationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mutationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      mutationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mutationId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      mutationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mutationId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      mutationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mutationId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      payloadEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      payloadGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'payload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      payloadLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'payload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      payloadBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'payload',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      payloadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'payload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      payloadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'payload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      payloadContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'payload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      payloadMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'payload',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      payloadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payload',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      payloadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'payload',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      retryDelayMsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'retryDelayMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      retryDelayMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'retryDelayMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      retryDelayMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'retryDelayMs',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      retryDelayMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'retryDelayMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension IsarPendingMutationQueryObject on QueryBuilder<IsarPendingMutation,
    IsarPendingMutation, QFilterCondition> {}

extension IsarPendingMutationQueryLinks on QueryBuilder<IsarPendingMutation,
    IsarPendingMutation, QFilterCondition> {}

extension IsarPendingMutationQuerySortBy
    on QueryBuilder<IsarPendingMutation, IsarPendingMutation, QSortBy> {
  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      sortByAttemptCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attemptCount', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      sortByAttemptCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attemptCount', Sort.desc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      sortByCreatedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtMs', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      sortByCreatedAtMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtMs', Sort.desc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      sortByErrorMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorMessage', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      sortByErrorMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorMessage', Sort.desc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      sortByIsRetrying() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRetrying', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      sortByIsRetryingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRetrying', Sort.desc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      sortByLastAttemptMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptMs', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      sortByLastAttemptMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptMs', Sort.desc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      sortByMutationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mutationId', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      sortByMutationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mutationId', Sort.desc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      sortByPayload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payload', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      sortByPayloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payload', Sort.desc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      sortByRetryDelayMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retryDelayMs', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      sortByRetryDelayMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retryDelayMs', Sort.desc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension IsarPendingMutationQuerySortThenBy
    on QueryBuilder<IsarPendingMutation, IsarPendingMutation, QSortThenBy> {
  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByAttemptCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attemptCount', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByAttemptCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attemptCount', Sort.desc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByCreatedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtMs', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByCreatedAtMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtMs', Sort.desc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByErrorMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorMessage', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByErrorMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorMessage', Sort.desc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByIsRetrying() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRetrying', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByIsRetryingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRetrying', Sort.desc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByLastAttemptMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptMs', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByLastAttemptMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptMs', Sort.desc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByMutationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mutationId', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByMutationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mutationId', Sort.desc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByPayload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payload', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByPayloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payload', Sort.desc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByRetryDelayMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retryDelayMs', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByRetryDelayMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retryDelayMs', Sort.desc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension IsarPendingMutationQueryWhereDistinct
    on QueryBuilder<IsarPendingMutation, IsarPendingMutation, QDistinct> {
  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QDistinct>
      distinctByAttemptCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'attemptCount');
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QDistinct>
      distinctByCreatedAtMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtMs');
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QDistinct>
      distinctByErrorMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'errorMessage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QDistinct>
      distinctByIsRetrying() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRetrying');
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QDistinct>
      distinctByLastAttemptMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastAttemptMs');
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QDistinct>
      distinctByMutationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mutationId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QDistinct>
      distinctByPayload({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'payload', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QDistinct>
      distinctByRetryDelayMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'retryDelayMs');
    });
  }

  QueryBuilder<IsarPendingMutation, IsarPendingMutation, QDistinct>
      distinctByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension IsarPendingMutationQueryProperty
    on QueryBuilder<IsarPendingMutation, IsarPendingMutation, QQueryProperty> {
  QueryBuilder<IsarPendingMutation, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarPendingMutation, int, QQueryOperations>
      attemptCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'attemptCount');
    });
  }

  QueryBuilder<IsarPendingMutation, int, QQueryOperations>
      createdAtMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtMs');
    });
  }

  QueryBuilder<IsarPendingMutation, String?, QQueryOperations>
      errorMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'errorMessage');
    });
  }

  QueryBuilder<IsarPendingMutation, bool, QQueryOperations>
      isRetryingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRetrying');
    });
  }

  QueryBuilder<IsarPendingMutation, int, QQueryOperations>
      lastAttemptMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastAttemptMs');
    });
  }

  QueryBuilder<IsarPendingMutation, String, QQueryOperations>
      mutationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mutationId');
    });
  }

  QueryBuilder<IsarPendingMutation, String, QQueryOperations>
      payloadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'payload');
    });
  }

  QueryBuilder<IsarPendingMutation, int, QQueryOperations>
      retryDelayMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'retryDelayMs');
    });
  }

  QueryBuilder<IsarPendingMutation, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
