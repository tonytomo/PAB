import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:Dompet.in/classes/budget.dart';
import 'package:Dompet.in/classes/history.dart';
import 'package:Dompet.in/splashscreen.dart';
import 'classes/saldo.dart';
import 'package:Dompet.in/home_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:Dompet.in/base_page.dart';
import 'package:workmanager/workmanager.dart';


List<Box> boxList = [];

Future<List<Box>> _openBox() async {
  var boxHistory = await Hive.openBox('history');
  var boxBalance = await Hive.openBox("saldo");
  var boxBudgetDaily = await Hive.openBox('budgetdaily');
  var boxBudgetWeekly = await Hive.openBox('budgetweekly');
  var boxBudgetMonthly = await Hive.openBox('budgetmonthly');
  boxList.add(boxHistory);
  boxList.add(boxBalance);
  boxList.add(boxBudgetDaily);
  boxList.add(boxBudgetWeekly);
  boxList.add(boxBudgetMonthly);
  return boxList;
}

const dailyTask = "dailyTask";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case dailyTask:
       // sesuatu
        break;
    }
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  final appDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);

  Hive.registerAdapter(HistoryAdapter());
  Hive.registerAdapter(SaldoAdapter());
  Hive.registerAdapter(BudgetListAdapter());

  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dompet.in",
      theme: ThemeData(fontFamily: 'Oswald'),
      home: FutureBuilder(
        future: _openBox(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else {
              if (Hive.box('saldo').isEmpty) Hive.box('saldo').put(0, Saldo(0));
              return SplashScreen();
            }
          } else
            return Scaffold();
        },
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
