import 'package:flutter/material.dart';

var plus = 0;

var saldo = 0;

String ket = "";

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class History {
  History(this._nom, this._ket, this._sym);

  int _nom;
  String _sym;
  String _ket;
}

class _MainPageState extends State<MainPage> {
  List<History> _history = [];

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
                  Navigator.of(context).pop();
                  setState(() {
                    if(plus != null && ket != null) {
                      saldo = saldo - plus;
                      _history.add(History(plus, ket, "-"));
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
                  Navigator.of(context).pop();
                  setState(() {
                    if(plus != null && ket != null) {
                      saldo = saldo + plus;
                      _history.add(History(plus, ket, "+"));
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
                    child: Text(
                      "+",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
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
                    child: Text(
                      "-",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    color: Colors.red[900],
                  ),
                ))
          ],
        ),
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            "Transaksi terakhir",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
          color: Colors.black,
        ),
        Flexible(
            flex: 1,
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                //   reverse: true,
                itemCount: _history.length < 10 ? _history.length : 10,
                itemBuilder: (context, index) {
                  int newIndex = _history.length - 1 - index;
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
                                color: _history[newIndex]._sym == "+"
                                    ? Colors.teal[700]
                                    : Colors.red[700],
                              ),
                              child: Icon(
                                _history[newIndex]._sym == "+"
                                    ? Icons.add
                                    : Icons.remove,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              "   ${_history[newIndex]._nom}",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                          Expanded(
                              flex: 5,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  " | ${_history[newIndex]._ket}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ))
                        ],
                      ));
                }))
      ]),
    );
  }
}
