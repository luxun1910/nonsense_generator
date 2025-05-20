import 'package:flutter/material.dart';
import 'package:nonsense_generator/database/database.dart';
import 'package:nonsense_generator/nonsense_generate_page/nonsense_generate_controller.dart';
import 'package:nonsense_generator/nonsense_generate_page/widgets/limit_num_info.dart';
import 'package:nonsense_generator/nonsense_generate_page/widgets/prompt_input_box.dart';
import 'package:provider/provider.dart';

class GenerateButtonStore extends ChangeNotifier {
  // if pushed the button
  bool pushed = false;

  void makePushed() {
    pushed = true;
    notifyListeners();
  }

  void makeUnpushed() {
    pushed = false;
    notifyListeners();
  }
}

class GenerateButton extends StatelessWidget {
  const GenerateButton({super.key});

  @override
  Widget build(BuildContext context) {
    final generateButtonStore = Provider.of<GenerateButtonStore>(context);
    final promptInputBoxStore = Provider.of<PromptInputBoxStore>(context);
    final limitNumInfoStore = Provider.of<LimitNumInfoStore>(context);

    return Column(
      children: [
        StreamBuilder(
          stream: limitNumInfoStore.existedContent,
          builder: (BuildContext context, AsyncSnapshot<LimitData> snapshot) {
            return TextButton(
                onPressed: generateButtonStore.pushed ||
                        !promptInputBoxStore.isAnyMessage ||
                        !snapshot.hasData ||
                        snapshot.data!.limit <= 0
                    ? null
                    : () => context
                        .read<NonsenseGeneratorController>()
                        .setChatStream(),
                child: const Text("Generate!"));
          },
        ),
      ],
    );
  }
}
