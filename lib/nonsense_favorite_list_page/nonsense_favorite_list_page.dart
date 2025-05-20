import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nonsense_generator/database/database.dart';
import 'package:nonsense_generator/database/database_singleton.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// お気に入りリストページストア
class NonenseFavoriteListPageStore extends ChangeNotifier {
  final database = DatabaseSingleton().database;
  late Stream<List<FavoriteData>> existedContent =
      (database.select(database.favorite)).watch();

  void deleteFavorite(int id) async {
    await (database.delete(database.favorite)..where((t) => t.id.equals(id)))
        .go();
  }
}

/// お気に入りリストページ
class NonenseFavoriteListPage extends StatelessWidget {
  const NonenseFavoriteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nonenseFavoriteListPageStore =
        Provider.of<NonenseFavoriteListPageStore>(context);

    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: <Widget>[
          Expanded(
            child: Align(
                alignment: Alignment.topRight,
                child: StreamBuilder(
                  stream: nonenseFavoriteListPageStore.existedContent,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<FavoriteData>> snapshot) {
                    if (snapshot.data?.isNotEmpty ?? false) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(
                                  snapshot.data![index].content,
                                ),
                              ),
                              ListBody(
                                children: [
                                  Text(
                                      "Original: ${snapshot.data![index].originalContent}")
                                ],
                              ),
                              ListBody(
                                children: [
                                  Text(snapshot.data![index].createdAt
                                      .toIso8601String())
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    iconSize: 20,
                                    icon: const FaIcon(
                                        FontAwesomeIcons.shareNodes),
                                    onPressed: () async => await Share.share(
                                        """${snapshot.data![index].content}
#NonsenseGenerator"""),
                                  ),
                                  IconButton(
                                      onPressed: () => {
                                            nonenseFavoriteListPageStore
                                                .deleteFavorite(
                                                    snapshot.data![index].id)
                                          },
                                      icon: const Icon(Icons.delete)),
                                ],
                              )
                            ],
                          );
                        },
                      );
                    } else {
                      return const Text("No Data");
                    }
                  },
                )),
          ),
          ListTile(
            title: Text(
              "Privacy Policy",
              style: const TextStyle(color: Colors.blue),
            ),
            onTap: () => {
              launchUrl(Uri.parse(
                  "https://luxun1910.github.io/unanimousworks_privacy_policy/nonsense_generator.html"))
            },
          )
        ]),
      ),
    );
  }
}
