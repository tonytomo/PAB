import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pab_dompet/classes/history.dart';
import 'customExtensions/string_operation.dart';

var plus = 0;
var saldo = 0;
String ket = "";

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final historyBox = Hive.box('history');

  void addHistory(History history) {
    historyBox.add(history);
  }

  void deleteHistory() {
    historyBox.deleteAll(historyBox.keys);
  }

  inputOutcome(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Masukan Jumlah Pengeluaran"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Pengeluaran',
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
                child: Text(
                  "Simpan",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                color: Colors.teal[700],
                onPressed: () {
                  final newHistory = History("-", plus, ket);
                  addHistory(newHistory);
                  Navigator.of(context).pop();
                  setState(() {
                    if (plus != null && ket != null) {
                      saldo = saldo - plus;
                    }
                    plus = null;
                    ket = null;
                  });
                },
              )
            ],
          );
        });
  }

  inputIncome(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Masukan Jumlah Pemasukan"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.number,
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
                child: Text(
                  "Simpan",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                color: Colors.teal[700],
                onPressed: () {
                  final newHistory = History("+", plus, ket);
                  addHistory(newHistory);
                  Navigator.of(context).pop();
                  setState(() {
                    if (plus != null && ket != null) {
                      saldo = saldo + plus;
                    }
                    plus = null;
                    ket = null;
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
      appBar: AppBar(
          leading: Icon(Icons.account_balance_wallet_rounded),
          title: Text("DompetAja"),
          backgroundColor: Colors.teal[700]),
      body: Column(children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 15),
          height: 100,
          width: double.infinity,
          color: Colors.black12,
          child: Text(
            "Rp " + saldo.toString() + ",-",
            style: TextStyle(fontSize: 30),
          ),
        ),
        Row(
          children: <Widget>[
            Flexible(
                flex: 2,
                child: ButtonTheme(
                  minWidth: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      inputIncome(context);
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
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
                      inputOutcome(context);
                    },
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    color: Colors.red[900],
                  ),
                ))
          ],
        ),
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Text(
                  "Transaksi terakhir",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                    alignment: Alignment.centerRight,
                    icon: Icon(Icons.auto_delete),color: Colors.white,
                    onPressed: () {
                      deleteHistory();
                    }
                ),
              ),
            ],
          ),
          color: Colors.black,
        ),
        Flexible(
          flex: 1,
          child: _buildListView(),
        )
      ]),
    );
  }

  Widget _buildListView() {
    return WatchBoxBuilder(
        box: Hive.box('history'),
        builder: (context, historyBox) {
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: historyBox.length < 10 ? historyBox.length : 10,
              itemBuilder: (context, index) {
                final history = historyBox.getAt(index) as History;
                return Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.black12,
                    padding: EdgeInsets.all(8),
                    height: 50,
                    margin: EdgeInsets.all(2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: history.sym == "+"
                                  ? Colors.teal[700]
                                  : Colors.red[700],
                            ),
                            child: Icon(
                              history.sym == "+" ? Icons.add : Icons.remove,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            "   ${history.nominal}",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "|",
                                style:
                                TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                            )),
                        Expanded(
                            flex: 3,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "${history.ket.capitalize()}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ))
                      ],
                    ));
              });
        });
  }
}
