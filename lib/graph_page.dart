import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'budget_page.dart';
import 'classes/history.dart';
import 'classes/history.dart';
import 'classes/saldo.dart';
import 'classes/budget.dart';
import 'customExtensions/string_operation.dart';

class Graph extends StatefulWidget {
  @override
  _GraphState createState() => _GraphState();
}

final historyBox = Hive.box('history');
final saldoBox = Hive.box('saldo');

final budgetDailyBox = Hive.box('budgetdaily');
final budgetWeeklyBox = Hive.box('budgetweekly');
final budgetMonthlyBox = Hive.box('budgetmonthly');

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
                    child: _RowIncome("Pemasukan"),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 2.0, color: Colors.grey)),
                    ),
                    padding: EdgeInsets.all(15),
                    child: _RowOutcome("Pengeluaran"),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 2.0, color: Colors.grey)),
                      ),
                      padding: EdgeInsets.all(15),
                      child: _RowTotal("Total")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int income, outcome;

Widget _RowIncome(String string) {
  int sum = 0;
  for (int i = 0; i < budgetDailyBox.length; i++) {
    final budget = budgetDailyBox.getAt(i) as BudgetList;
    if (budget.sym == "+") {
      sum += budget.nom * 365;
    }
  }

  for (int i = 0; i < budgetWeeklyBox.length; i++) {
    final budget = budgetWeeklyBox.getAt(i) as BudgetList;
    if (budget.sym == "+") {
      sum += budget.nom * 52;
    }
  }

  for (int i = 0; i < budgetMonthlyBox.length; i++) {
    final budget = budgetMonthlyBox.getAt(i) as BudgetList;
    if (budget.sym == "+") {
      sum += budget.nom * 12;
    }
  }
  income = sum;
  return _Row(string, sum);
}

Widget _RowOutcome(String string) {
  int sum = 0;
  for (int i = 0; i < budgetDailyBox.length; i++) {
    final budget = budgetDailyBox.getAt(i) as BudgetList;
    if (budget.sym == "-") {
      sum += budget.nom * 365;
    }
  }

  for (int i = 0; i < budgetWeeklyBox.length; i++) {
    final budget = budgetWeeklyBox.getAt(i) as BudgetList;
    if (budget.sym == "-") {
      sum += budget.nom * 52;
    }
  }

  for (int i = 0; i < budgetMonthlyBox.length; i++) {
    final budget = budgetMonthlyBox.getAt(i) as BudgetList;
    if (budget.sym == "-") {
      sum += budget.nom * 12;
    }
  }
  outcome = sum;
  return _Row(string, sum);
}

Widget _RowTotal(String string) {
  int total;
  total = income - outcome;

  return _Row(string, total);
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
      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
                  return Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 2.0, color: Colors.grey)),
                      ),
                      padding: EdgeInsets.all(15),
                      child: _Row(history.ket, history.nominal));
                } else {
                  return SizedBox(
                    height: 0,
                  );
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
                  return Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(15),
                      child: _Row(history.ket, history.nominal));
                } else {
                  return SizedBox(
                    height: 0,
                  );
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
