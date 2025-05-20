import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nonsense_generator/database/database.dart';
import 'package:nonsense_generator/database/database_singleton.dart';

class LimitNumInfoStore extends ChangeNotifier with WidgetsBindingObserver {
  LimitNumInfoStore() {
    WidgetsBinding.instance.addObserver(this);
    resetLimit();
    notifyListeners();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      resetLimit();
    }
  }

  void resetLimit() async {
    LimitData limitData = await (database.select(database.limit)
          ..orderBy([
            (x) => OrderingTerm(
                expression: x.lastGeneratedDate, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .getSingle();

    // the next day
    if (DateTime.now().isAfter(limitData.lastGeneratedDate) &&
        (limitData.lastGeneratedDate.day != DateTime.now().day ||
            limitData.lastGeneratedDate.month != DateTime.now().month ||
            limitData.lastGeneratedDate.year != DateTime.now().year)) {
      await (database.update(database.limit)
            ..where((t) => t.id.equals(limitData.id)))
          .write(
        LimitCompanion(
          lastGeneratedDate: Value(DateTime.now()),
          limit: const Value(5),
        ),
      );
      notifyListeners();
    } else {
      return;
    }
  }

  final database = DatabaseSingleton().database;
  late final Stream<LimitData> existedContent = (database.select(database.limit)
        ..orderBy([
          (x) => OrderingTerm(
              expression: x.lastGeneratedDate, mode: OrderingMode.desc)
        ])
        ..limit(1))
      .watchSingle();

  late final Future<LimitData> existedContentFuture =
      (database.select(database.limit)
            ..orderBy([
              (x) => OrderingTerm(
                  expression: x.lastGeneratedDate, mode: OrderingMode.desc)
            ])
            ..limit(1))
          .getSingle();

  void decreaseTime() async {
    LimitData limitData = await (database.select(database.limit)
          ..orderBy([
            (x) => OrderingTerm(
                expression: x.lastGeneratedDate, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .getSingle();

    var targetNum = limitData.limit;

    if (targetNum >= 1) {
      targetNum--;
    }

    await (database.update(database.limit)
          ..where((t) => t.id.equals(limitData.id)))
        .write(
      LimitCompanion(
        limit: Value(targetNum),
        lastGeneratedDate: Value(DateTime.now()),
      ),
    );

    notifyListeners();
  }
}

class LimitNumInfo extends StatelessWidget {
  const LimitNumInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<LimitNumInfoStore>(context);
    return StreamBuilder(
      stream: store.existedContent,
      builder: (BuildContext context, AsyncSnapshot<LimitData> snapshot) {
        if (snapshot.hasData) {
          return Text(
              "${snapshot.data!.limit.toString()}/${snapshot.data!.maxLimit.toString()}");
        } else {
          return Container();
        }
      },
    );
  }
}
