import 'package:dart_openai/dart_openai.dart';

/// OpenAIシステムメッセージ設定
class OpenAISystem {
  static final systemMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        "入力された文章に対して、元の文章の構造をあまり大きく変えないようにした上で、支離滅裂な文章に変換してください。入力された文章の文字数からプラスマイナス20パーセントの増減は許容します。",
      ),
    ],
    role: OpenAIChatMessageRole.system,
  );
}
