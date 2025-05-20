import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:nonsense_generator/logger_singleton.dart';
import 'package:nonsense_generator/nonsense_generate_page/widgets/generate_button.dart';
import 'package:nonsense_generator/nonsense_generate_page/widgets/limit_num_info.dart';
import 'package:nonsense_generator/nonsense_generate_page/widgets/nonsense_output_box.dart';
import 'package:nonsense_generator/open_ai_system.dart';
import 'package:nonsense_generator/nonsense_generate_page/widgets/prompt_input_box.dart';
import 'package:nonsense_generator/database/database.dart';
import 'package:share_plus/share_plus.dart';

/// ナンセンス生成ページコントローラー
class NonsenseGeneratorController extends WidgetsBindingObserver {
  NonsenseGeneratorController(
      this._promptInputBoxStore,
      this._nonsenseOutputBoxStore,
      this._generateButtonStore,
      this._limitNumInfoStore) {
    WidgetsBinding.instance.addObserver(this);
  }

  /// プロンプト入力ボックスストア
  final PromptInputBoxStore _promptInputBoxStore;

  /// ナンセンス出力ボックスストア
  final NonsenseOutputBoxStore _nonsenseOutputBoxStore;

  /// 生成ボタンストア
  final GenerateButtonStore _generateButtonStore;

  /// 生成回数制限情報ストア
  final LimitNumInfoStore _limitNumInfoStore;

  /// チャットストリーム設定
  void setChatStream() async {
    LimitData limitData = await _limitNumInfoStore.existedContentFuture;

    if (_generateButtonStore.pushed ||
        !_promptInputBoxStore.isAnyMessage ||
        limitData.limit <= 0) {
      return null;
    }

    _nonsenseOutputBoxStore.makeMessageUnreturned();

    _nonsenseOutputBoxStore.changeMessage("Wait a sec...");
    _generateButtonStore.makePushed();
    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          _promptInputBoxStore.sendingMessage,
        ),
      ],
      role: OpenAIChatMessageRole.user,
    );

    final chatStream = OpenAI.instance.chat.createStream(
      model: "gpt-4o-mini",
      messages: [
        OpenAISystem.systemMessage,
        userMessage,
      ],
      maxTokens: 100,
      temperature: 1.3,
      topP: 1,
      frequencyPenalty: 2,
      presencePenalty: 2,
    );

    bool textHasCome = false;
    bool isError = false;

    try {
      await for (var streamChatCompletion in chatStream) {
        if (!textHasCome) {
          _nonsenseOutputBoxStore.changeMessage("");
          textHasCome = true;
        }

        final text =
            streamChatCompletion.choices.first.delta.content?.first?.text ?? "";
        _nonsenseOutputBoxStore.addMessage(text);
      }
    } catch (e) {
      LoggerSingleton.logger.e(e);
      _nonsenseOutputBoxStore.changeMessage("Error!");
      isError = true;
    }

    _generateButtonStore.makeUnpushed();
    if (!isError) {
      _limitNumInfoStore.decreaseTime();
    }
    _nonsenseOutputBoxStore.makeMessageReturned();
  }

  /// ナンセンス共有
  void share() async {
    await Share.share("""${_nonsenseOutputBoxStore.returnedMessage}
#NonsenseGenerator""");
  }
}
