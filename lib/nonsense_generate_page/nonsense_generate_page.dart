import 'package:flutter/material.dart';
import 'package:nonsense_generator/nonsense_generate_page/widgets/generate_button.dart';
import 'package:nonsense_generator/nonsense_generate_page/widgets/limit_num_info.dart';
import 'package:nonsense_generator/nonsense_generate_page/widgets/nonsense_output_box.dart';
import 'package:nonsense_generator/nonsense_generate_page/widgets/prompt_input_box.dart';

/// ナンセンス生成ページ
class NonenseGeneratePage extends StatelessWidget {
  const NonenseGeneratePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topRight,
                child: LimitNumInfo(),
              ),
            ),
            Expanded(
              flex: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PromptInputBox(),
                  GenerateButton(),
                  NonsenseOutputBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
