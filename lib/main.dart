import 'package:flutter/material.dart';
import 'package:pab_dompet/base_page.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Coba Aja",
        theme: ThemeData(fontFamily: 'Oswald'),
        home: Base());
  }
}
