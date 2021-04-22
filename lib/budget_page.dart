import 'package:flutter/material.dart';
import 'package:pab_dompet/home_page.dart';

class Budget extends StatefulWidget {
  @override
  _BudgetState createState() => _BudgetState();
}

class Cash {
  Cash(this.nomBudget, this.ketBudget, this.symBudget);

  int nomBudget;
  String ketBudget;
  String symBudget;
}

class _BudgetState extends State<Budget> {
  List<Cash> budgetDaily = [];
  List<Cash> budgetWeekly = [];
  List<Cash> budgetMonthly = [];
  String valueChoose;
  List periode = ["Daily", "Weekly", "Monthly"];

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
                    budgetDaily[index].nomBudget=plus;
                    budgetDaily[index].ketBudget=ket;}
                  //  budgetDaily.add(Cash(plus, ket, "+"));
                  else if (period == "Weekly")
                  {
                    budgetWeekly[index].nomBudget=plus;
                    budgetWeekly[index].ketBudget=ket;}
                  else if (period == "Monthly")
                  {
                    budgetMonthly[index].nomBudget=plus;
                    budgetMonthly[index].ketBudget=ket;}
                },
              )
            ],
          );
        });
  }

  _deleteDaily(int index) {
    budgetDaily.removeAt(index);
    setState(() {});
  }


  _deleteWeekly(int index) {
    budgetWeekly.removeAt(index);
    setState(() {});
  }


  _deleteMonthly(int index) {
    budgetMonthly.removeAt(index);
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
                  value: valueChoose,
                  onChanged: (newValue) {
                    setState(() {
                      valueChoose = newValue;
                    });
                  },
                  items: periode.map((valueItem) {
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
                    if (valueChoose == "Daily")
                      budgetDaily.add(Cash(plus, ket, "+"));
                    else if (valueChoose == "Weekly")
                      budgetWeekly.add(Cash(plus, ket, "+"));
                    else if (valueChoose == "Monthly")
                      budgetMonthly.add(Cash(plus, ket, "+"));
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
                  value: valueChoose,
                  onChanged: (newValue) {
                    setState(() {
                      valueChoose = newValue;
                    });
                  },
                  items: periode.map((valueItem) {
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
                    if (valueChoose == "Daily")
                      budgetDaily.add(Cash(plus, ket, "-"));
                    else if (valueChoose == "Weekly")
                      budgetWeekly.add(Cash(plus, ket, "-"));
                    else if (valueChoose == "Monthly")
                      budgetMonthly.add(Cash(plus, ket, "-"));
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
                    print(budgetDaily[0].nomBudget);
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
                itemCount: budgetDaily.length,
                itemBuilder: (context, index) {
                  int newIndex = budgetDaily.length - 1 - index;
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
                          "${budgetDaily[newIndex].symBudget} ${budgetDaily[newIndex].nomBudget} ${budgetDaily[newIndex].ketBudget}",
                          style: TextStyle(
                              fontSize: 20,
                              color: budgetDaily[newIndex].symBudget == "+"
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
                itemCount: budgetWeekly.length,
                itemBuilder: (context, index) {
                  int newIndex = budgetWeekly.length - 1 - index;
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
                          "${budgetWeekly[newIndex].symBudget} ${budgetWeekly[newIndex].nomBudget} ${budgetWeekly[newIndex].ketBudget}",
                          style: TextStyle(
                              fontSize: 20,
                              color: budgetWeekly[newIndex].symBudget == "+"
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
                itemCount: budgetMonthly.length,
                itemBuilder: (context, index) {
                  int newIndex = budgetMonthly.length - 1 - index;
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
                          "${budgetMonthly[newIndex].symBudget} ${budgetMonthly[newIndex].nomBudget} ${budgetMonthly[newIndex].ketBudget}",
                          style: TextStyle(
                              fontSize: 20,
                              color: budgetMonthly[newIndex].symBudget == "+"
                                  ? Colors.green
                                  : Colors.red),
                        )),
                  );
                })),
      ),
    ]));
  }
}
