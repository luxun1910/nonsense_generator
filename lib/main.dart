import 'dart:io';
import 'package:drift/drift.dart' as dart;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:nonsense_generator/ad/banner_ad_model.dart';
import 'package:nonsense_generator/ad/banner_ad_page.dart';
import 'package:nonsense_generator/database/database.dart';
import 'package:nonsense_generator/database/database_singleton.dart';
import 'package:nonsense_generator/nonsense_favorite_list_page/nonsense_favorite_list_page.dart';
import 'package:nonsense_generator/nonsense_generate_page/nonsense_generate_page.dart';
import 'package:nonsense_generator/nonsense_generate_page/widgets/generate_button.dart';
import 'package:nonsense_generator/nonsense_generate_page/widgets/limit_num_info.dart';
import 'package:nonsense_generator/nonsense_generate_page/nonsense_generate_controller.dart';
import 'package:nonsense_generator/nonsense_generate_page/widgets/prompt_input_box.dart';
import 'package:nonsense_generator/nonsense_generate_page/widgets/nonsense_output_box.dart';
import 'package:nonsense_generator/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;

  WidgetsFlutterBinding.ensureInitialized();

  // Firebase初期化
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Firebase匿名認証
  final authService = FirebaseAuthService();
  await authService.signInAnonymously();

  if (Platform.isAndroid || Platform.isIOS) {
    MobileAds.instance.initialize();
  }

  // check the existence of the limit info
  final database = DatabaseSingleton().database;
  final exists = dart.existsQuery(database.select(database.limit));
  final row = await database.selectExpressions([exists]).getSingle();
  if (row.read(exists) == false) {
    await database
        .into(database.limit)
        .insert(LimitCompanion.insert(limit: 5, maxLimit: 5));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<BannerAdModel>(create: (_) => BannerAdModel()),
          ChangeNotifierProvider<PromptInputBoxStore>(
              create: (_) => PromptInputBoxStore()),
          ChangeNotifierProvider<GenerateButtonStore>(
              create: (_) => GenerateButtonStore()),
          ChangeNotifierProvider<NonsenseOutputBoxStore>(
              create: (_) => NonsenseOutputBoxStore()),
          ChangeNotifierProvider<LimitNumInfoStore>(
              create: (_) => LimitNumInfoStore()),
          ChangeNotifierProvider<NonenseFavoriteListPageStore>(
              create: (_) => NonenseFavoriteListPageStore()),
          ProxyProvider4<
              GenerateButtonStore,
              NonsenseOutputBoxStore,
              PromptInputBoxStore,
              LimitNumInfoStore,
              NonsenseGeneratorController>(
            update: (_, generateButtonStore, nonsenseOutputBoxStore,
                    promptInputBoxStore, limitNumInfoStore, __) =>
                NonsenseGeneratorController(
                    promptInputBoxStore,
                    nonsenseOutputBoxStore,
                    generateButtonStore,
                    limitNumInfoStore),
          )
        ],
        child: Builder(builder: (BuildContext context) {
          return MaterialApp(
              builder: FToastBuilder(),
              navigatorKey: GlobalKey<NavigatorState>(),
              title: 'Nonsense Generator',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: DefaultTabController(
                length: 2,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    title: const Text("Nonsense Generator"),
                  ),
                  body: const TabBarView(
                    children: [
                      NonenseGeneratePage(),
                      NonenseFavoriteListPage()
                    ],
                  ),
                  bottomNavigationBar: const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TabBar(
                        tabs: [
                          Tab(icon: Icon(Icons.abc)),
                          Tab(icon: Icon(Icons.star)),
                        ],
                      ),
                      BannerAdPage(),
                    ],
                  ),
                ),
              ));
        }));
  }
}
