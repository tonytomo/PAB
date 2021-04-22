import 'package:flutter/material.dart';
import 'home_page.dart';

class Debt extends StatefulWidget {
  @override
  _DebtState createState() => _DebtState();
}

class Debts {
  Debts(this._nama, this._nominal, this._jenis);

  String _nama;
  int _nominal;
  String _jenis;
}

class _DebtState extends State<Debt> {
  List<Debts> _debt = [];

  inputPiutangSaya(BuildContext context) {
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
                    labelText: 'Nama',
                  ),
                  onChanged: (String value2) {
                    ket = value2;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Pemasukan',
                  ),
                  onChanged: (String value) {
                    plus = int.parse(value);
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
                  _debt.add(Debts(ket, plus, "+"));
                  });
                },
              )
            ],
          );
        });
  }

  inputHutangSaya(BuildContext context) {
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
                    labelText: 'Nama',
                  ),
                  onChanged: (String value2) {
                    ket = value2;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Pemasukan',
                  ),
                  onChanged: (String value) {
                    plus = int.parse(value);
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
                    _debt.add(Debts(ket, plus, "-"));
                  });
                },
              )
            ],
          );
        });
  }

  _deleteDebts(index){
    _debt.removeAt(index);
    setState(() {

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
                    inputPiutangSaya(context);
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
                    inputHutangSaya(context);
                  },
                  child: Text("-"),
                  color: Colors.red,
                ),
              )),
        ],
      ),
      Flexible(
        flex: 1,
        child: Container(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              //   reverse: true,
              itemCount: _debt.length,
              itemBuilder: (context, index) {
                int newIndex = _debt.length - 1 - index;
                String period="Weekly";
                return GestureDetector(
//              onLongPress: () => _edit(period,context, newIndex),
                onHorizontalDragEnd: (test) => _deleteDebts(newIndex),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.black12,
                      padding: EdgeInsets.all(8),
                      height: 50,
                      margin: EdgeInsets.all(2),
                      child: Text(
                        "${_debt[newIndex]._jenis} ${_debt[newIndex]._nominal} ${_debt[newIndex]._nama}",
                        style: TextStyle(
                            fontSize: 20,
                            color: _debt[newIndex]._jenis == "+"
                                ? Colors.green
                                : Colors.red),
                      )),
                );
              }),
        ),
      )
    ]));
  }
}
