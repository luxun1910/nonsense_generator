// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FavoriteTable extends Favorite
    with TableInfo<$FavoriteTable, FavoriteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _originalContentMeta =
      const VerificationMeta('originalContent');
  @override
  late final GeneratedColumn<String> originalContent = GeneratedColumn<String>(
      'original_content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, content, originalContent, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite';
  @override
  VerificationContext validateIntegrity(Insertable<FavoriteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('original_content')) {
      context.handle(
          _originalContentMeta,
          originalContent.isAcceptableOrUnknown(
              data['original_content']!, _originalContentMeta));
    } else if (isInserting) {
      context.missing(_originalContentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      originalContent: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}original_content'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $FavoriteTable createAlias(String alias) {
    return $FavoriteTable(attachedDatabase, alias);
  }
}

class FavoriteData extends DataClass implements Insertable<FavoriteData> {
  final int id;
  final String content;
  final String originalContent;
  final DateTime createdAt;
  const FavoriteData(
      {required this.id,
      required this.content,
      required this.originalContent,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    map['original_content'] = Variable<String>(originalContent);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FavoriteCompanion toCompanion(bool nullToAbsent) {
    return FavoriteCompanion(
      id: Value(id),
      content: Value(content),
      originalContent: Value(originalContent),
      createdAt: Value(createdAt),
    );
  }

  factory FavoriteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteData(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      originalContent: serializer.fromJson<String>(json['originalContent']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
      'originalContent': serializer.toJson<String>(originalContent),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FavoriteData copyWith(
          {int? id,
          String? content,
          String? originalContent,
          DateTime? createdAt}) =>
      FavoriteData(
        id: id ?? this.id,
        content: content ?? this.content,
        originalContent: originalContent ?? this.originalContent,
        createdAt: createdAt ?? this.createdAt,
      );
  FavoriteData copyWithCompanion(FavoriteCompanion data) {
    return FavoriteData(
      id: data.id.present ? data.id.value : this.id,
      content: data.content.present ? data.content.value : this.content,
      originalContent: data.originalContent.present
          ? data.originalContent.value
          : this.originalContent,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteData(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('originalContent: $originalContent, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content, originalContent, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteData &&
          other.id == this.id &&
          other.content == this.content &&
          other.originalContent == this.originalContent &&
          other.createdAt == this.createdAt);
}

class FavoriteCompanion extends UpdateCompanion<FavoriteData> {
  final Value<int> id;
  final Value<String> content;
  final Value<String> originalContent;
  final Value<DateTime> createdAt;
  const FavoriteCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.originalContent = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FavoriteCompanion.insert({
    this.id = const Value.absent(),
    required String content,
    required String originalContent,
    required DateTime createdAt,
  })  : content = Value(content),
        originalContent = Value(originalContent),
        createdAt = Value(createdAt);
  static Insertable<FavoriteData> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<String>? originalContent,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (originalContent != null) 'original_content': originalContent,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FavoriteCompanion copyWith(
      {Value<int>? id,
      Value<String>? content,
      Value<String>? originalContent,
      Value<DateTime>? createdAt}) {
    return FavoriteCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      originalContent: originalContent ?? this.originalContent,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (originalContent.present) {
      map['original_content'] = Variable<String>(originalContent.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('originalContent: $originalContent, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $LimitTable extends Limit with TableInfo<$LimitTable, LimitData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LimitTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _limitMeta = const VerificationMeta('limit');
  @override
  late final GeneratedColumn<int> limit = GeneratedColumn<int>(
      'limit', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _maxLimitMeta =
      const VerificationMeta('maxLimit');
  @override
  late final GeneratedColumn<int> maxLimit = GeneratedColumn<int>(
      'max_limit', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastGeneratedDateMeta =
      const VerificationMeta('lastGeneratedDate');
  @override
  late final GeneratedColumn<DateTime> lastGeneratedDate =
      GeneratedColumn<DateTime>('last_generated_date', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, limit, maxLimit, lastGeneratedDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'limit';
  @override
  VerificationContext validateIntegrity(Insertable<LimitData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('limit')) {
      context.handle(
          _limitMeta, limit.isAcceptableOrUnknown(data['limit']!, _limitMeta));
    } else if (isInserting) {
      context.missing(_limitMeta);
    }
    if (data.containsKey('max_limit')) {
      context.handle(_maxLimitMeta,
          maxLimit.isAcceptableOrUnknown(data['max_limit']!, _maxLimitMeta));
    } else if (isInserting) {
      context.missing(_maxLimitMeta);
    }
    if (data.containsKey('last_generated_date')) {
      context.handle(
          _lastGeneratedDateMeta,
          lastGeneratedDate.isAcceptableOrUnknown(
              data['last_generated_date']!, _lastGeneratedDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LimitData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LimitData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      limit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}limit'])!,
      maxLimit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_limit'])!,
      lastGeneratedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_generated_date'])!,
    );
  }

  @override
  $LimitTable createAlias(String alias) {
    return $LimitTable(attachedDatabase, alias);
  }
}

class LimitData extends DataClass implements Insertable<LimitData> {
  final int id;
  final int limit;
  final int maxLimit;
  final DateTime lastGeneratedDate;
  const LimitData(
      {required this.id,
      required this.limit,
      required this.maxLimit,
      required this.lastGeneratedDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['limit'] = Variable<int>(limit);
    map['max_limit'] = Variable<int>(maxLimit);
    map['last_generated_date'] = Variable<DateTime>(lastGeneratedDate);
    return map;
  }

  LimitCompanion toCompanion(bool nullToAbsent) {
    return LimitCompanion(
      id: Value(id),
      limit: Value(limit),
      maxLimit: Value(maxLimit),
      lastGeneratedDate: Value(lastGeneratedDate),
    );
  }

  factory LimitData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LimitData(
      id: serializer.fromJson<int>(json['id']),
      limit: serializer.fromJson<int>(json['limit']),
      maxLimit: serializer.fromJson<int>(json['maxLimit']),
      lastGeneratedDate:
          serializer.fromJson<DateTime>(json['lastGeneratedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'limit': serializer.toJson<int>(limit),
      'maxLimit': serializer.toJson<int>(maxLimit),
      'lastGeneratedDate': serializer.toJson<DateTime>(lastGeneratedDate),
    };
  }

  LimitData copyWith(
          {int? id, int? limit, int? maxLimit, DateTime? lastGeneratedDate}) =>
      LimitData(
        id: id ?? this.id,
        limit: limit ?? this.limit,
        maxLimit: maxLimit ?? this.maxLimit,
        lastGeneratedDate: lastGeneratedDate ?? this.lastGeneratedDate,
      );
  LimitData copyWithCompanion(LimitCompanion data) {
    return LimitData(
      id: data.id.present ? data.id.value : this.id,
      limit: data.limit.present ? data.limit.value : this.limit,
      maxLimit: data.maxLimit.present ? data.maxLimit.value : this.maxLimit,
      lastGeneratedDate: data.lastGeneratedDate.present
          ? data.lastGeneratedDate.value
          : this.lastGeneratedDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LimitData(')
          ..write('id: $id, ')
          ..write('limit: $limit, ')
          ..write('maxLimit: $maxLimit, ')
          ..write('lastGeneratedDate: $lastGeneratedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, limit, maxLimit, lastGeneratedDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LimitData &&
          other.id == this.id &&
          other.limit == this.limit &&
          other.maxLimit == this.maxLimit &&
          other.lastGeneratedDate == this.lastGeneratedDate);
}

class LimitCompanion extends UpdateCompanion<LimitData> {
  final Value<int> id;
  final Value<int> limit;
  final Value<int> maxLimit;
  final Value<DateTime> lastGeneratedDate;
  const LimitCompanion({
    this.id = const Value.absent(),
    this.limit = const Value.absent(),
    this.maxLimit = const Value.absent(),
    this.lastGeneratedDate = const Value.absent(),
  });
  LimitCompanion.insert({
    this.id = const Value.absent(),
    required int limit,
    required int maxLimit,
    this.lastGeneratedDate = const Value.absent(),
  })  : limit = Value(limit),
        maxLimit = Value(maxLimit);
  static Insertable<LimitData> custom({
    Expression<int>? id,
    Expression<int>? limit,
    Expression<int>? maxLimit,
    Expression<DateTime>? lastGeneratedDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (limit != null) 'limit': limit,
      if (maxLimit != null) 'max_limit': maxLimit,
      if (lastGeneratedDate != null) 'last_generated_date': lastGeneratedDate,
    });
  }

  LimitCompanion copyWith(
      {Value<int>? id,
      Value<int>? limit,
      Value<int>? maxLimit,
      Value<DateTime>? lastGeneratedDate}) {
    return LimitCompanion(
      id: id ?? this.id,
      limit: limit ?? this.limit,
      maxLimit: maxLimit ?? this.maxLimit,
      lastGeneratedDate: lastGeneratedDate ?? this.lastGeneratedDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (limit.present) {
      map['limit'] = Variable<int>(limit.value);
    }
    if (maxLimit.present) {
      map['max_limit'] = Variable<int>(maxLimit.value);
    }
    if (lastGeneratedDate.present) {
      map['last_generated_date'] = Variable<DateTime>(lastGeneratedDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LimitCompanion(')
          ..write('id: $id, ')
          ..write('limit: $limit, ')
          ..write('maxLimit: $maxLimit, ')
          ..write('lastGeneratedDate: $lastGeneratedDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoriteTable favorite = $FavoriteTable(this);
  late final $LimitTable limit = $LimitTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [favorite, limit];
}

typedef $$FavoriteTableCreateCompanionBuilder = FavoriteCompanion Function({
  Value<int> id,
  required String content,
  required String originalContent,
  required DateTime createdAt,
});
typedef $$FavoriteTableUpdateCompanionBuilder = FavoriteCompanion Function({
  Value<int> id,
  Value<String> content,
  Value<String> originalContent,
  Value<DateTime> createdAt,
});

class $$FavoriteTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteTable> {
  $$FavoriteTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get originalContent => $composableBuilder(
      column: $table.originalContent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$FavoriteTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteTable> {
  $$FavoriteTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get originalContent => $composableBuilder(
      column: $table.originalContent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$FavoriteTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteTable> {
  $$FavoriteTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get originalContent => $composableBuilder(
      column: $table.originalContent, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FavoriteTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FavoriteTable,
    FavoriteData,
    $$FavoriteTableFilterComposer,
    $$FavoriteTableOrderingComposer,
    $$FavoriteTableAnnotationComposer,
    $$FavoriteTableCreateCompanionBuilder,
    $$FavoriteTableUpdateCompanionBuilder,
    (FavoriteData, BaseReferences<_$AppDatabase, $FavoriteTable, FavoriteData>),
    FavoriteData,
    PrefetchHooks Function()> {
  $$FavoriteTableTableManager(_$AppDatabase db, $FavoriteTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> originalContent = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              FavoriteCompanion(
            id: id,
            content: content,
            originalContent: originalContent,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String content,
            required String originalContent,
            required DateTime createdAt,
          }) =>
              FavoriteCompanion.insert(
            id: id,
            content: content,
            originalContent: originalContent,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FavoriteTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FavoriteTable,
    FavoriteData,
    $$FavoriteTableFilterComposer,
    $$FavoriteTableOrderingComposer,
    $$FavoriteTableAnnotationComposer,
    $$FavoriteTableCreateCompanionBuilder,
    $$FavoriteTableUpdateCompanionBuilder,
    (FavoriteData, BaseReferences<_$AppDatabase, $FavoriteTable, FavoriteData>),
    FavoriteData,
    PrefetchHooks Function()>;
typedef $$LimitTableCreateCompanionBuilder = LimitCompanion Function({
  Value<int> id,
  required int limit,
  required int maxLimit,
  Value<DateTime> lastGeneratedDate,
});
typedef $$LimitTableUpdateCompanionBuilder = LimitCompanion Function({
  Value<int> id,
  Value<int> limit,
  Value<int> maxLimit,
  Value<DateTime> lastGeneratedDate,
});

class $$LimitTableFilterComposer extends Composer<_$AppDatabase, $LimitTable> {
  $$LimitTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get limit => $composableBuilder(
      column: $table.limit, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxLimit => $composableBuilder(
      column: $table.maxLimit, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastGeneratedDate => $composableBuilder(
      column: $table.lastGeneratedDate,
      builder: (column) => ColumnFilters(column));
}

class $$LimitTableOrderingComposer
    extends Composer<_$AppDatabase, $LimitTable> {
  $$LimitTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get limit => $composableBuilder(
      column: $table.limit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxLimit => $composableBuilder(
      column: $table.maxLimit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastGeneratedDate => $composableBuilder(
      column: $table.lastGeneratedDate,
      builder: (column) => ColumnOrderings(column));
}

class $$LimitTableAnnotationComposer
    extends Composer<_$AppDatabase, $LimitTable> {
  $$LimitTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get limit =>
      $composableBuilder(column: $table.limit, builder: (column) => column);

  GeneratedColumn<int> get maxLimit =>
      $composableBuilder(column: $table.maxLimit, builder: (column) => column);

  GeneratedColumn<DateTime> get lastGeneratedDate => $composableBuilder(
      column: $table.lastGeneratedDate, builder: (column) => column);
}

class $$LimitTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LimitTable,
    LimitData,
    $$LimitTableFilterComposer,
    $$LimitTableOrderingComposer,
    $$LimitTableAnnotationComposer,
    $$LimitTableCreateCompanionBuilder,
    $$LimitTableUpdateCompanionBuilder,
    (LimitData, BaseReferences<_$AppDatabase, $LimitTable, LimitData>),
    LimitData,
    PrefetchHooks Function()> {
  $$LimitTableTableManager(_$AppDatabase db, $LimitTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LimitTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LimitTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LimitTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> limit = const Value.absent(),
            Value<int> maxLimit = const Value.absent(),
            Value<DateTime> lastGeneratedDate = const Value.absent(),
          }) =>
              LimitCompanion(
            id: id,
            limit: limit,
            maxLimit: maxLimit,
            lastGeneratedDate: lastGeneratedDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int limit,
            required int maxLimit,
            Value<DateTime> lastGeneratedDate = const Value.absent(),
          }) =>
              LimitCompanion.insert(
            id: id,
            limit: limit,
            maxLimit: maxLimit,
            lastGeneratedDate: lastGeneratedDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LimitTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LimitTable,
    LimitData,
    $$LimitTableFilterComposer,
    $$LimitTableOrderingComposer,
    $$LimitTableAnnotationComposer,
    $$LimitTableCreateCompanionBuilder,
    $$LimitTableUpdateCompanionBuilder,
    (LimitData, BaseReferences<_$AppDatabase, $LimitTable, LimitData>),
    LimitData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoriteTableTableManager get favorite =>
      $$FavoriteTableTableManager(_db, _db.favorite);
  $$LimitTableTableManager get limit =>
      $$LimitTableTableManager(_db, _db.limit);
}
