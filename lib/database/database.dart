import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

/// お気に入りテーブル
class Favorite extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text()();
  TextColumn get originalContent => text()();
  DateTimeColumn get createdAt => dateTime()();
}

/// 生成回数制限テーブル
class Limit extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get limit => integer()();
  IntColumn get maxLimit => integer()();
  DateTimeColumn get lastGeneratedDate =>
      dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [Favorite, Limit])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/getting-started/#open
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    // `driftDatabase` from `package:drift_flutter` stores the database in
    // `getApplicationDocumentsDirectory()`.
    return driftDatabase(name: 'my_database');
  }
}
