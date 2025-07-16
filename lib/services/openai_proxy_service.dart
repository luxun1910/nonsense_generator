import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nonsense_generator/logger_singleton.dart';
import 'package:nonsense_generator/services/firebase_auth_service.dart';

/// OpenAIプロキシサービス
class OpenAIProxyService {
  static final OpenAIProxyService _instance = OpenAIProxyService._internal();
  factory OpenAIProxyService() => _instance;
  OpenAIProxyService._internal();

  final FirebaseAuthService _authService = FirebaseAuthService();

  /// OpenAI APIプロキシにメッセージを送信（ストリーミング）
  Stream<String> sendMessageStream({
    required String userMessage,
    String systemMessage =
        "入力された文章に対して、元の文章の構造をあまり大きく変えないようにした上で、支離滅裂な文章に変換してください。入力された文章の文字数からプラスマイナス20パーセントの増減は許容します。",
    String model = "gpt-4.1-nano",
    int maxTokens = 100,
    double temperature = 1.3,
    double topP = 1.0,
    double frequencyPenalty = 2.0,
    double presencePenalty = 2.0,
  }) async* {
    try {
      // Firebase認証トークンを取得
      final String? idToken = await _authService.getIdToken();
      if (idToken == null) {
        throw Exception('認証トークンの取得に失敗しました');
      }

      // リクエストボディを作成
      final Map<String, dynamic> requestBody = {
        'systemMessage': systemMessage,
        'userMessage': userMessage,
        'model': model,
        'maxTokens': maxTokens,
        'temperature': temperature,
        'topP': topP,
        'frequencyPenalty': frequencyPenalty,
        'presencePenalty': presencePenalty,
        'stream': true, // ストリーミングを有効にする
      };

      // HTTPリクエストを作成
      final request = http.Request('POST',
          Uri.parse("https://openaiproxy-axttcofzkq-an.a.run.app/openAIProxy"));
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
      });
      request.body = json.encode(requestBody);

      LoggerSingleton.logger.i('OpenAIプロキシにリクエスト送信中...');

      // ストリーミングレスポンスを開始
      final http.StreamedResponse response = await request.send();

      if (response.statusCode != 200) {
        final errorBody = await response.stream.bytesToString();
        LoggerSingleton.logger
            .e('OpenAIプロキシエラー: ${response.statusCode} - $errorBody');
        throw Exception('OpenAIプロキシエラー: ${response.statusCode}');
      }

      LoggerSingleton.logger.i('OpenAIプロキシからのストリーミング開始');

      // Server-Sent Eventsの解析
      await for (String line in response.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter())) {
        // SSE形式のデータを処理
        if (line.startsWith('data: ')) {
          final String data = line.substring(6); // "data: "を除去

          // ストリーム終了の場合
          if (data.trim() == '[DONE]') {
            LoggerSingleton.logger.i('ストリーミング完了');
            break;
          }

          // JSONデータを解析
          try {
            final Map<String, dynamic> jsonData = json.decode(data);

            // テキストコンテンツを抽出
            if (jsonData.containsKey('choices') &&
                jsonData['choices'] is List &&
                jsonData['choices'].isNotEmpty) {
              final choice = jsonData['choices'][0];
              if (choice.containsKey('delta') &&
                  choice['delta'].containsKey('content')) {
                final String? content = choice['delta']['content'];
                if (content != null && content.isNotEmpty) {
                  yield content;
                }
              }
            }
          } catch (e) {
            LoggerSingleton.logger.w('JSON解析エラー: $e, データ: $data');
            // JSON解析エラーは無視して続行
            continue;
          }
        }
      }
    } catch (e) {
      LoggerSingleton.logger.e('OpenAIプロキシサービスエラー: $e');
      throw Exception('OpenAIプロキシサービスエラー: $e');
    }
  }
}
