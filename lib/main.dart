import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pab_dompet/classes/budget.dart';
import 'package:pab_dompet/classes/history.dart';
import 'classes/saldo.dart';
import 'package:pab_dompet/home_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:pab_dompet/base_page.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      title: "Coba Aja",
      theme: ThemeData(fontFamily: 'Oswald'),
      home: FutureBuilder(
        future: _openBox(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else {
              if (Hive.box('saldo').isEmpty) Hive.box('saldo').put(0, Saldo(0));
              return Base();
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
