import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nonsense_generator/database/database.dart';
import 'package:nonsense_generator/database/database_singleton.dart';
import 'package:nonsense_generator/nonsense_generate_page/nonsense_generate_controller.dart';
import 'package:nonsense_generator/nonsense_generate_page/widgets/prompt_input_box.dart';
import 'package:provider/provider.dart';

class NonsenseOutputBoxStore extends ChangeNotifier {
  // the message user will get.
  String returnedMessage = "";

  bool hasMessageReturned = false;

  final fToast = FToast();

  final database = DatabaseSingleton().database;

  void addMessage(String message) {
    returnedMessage += message;
    notifyListeners();
  }

  void changeMessage(String message) {
    returnedMessage = message;
    notifyListeners();
  }

  void makeMessageReturned() {
    hasMessageReturned = true;
    notifyListeners();
  }

  void makeMessageUnreturned() {
    hasMessageReturned = false;
    notifyListeners();
  }

  void makeFavorite(String originalMessage) async {
    await database.into(database.favorite).insert(FavoriteCompanion.insert(
        content: returnedMessage,
        originalContent: originalMessage,
        createdAt: DateTime.now()));
    notifyListeners();
    _showToast("Added to favorites.");
  }

  void makeUnfavorite() async {
    await (database.delete(database.favorite)
          ..where((t) => t.content.equals(returnedMessage)))
        .go();
    notifyListeners();
    _showToast("Deleted from favorites.");
  }

  void _showToast(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check),
          const SizedBox(
            width: 12.0,
          ),
          Text(text),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
}

class NonsenseOutputBox extends StatelessWidget {
  const NonsenseOutputBox({super.key});

  @override
  Widget build(BuildContext context) {
    final nonsenseOutputBoxStore = Provider.of<NonsenseOutputBoxStore>(context);
    final promptInputBoxStore = Provider.of<PromptInputBoxStore>(context);
    final controller =
        Provider.of<NonsenseGeneratorController>(context, listen: false);
    nonsenseOutputBoxStore.fToast.init(context);
    final existedContent = (nonsenseOutputBoxStore.database
            .select(nonsenseOutputBoxStore.database.favorite)
          ..where((row) =>
              row.content.equals(nonsenseOutputBoxStore.returnedMessage)))
        .watch();

    return Column(
      children: [
        // don't use TextField's suffixIcon parameter because you can't change its vertical place from the center
        Scrollbar(
          child: TextField(
            controller: TextEditingController(
                text: nonsenseOutputBoxStore.returnedMessage),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(""))],
            readOnly: true,
            maxLines: 5,
            decoration: const InputDecoration(
              fillColor: Colors.black,
              icon: Icon(Icons.android),
              labelText: "Nonsense to be generated",
            ),
          ),
        ),
        !nonsenseOutputBoxStore.hasMessageReturned
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  StreamBuilder(
                      stream: existedContent,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<FavoriteData>> snapshot) {
                        if (snapshot.data?.isEmpty ?? true) {
                          return IconButton(
                              iconSize: 25,
                              icon: const Icon(Icons.star_border),
                              onPressed: () => {
                                    nonsenseOutputBoxStore.makeFavorite(
                                        promptInputBoxStore.sendingMessage),
                                  });
                        } else {
                          return IconButton(
                              iconSize: 25,
                              icon: const Icon(Icons.star),
                              onPressed: () => {
                                    nonsenseOutputBoxStore.makeUnfavorite(),
                                  });
                        }
                      }),
                  IconButton(
                    iconSize: 20,
                    icon: const FaIcon(FontAwesomeIcons.shareNodes),
                    onPressed: () => controller.share(),
                  ),
                ],
              ),
      ],
    );
  }
}
