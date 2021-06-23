import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'classes/history.dart';
import 'classes/saldo.dart';
import 'package:Dompet.in/classes/history.dart';
import 'package:Dompet.in/inputPendapatan.dart';
import 'customExtensions/string_operation.dart';

var plus = 0;
String ket = "";

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    plus = null;
    ket = null;
  }

  final historyBox = Hive.box('history');
  final saldoBox = Hive.box('saldo');

  void currentSaldo(Saldo saldo) {
    saldoBox.putAt(0, saldo);
  }

  void deleteHistory() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: <Widget>[
                Text(
                  "Anda yakin ingin menghapus?",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "!Riwayat dan catatan income/outcome akan terhapus!",
                  style: TextStyle(color: Colors.red, fontSize: 14),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  MaterialButton(
                    child: Text(
                      "Tidak",
                      style: TextStyle(color: Colors.teal[700], fontSize: 17),
                    ),
                    padding: EdgeInsets.all(15),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    child: Text(
                      "Iya",
                      style: TextStyle(color: Colors.red[700], fontSize: 17),
                    ),
                    padding: EdgeInsets.all(15),
                    onPressed: () {
                      historyBox.deleteAll(historyBox.keys);
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

  @override
  Widget build(BuildContext context) {
    var saldo = saldoBox.get(0) as Saldo;
    return Scaffold(
      appBar: AppBar(
          leading: Icon(Icons.account_balance_wallet_rounded),
          title: Text("Dompet.in"),
          backgroundColor: Colors.teal[700]),
      body: Stack(children: [
        Column(children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15),
              height: 100,
              width: double.infinity,
              color: Colors.black12,
              child: _showBalance()),
          Container(
            height: 50,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                  ),
                ),
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
                      icon: Icon(Icons.auto_delete),
                      color: Colors.white,
                      onPressed: () {
                        deleteHistory();
                      }),
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
        Positioned(
            bottom: 80,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.teal[700].withOpacity(0.8),
                  onSurface: Colors.grey,
                  shape: CircleBorder(),
                  minimumSize: Size(50, 50)),
              child: Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => inputPendapatan(plus, ket, "+")));
              },
            )),
        Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.red.withOpacity(0.8),
                  onSurface: Colors.grey,
                  shape: CircleBorder(),
                  minimumSize: Size(50, 50)),
              child: Icon(
                Icons.remove,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => inputPendapatan(plus, ket, "-")),
                );
              },
            ))
      ]),
    );
  }

  Widget _showBalance() {
    return WatchBoxBuilder(
        box: Hive.box('saldo'),
        builder: (context, saldoBox) {
          var balance = saldoBox.getAt(0) as Saldo;
          return Text(
            "Rp ${balance.nom} ,-",
            style: TextStyle(fontSize: 30),
          );
        });
  }

  Widget _buildListView() {
    return WatchBoxBuilder(
        box: Hive.box('history'),
        builder: (context, historyBox) {
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: historyBox.length < 10 ? historyBox.length : 10,
              itemBuilder: (context, index) {
                index = historyBox.length - index - 1;
                final history = historyBox.getAt(index) as History;
                return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black12,
                    ),
                    alignment: Alignment.centerLeft,

                    padding: EdgeInsets.all(10),
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
