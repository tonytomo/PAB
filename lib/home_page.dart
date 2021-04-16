import 'package:flutter/material.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {
  var plus = 0;
  var saldo = 0;
  String ket = "";

  List<int> nom = [];
  List<String> sym =[];
  List<String> tag =[];


  createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();
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
                    nom.add(plus);
                    tag.add(ket);
                    sym.add("-");


                  });
                },
              )
            ],
          );
        });
  }

  createAlertDialog2(BuildContext context) {
    TextEditingController customController = TextEditingController();
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
                    nom.add(plus);
                    tag.add("( $ket )");
                    sym.add("+");
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
        Flexible(
          flex: 3,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 15),
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: Text(
              "Rp " + saldo.toString() + ",-",
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
        Flexible(
            flex: 2,
            child: Row(
              children: <Widget>[
                Flexible(
                    flex: 2,
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          createAlertDialog2(context);
                        },
                        child: Text("+"),
                        color: Colors.green,
                      ),
                    )),
                Flexible(
                    flex: 2,
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          createAlertDialog(context);
                        },
                        child: Text("-"),
                        color: Colors.red,
                      ),
                    ))
              ],
            )),
        Flexible(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            child: Text("Transaksi terakhir",
                style: TextStyle(fontSize: 20, color: Colors.white)),
            color: Colors.black,
          ),
        ),
        Flexible(
            flex: 18,
            child: ListView.builder(

                padding: const EdgeInsets.all(8),
                //   reverse: true,
                itemCount: nom.length < 10 ? nom.length : 10,
                itemBuilder: (context, index) {
                  int newIndex=nom.length-1-index;
                  return Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.black12,
                      padding: EdgeInsets.all(8),
                      height: 50,
                      margin: EdgeInsets.all(2),
                      child: Text("${sym[newIndex]} ${nom[newIndex]} ${tag[newIndex]}",style: TextStyle(fontSize: 20 ,color: sym[newIndex] == "+" ? Colors.green : Colors.red), ));
                }))
      ]),
    );
  }
}



