import 'package:nonsense_generator/database/database.dart';

/// データベースシングルトン
class DatabaseSingleton {
  static final DatabaseSingleton _instance = DatabaseSingleton._internal();

  final database = AppDatabase();

  factory DatabaseSingleton() {
    return _instance;
  }

  DatabaseSingleton._internal();
}
