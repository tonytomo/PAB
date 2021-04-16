import 'package:flutter/material.dart';
import 'package:pab_dompet/base_page.dart';

import 'package:pab_dompet/home_page.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Coba Aja",
        home: Base()
    );
  }
}