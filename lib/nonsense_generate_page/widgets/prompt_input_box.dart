import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromptInputBoxStore extends ChangeNotifier {
  // the message user will input.
  String sendingMessage = "";

  bool get isAnyMessage => sendingMessage.isNotEmpty;

  setInputText(String text) {
    sendingMessage = text;
    notifyListeners();
  }
}

class PromptInputBox extends StatelessWidget {
  const PromptInputBox({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PromptInputBoxStore>(context, listen: false);
    return TextField(
      controller: TextEditingController(text: store.sendingMessage),
      maxLength: 100,
      maxLines: 4,
      decoration: const InputDecoration(
        icon: Icon(Icons.android),
        hintText: "Please enter your original prompt to generate nonsense!",
        labelText: "Prompt",
      ),
      onChanged: (String txt) => store.setInputText(txt),
    );
  }
}
