import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'classes/debt.dart';
import 'customExtensions/ExpansionTile_alt.dart';
import 'home_page.dart';

class Debt extends StatefulWidget {
  @override
  _DebtState createState() => _DebtState();
}

final debtBox = Hive.box('debtlist');

class Debts {
  Debts(this._nama, this._nominal, this._jenis);

  String _nama;
  int _nominal;
  String _jenis;
}

class _DebtState extends State<Debt> {

  inputPiutangSaya(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Masukan Jumlah Piutang"),
            content: Column(
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
                    labelText: 'Nama',
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
                    final newDebt = DebtList(plus, "+", ket);
                    if (plus != null && ket != null) {
                      debtBox.add(newDebt);
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

  inputHutangSaya(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Masukan Jumlah Hutang"),
            content: Column(
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
                    labelText: 'Nama',
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
                    final newDebt = DebtList(plus, "-", ket);
                    if (plus != null && ket != null) {
                      debtBox.add(newDebt);
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

  _deleteDebts(index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Anda yakin sudah?"),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  MaterialButton(
                    child: Text(
                      "Belum",
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
                      debtBox.deleteAt(index);
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
    return Scaffold(
        appBar: AppBar(
            leading: Icon(Icons.monetization_on_outlined),
            title: Text("Debt"),
            backgroundColor: Colors.teal[700]),
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
                      child: Text(
                        "Piutang",
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
                        inputHutangSaya(context);
                      },
                      child: Text(
                        "Hutang",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.red[900],
                    ),
                  )),
            ],
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.grey,
                        height: 0,
                      ),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(bottom: 8),
                  itemCount: debtBox.length,
                  itemBuilder: (context, index) {
                    int newIndex = debtBox.length - 1 - index;
                    final debt = debtBox.getAt(newIndex) as DebtList;
                    return Column(
                      children: <Widget>[
                        MyExpansionTile(
                          title: Container(
                            alignment: Alignment.centerLeft,
                            color: Colors.black12,
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
                                        debt.sym == "+"
                                            ? Icons.attach_money
                                            : Icons.money_off,
                                        color: debt.sym == "+"
                                            ? Colors.teal[700]
                                            : Colors.red[700],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      "${debt.nom}",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text("|", style: TextStyle(fontSize: 20,color: Colors.grey),),
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "${debt.name}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ))
                                ]),
                          ),
                          backgroundColor: Colors.white70,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: double.infinity,
                                    )),
                                Expanded(
                                    flex: 18,
                                    child: ButtonTheme(
                                      minWidth: double.infinity,
                                      height: 50,
                                      child: RaisedButton(
                                        onPressed: () {
                                          _deleteDebts(newIndex);
                                        },
                                        child: Text(
                                          debt.sym == "+"
                                              ? "Sudah dibayar"
                                              : "Sudah membayar",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                        color: Colors.grey[700],
                                      ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: double.infinity,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
            ),
          )
        ]));
  }
}
