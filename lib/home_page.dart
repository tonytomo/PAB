import 'package:flutter/material.dart';

var plus=0;

var saldo=0;

String ket="";

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
                child: Text("Simpan"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    saldo = saldo - plus;
                    _history.add(History(plus, ket, "-"));
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
                  setState(() {
                    saldo = saldo + plus;
                    _history.add(History(plus, ket, "+"));
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
                      inputOutcome(context);
                    },
                    child: Text("-"),
                    color: Colors.red,
                  ),
                ))
          ],
        ),
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text("Transaksi terakhir",
              style: TextStyle(fontSize: 20, color: Colors.white)),
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
                      child: Text(
                        "${_history[newIndex]._sym} ${_history[newIndex]._nom} ${_history[newIndex]._ket}",
                        style: TextStyle(
                            fontSize: 20,
                            color: _history[newIndex]._sym == "+"
                                ? Colors.green
                                : Colors.red),
                      ));
                }))
      ]),
    );
  }
}
