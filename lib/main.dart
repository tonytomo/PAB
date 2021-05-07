import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pab_dompet/classes/history.dart';
import 'package:pab_dompet/home_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:pab_dompet/base_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDirectory =
  await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);
  Hive.registerAdapter(HistoryAdapter());
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
        future: Hive.openBox('history'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else
              return Base();
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
