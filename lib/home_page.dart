import 'package:flutter/material.dart';
var plus = 0;
var saldo = 0;
String ket = "";

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {


  List<int> nom = [];
  List<String> sym =[];
  List<String> tag =[];


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



