import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'classes/history.dart';
import 'package:Dompet.in/classes/history.dart';
import 'classes/saldo.dart';
import 'customExtensions/string_operation.dart';

class Graph extends StatefulWidget {
  @override
  _GraphState createState() => _GraphState();
}

final historyBox = Hive.box('history');
final saldoBox = Hive.box('saldo');

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leading: Icon(Icons.insert_chart_outlined_rounded),
          title: Text("Graph"),
          backgroundColor: Colors.teal[700]),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 2.0, color: Colors.grey)),
              ),
              child: _ExpansionTileIncome("Income"),
            ),
            Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 2.0, color: Colors.grey)),
              ),
              child: _ExpansionTileOutcome("Outcome"),
            ),
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 2.0, color: Colors.grey)),
              ),
              padding: EdgeInsets.all(15),
              child: _RowBalance("Total"),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 2.0, color: Colors.grey[100])),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Prediksi Pendapatan per Tahun",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 2.0, color: Colors.grey)),
                    ),
                    padding: EdgeInsets.all(15),
                    child: _Row("Pemasukan", 60000),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 2.0, color: Colors.grey)),
                    ),
                    padding: EdgeInsets.all(15),
                    child: _Row("Pengeluaran", 20000),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 2.0, color: Colors.grey)),
                      ),
                      padding: EdgeInsets.all(15),
                      child: _Row("Total", 40000)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _RowBalance(String string) {
  var balance = saldoBox.getAt(0) as Saldo;
  var number = balance.nom.toString();
  return Container(
      alignment: Alignment.centerLeft,
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            string,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ),
        Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                "Rp " + number,
                style: TextStyle(fontSize: 20),
              ),
            )),
      ]));
}

Widget _Row(String string, int num) {
  var number = num.toString();
  return Container(
      alignment: Alignment.centerLeft,
      child:
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            string,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ),
        Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                "Rp " + number,
                style: TextStyle(fontSize: 20),
              ),
            )),
      ]));
}

Widget _ExpansionTileIncome(String title) {
  return WatchBoxBuilder(
      box: Hive.box('history'),
      builder: (context, historyBox) {
        return ExpansionTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          children: <Widget>[
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
                height: 0,
              ),
              itemCount: historyBox.length < 10 ? historyBox.length : 10,
              itemBuilder: (context, index) {
                final history = historyBox.getAt(index) as History;
                if (history.sym == "+") {
                  return ListTile(
                    title: Text("${history.nominal}"),
                  );
                } else {
                  return SizedBox(height: 0,);
                  // return ListTile(
                  //   title: Text("Outcome"),
                  // );
                }
              },
            ),
          ],
        );
      });
}

Widget _ExpansionTileOutcome(String title) {
  return WatchBoxBuilder(
      box: Hive.box('history'),
      builder: (context, historyBox) {
        return ExpansionTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          children: <Widget>[
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
                height: 0,
              ),
              itemCount: historyBox.length < 10 ? historyBox.length : 10,
              itemBuilder: (context, index) {
                final history = historyBox.getAt(index) as History;
                if (history.sym == "-") {
                  return ListTile(
                    title: Text("${history.nominal}"),
                  );
                } else {
                  return SizedBox(height: 0,);
                  // return ListTile(
                  //   title: Text("Income"),
                  // );
                }
              },
            ),
          ],
        );
      });
}
