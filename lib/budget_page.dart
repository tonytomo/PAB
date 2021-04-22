import 'package:flutter/material.dart';
import 'package:pab_dompet/home_page.dart';

class Budget extends StatefulWidget {
  @override
  _BudgetState createState() => _BudgetState();
}

class Cash {
  Cash(this._nomBudget, this._ketBudget, this._symBudget);

  int _nomBudget;
  String _ketBudget;
  String _symBudget;
}

class _BudgetState extends State<Budget> {
  List<Cash> _budgetDaily = [];
  List<Cash> _budgetWeekly = [];
  List<Cash> _budgetMonthly = [];
  String _valueChoose;
  List _periode = ["Daily", "Weekly", "Monthly"];

  _edit(String period, BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Masukan Jumlah Pemasukan"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Pemasukan',
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
            actions: <Widget>[
              MaterialButton(
                child: Text("Simpan"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {});
                  if (period == "Daily"){
                    _budgetDaily[index]._nomBudget=plus;
                    _budgetDaily[index]._ketBudget=ket;}
                  //  budgetDaily.add(Cash(plus, ket, "+"));
                  else if (period == "Weekly")
                  {
                    _budgetWeekly[index]._nomBudget=plus;
                    _budgetWeekly[index]._ketBudget=ket;}
                  else if (period == "Monthly")
                  {
                    _budgetMonthly[index]._nomBudget=plus;
                    _budgetMonthly[index]._ketBudget=ket;}
                },
              )
            ],
          );
        });
  }

  _deleteDaily(int index) {
    _budgetDaily.removeAt(index);
    setState(() {});
  }


  _deleteWeekly(int index) {
    _budgetWeekly.removeAt(index);
    setState(() {});
  }


  _deleteMonthly(int index) {
    _budgetMonthly.removeAt(index);
    setState(() {});
  }

  inputIncomePeriodly(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Masukan Jumlah Pemasukan"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Pemasukan',
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
                DropdownButtonFormField(
                  hint: Text("Periode"),
                  value: _valueChoose,
                  onChanged: (newValue) {
                    setState(() {
                      _valueChoose = newValue;
                    });
                  },
                  items: _periode.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                )
              ],
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text("Simpan"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    if (_valueChoose == "Daily")
                      _budgetDaily.add(Cash(plus, ket, "+"));
                    else if (_valueChoose == "Weekly")
                      _budgetWeekly.add(Cash(plus, ket, "+"));
                    else if (_valueChoose == "Monthly")
                      _budgetMonthly.add(Cash(plus, ket, "+"));
                  });
                },
              )
            ],
          );
        });
  }

  inputOutcomePeriodly(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Masukan Jumlah Pemasukan"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Pemasukan',
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
                DropdownButtonFormField(
                  hint: Text("Periode"),
                  value: _valueChoose,
                  onChanged: (newValue) {
                    setState(() {
                      _valueChoose = newValue;
                    });
                  },
                  items: _periode.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                )
              ],
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text("Simpan"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    if (_valueChoose == "Daily")
                      _budgetDaily.add(Cash(plus, ket, "-"));
                    else if (_valueChoose == "Weekly")
                      _budgetWeekly.add(Cash(plus, ket, "-"));
                    else if (_valueChoose == "Monthly")
                      _budgetMonthly.add(Cash(plus, ket, "-"));
                  });
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Row(
        children: <Widget>[
          Flexible(
              flex: 2,
              child: ButtonTheme(
                minWidth: double.infinity,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    inputIncomePeriodly(context);
                    print(_budgetDaily[0]._nomBudget);
                  },
                  child: Text("+"),
                  color: Colors.green,
                ),
              )),
          Flexible(
              flex: 2,
              child: ButtonTheme(
                minWidth: double.infinity,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    inputOutcomePeriodly(context);
                  },
                  child: Text("-"),
                  color: Colors.red,
                ),
              )),
        ],
      ),
      Container(
          height: 50,
          color: Colors.grey,
          alignment: Alignment.center,
          child: Text("Per Hari", style: TextStyle(fontSize: 20))),
      Flexible(
        flex: 1,
        child: Container(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                //   reverse: true,
                itemCount: _budgetDaily.length,
                itemBuilder: (context, index) {
                  int newIndex = _budgetDaily.length - 1 - index;
                  String period = "Daily";
                  return GestureDetector(
                    onLongPress: () => _edit(period,context, newIndex),
                    onHorizontalDragEnd: (test) => _deleteDaily(newIndex),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.black12,
                        padding: EdgeInsets.all(8),
                        height: 50,
                        margin: EdgeInsets.all(2),
                        child: Text(
                          "${_budgetDaily[newIndex]._symBudget} ${_budgetDaily[newIndex]._nomBudget} ${_budgetDaily[newIndex]._ketBudget}",
                          style: TextStyle(
                              fontSize: 20,
                              color: _budgetDaily[newIndex]._symBudget == "+"
                                  ? Colors.green
                                  : Colors.red),
                        )),
                  );
                })),
      ),
      Container(
          height: 50,
          color: Colors.grey,
          alignment: Alignment.center,
          child: Text("Per Minggu", style: TextStyle(fontSize: 20))),
      Flexible(
        flex: 1,
        child: Container(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                //   reverse: true,
                itemCount: _budgetWeekly.length,
                itemBuilder: (context, index) {
                  int newIndex = _budgetWeekly.length - 1 - index;
                  String period="Weekly";
                  return GestureDetector(
                    onLongPress: () => _edit(period,context, newIndex),
                    onHorizontalDragEnd: (test) => _deleteWeekly(newIndex),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.black12,
                        padding: EdgeInsets.all(8),
                        height: 50,
                        margin: EdgeInsets.all(2),
                        child: Text(
                          "${_budgetWeekly[newIndex]._symBudget} ${_budgetWeekly[newIndex]._nomBudget} ${_budgetWeekly[newIndex]._ketBudget}",
                          style: TextStyle(
                              fontSize: 20,
                              color: _budgetWeekly[newIndex]._symBudget == "+"
                                  ? Colors.green
                                  : Colors.red),
                        )),
                  );
                })),
      ),
      Container(
          height: 50,
          color: Colors.grey,
          alignment: Alignment.center,
          child: Text("Per Bulan", style: TextStyle(fontSize: 20))),
      Flexible(
        child: Container(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                //   reverse: true,
                itemCount: _budgetMonthly.length,
                itemBuilder: (context, index) {
                  int newIndex = _budgetMonthly.length - 1 - index;
                  String period = "Monthly";
                  return GestureDetector(
                    onLongPress: () => _edit(period,context, newIndex),
                    onHorizontalDragEnd: (test) => _deleteMonthly(newIndex),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.black12,
                        padding: EdgeInsets.all(8),
                        height: 50,
                        margin: EdgeInsets.all(2),
                        child: Text(
                          "${_budgetMonthly[newIndex]._symBudget} ${_budgetMonthly[newIndex]._nomBudget} ${_budgetMonthly[newIndex]._ketBudget}",
                          style: TextStyle(
                              fontSize: 20,
                              color: _budgetMonthly[newIndex]._symBudget == "+"
                                  ? Colors.green
                                  : Colors.red),
                        )),
                  );
                })),
      ),
    ]));
  }
}
