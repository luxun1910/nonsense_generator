import 'package:firebase_auth/firebase_auth.dart';
import 'package:nonsense_generator/logger_singleton.dart';

/// Firebase認証サービス
class FirebaseAuthService {
  static final FirebaseAuthService _instance = FirebaseAuthService._internal();
  factory FirebaseAuthService() => _instance;
  FirebaseAuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 匿名ログイン
  Future<User?> signInAnonymously() async {
    try {
      final UserCredential result = await _auth.signInAnonymously();
      LoggerSingleton.logger.i('Firebase匿名認証成功: ${result.user?.uid}');
      return result.user;
    } catch (e) {
      LoggerSingleton.logger.e('Firebase匿名認証失敗: $e');
      return null;
    }
  }

  /// 現在のユーザーを取得
  User? get currentUser => _auth.currentUser;

  /// IDトークンを取得
  Future<String?> getIdToken() async {
    try {
      final User? user = currentUser;
      if (user == null) {
        LoggerSingleton.logger.w('ユーザーが認証されていません');
        return null;
      }

      final String? token = await user.getIdToken();
      LoggerSingleton.logger.i('IDトークン取得成功');
      return token;
    } catch (e) {
      LoggerSingleton.logger.e('IDトークン取得失敗: $e');
      return null;
    }
  }

  /// 認証状態が変更されたかを監視
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// ユーザーが認証されているかを確認
  bool get isAuthenticated => currentUser != null;
}
