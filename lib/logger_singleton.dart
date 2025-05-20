import 'package:logger/logger.dart';

/// ロガーシングルトン
class LoggerSingleton {
  static final LoggerSingleton _instance = LoggerSingleton._internal();

  static final logger = Logger();

  factory LoggerSingleton() {
    return _instance;
  }

  LoggerSingleton._internal();
}
