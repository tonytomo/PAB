import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home_page.dart';
import 'inputBudget.dart';
import 'package:cron/cron.dart';

import 'classes/budget.dart';
import 'classes/budget.dart';
import 'classes/history.dart';
import 'classes/saldo.dart';
import 'classes/budget.dart';

import 'customExtensions/ExpansionTile_alt.dart';

class Budget extends StatefulWidget {
  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  final budgetDailyBox = Hive.box('budgetdaily');
  final budgetWeeklyBox = Hive.box('budgetweekly');
  final budgetMonthlyBox = Hive.box('budgetmonthly');
  final historyBox = Hive.box('history');

  void deleteDailyBudget(int index) {
    budgetDailyBox.deleteAt(index);
  }

  void deleteWeeklyBudget(int index) {
    budgetWeeklyBox.deleteAt(index);
  }

  void deleteMonthlyBudget(int index) {
    budgetMonthlyBox.deleteAt(index);
  }

  _edit(String period, BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Edit Budget"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Nominal',
                    ),
                    onChanged: (String value) {
                      plus = int.parse(value);
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Keterangan',
                    ),
                    onChanged: (String value2) {
                      ket = value2;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text("Simpan"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {});
                },
              )
            ],
          );
        });
  }

  _deleteDaily(int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Anda yakin ingin menghapus?"),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  MaterialButton(
                    child: Text(
                      "Tidak",
                      style: TextStyle(
                        color: Colors.teal[700],
                      ),
                    ),
                    padding: EdgeInsets.all(15),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    child: Text(
                      "Iya",
                      style: TextStyle(
                        color: Colors.red[700],
                      ),
                    ),
                    padding: EdgeInsets.all(15),
                    onPressed: () {
                      budgetDailyBox.deleteAt(index);
                      // test[index].close();
                      // test.removeAt(index);
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          );
        });
  }

  _deleteWeekly(int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Anda yakin ingin menghapus?"),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  MaterialButton(
                    child: Text(
                      "Tidak",
                      style: TextStyle(
                        color: Colors.teal[700],
                      ),
                    ),
                    padding: EdgeInsets.all(15),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    child: Text(
                      "Iya",
                      style: TextStyle(
                        color: Colors.red[700],
                      ),
                    ),
                    padding: EdgeInsets.all(15),
                    onPressed: () {
                      budgetWeeklyBox.deleteAt(index);
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          );
        });
  }

  _deleteMonthly(int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Anda yakin ingin menghapus?"),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  MaterialButton(
                    child: Text(
                      "Tidak",
                      style: TextStyle(
                        color: Colors.teal[700],
                      ),
                    ),
                    padding: EdgeInsets.all(15),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    child: Text(
                      "Iya",
                      style: TextStyle(
                        color: Colors.red[700],
                      ),
                    ),
                    padding: EdgeInsets.all(15),
                    onPressed: () {
                      budgetMonthlyBox.deleteAt(index);
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          );
        });
  }

  Widget _buildListViewDaily() {
    return WatchBoxBuilder(
        box: Hive.box('budgetdaily'),
        builder: (context, budgetDailyBox) {
          return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                    height: 0,
                  ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(bottom: 8),
              itemCount: budgetDailyBox.length,
              itemBuilder: (context, index) {
                index = budgetDailyBox.length - 1 - index;
                var budget = budgetDailyBox.getAt(index) as BudgetList;
                return Column(
                  children: <Widget>[
                    MyExpansionTile(
                      title: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(8),
                        height: 50,
                        width: double.infinity,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Icon(
                                    budget.sym == "+"
                                        ? Icons.add_circle
                                        : Icons.remove_circle,
                                    color: budget.sym == "+"
                                        ? Colors.teal[700]
                                        : Colors.red[700],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  "   ${budget.nom}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "|",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.grey),
                                    ),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "${budget.ket}",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ))
                            ]),
                      ),
                      backgroundColor: Colors.white,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(
                                flex: 2,
                                child: ButtonTheme(
                                  minWidth: double.infinity,
                                  height: 50,
                                  child: RaisedButton(
                                    onPressed: () {
                                      if (budget.period == "Daily")
                                        _deleteDaily(index);
                                      else if (budget.period == "Weekly")
                                        _deleteWeekly(index);
                                      else if (budget.period == "Monthly")
                                        _deleteMonthly(index);
                                    },
                                    child:
                                        Icon(Icons.delete, color: Colors.white),
                                    color: Colors.red[700],
                                  ),
                                )),
                            Flexible(
                                flex: 2,
                                child: ButtonTheme(
                                  minWidth: double.infinity,
                                  height: 50,
                                  child: RaisedButton(
                                    onPressed: () {
                                      _edit(budget.period, context, index);
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    color: Colors.teal[700],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              });
        });
  }

  Widget _buildListViewWeekly() {
    return WatchBoxBuilder(
        box: Hive.box('budgetweekly'),
        builder: (context, budgetWeeklyBox) {
          return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                    height: 0,
                  ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(bottom: 8),
              itemCount: budgetWeeklyBox.length,
              itemBuilder: (context, index) {
                index = budgetWeeklyBox.length - 1 - index;
                var budget = budgetWeeklyBox.getAt(index) as BudgetList;
                return Column(
                  children: <Widget>[
                    MyExpansionTile(
                      title: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(8),
                        height: 50,
                        width: double.infinity,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Icon(
                                    budget.sym == "+"
                                        ? Icons.add_circle
                                        : Icons.remove_circle,
                                    color: budget.sym == "+"
                                        ? Colors.teal[700]
                                        : Colors.red[700],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  "   ${budget.nom}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "|",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.grey),
                                    ),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "${budget.ket}",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ))
                            ]),
                      ),
                      backgroundColor: Colors.white,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(
                                flex: 2,
                                child: ButtonTheme(
                                  minWidth: double.infinity,
                                  height: 50,
                                  child: RaisedButton(
                                    onPressed: () {
                                      if (budget.period == "Daily")
                                        _deleteDaily(index);
                                      else if (budget.period == "Weekly")
                                        _deleteWeekly(index);
                                      else if (budget.period == "Monthly")
                                        _deleteMonthly(index);
                                    },
                                    child:
                                        Icon(Icons.delete, color: Colors.white),
                                    color: Colors.red[700],
                                  ),
                                )),
                            Flexible(
                                flex: 2,
                                child: ButtonTheme(
                                  minWidth: double.infinity,
                                  height: 50,
                                  child: RaisedButton(
                                    onPressed: () {
                                      _edit(budget.period, context, index);
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    color: Colors.teal[700],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              });
        });
  }

  Widget _buildListViewMonthly() {
    return WatchBoxBuilder(
        box: Hive.box('budgetmonthly'),
        builder: (context, budgetMonthlyBox) {
          return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                    height: 0,
                  ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(bottom: 8),
              itemCount: budgetMonthlyBox.length,
              itemBuilder: (context, index) {
                index = budgetMonthlyBox.length - 1 - index;
                var budget = budgetMonthlyBox.getAt(index) as BudgetList;
                return Column(
                  children: <Widget>[
                    MyExpansionTile(
                      title: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(8),
                        height: 50,
                        width: double.infinity,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Icon(
                                    budget.sym == "+"
                                        ? Icons.add_circle
                                        : Icons.remove_circle,
                                    color: budget.sym == "+"
                                        ? Colors.teal[700]
                                        : Colors.red[700],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  "   ${budget.nom}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "|",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.grey),
                                    ),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "${budget.ket}",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ))
                            ]),
                      ),
                      backgroundColor: Colors.white,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(
                                flex: 2,
                                child: ButtonTheme(
                                  minWidth: double.infinity,
                                  height: 50,
                                  child: RaisedButton(
                                    onPressed: () {
                                      if (budget.period == "Daily")
                                        _deleteDaily(index);
                                      else if (budget.period == "Weekly")
                                        _deleteWeekly(index);
                                      else if (budget.period == "Monthly")
                                        _deleteMonthly(index);
                                    },
                                    child:
                                        Icon(Icons.delete, color: Colors.white),
                                    color: Colors.red[700],
                                  ),
                                )),
                            Flexible(
                                flex: 2,
                                child: ButtonTheme(
                                  minWidth: double.infinity,
                                  height: 50,
                                  child: RaisedButton(
                                    onPressed: () {
                                      _edit(budget.period, context, index);
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    color: Colors.teal[700],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            leading: Icon(Icons.calculate_outlined),
            title: Text("Budget"),
            backgroundColor: Colors.teal[700]),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                  flex: 2,
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => inputBudget("+")),
                        );
                      },
                      child: Text(
                        "+",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      color: Colors.teal[700],
                    ),
                  )),
              Flexible(
                  flex: 2,
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => inputBudget("-")),
                        );
                      },
                      child: Text(
                        "-",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      color: Colors.red[900],
                    ),
                  )),
            ],
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 2.0, color: Colors.grey)),
            ),
            child: Column(children: <Widget>[
              ExpansionTile(
                  title: Text(
                    "Daily",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontStyle: FontStyle.italic),
                  ),
                  backgroundColor: Colors.grey[200],
                  children: <Widget>[Container(child: _buildListViewDaily())])
            ]),
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 2.0, color: Colors.grey)),
            ),
            child: Column(children: <Widget>[
              ExpansionTile(
                  title: Text(
                    "Weekly",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontStyle: FontStyle.italic),
                  ),
                  backgroundColor: Colors.grey[200],
                  children: <Widget>[Container(child: _buildListViewWeekly())])
            ]),
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 2.0, color: Colors.grey)),
            ),
            child: Column(children: <Widget>[
              ExpansionTile(
                  title: Text(
                    "Monthly",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontStyle: FontStyle.italic),
                  ),
                  backgroundColor: Colors.grey[200],
                  children: <Widget>[Container(child: _buildListViewMonthly())])
            ]),
          ),
        ])));
  }
}
