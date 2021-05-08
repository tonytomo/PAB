import 'package:flutter/material.dart';

class Graph extends StatefulWidget {
  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leading: Icon(Icons.insert_chart_outlined_rounded),
          title: Text("Graph"),
          backgroundColor: Colors.teal[700]),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 2.0, color: Colors.grey)),
              ),
              child: ExpansionTile(
                title: Text(
                  "Income bulan ini",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                children: <Widget>[
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey,
                      height: 0,
                    ),
                    itemCount: 0,
                    // itemCount: _history.length < 10 ? _history.length : 10,
                    itemBuilder: (context, index) {
                      // int newIndex = _history.length - 1 - index;
                      return ListTile(
                        title: Text("income"),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 2.0, color: Colors.grey)),
              ),
              child: ExpansionTile(
                title: Text(
                  "Outcome bulan ini",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                children: <Widget>[
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey,
                      height: 0,
                    ),
                    itemCount: 0,
                    // itemCount: _history.length < 10 ? _history.length : 10,
                    itemBuilder: (context, index) {
                      // int newIndex = _history.length - 1 - index;
                      return ListTile(
                        title: Text("outcome"),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 2.0, color: Colors.grey)),
              ),
              padding: EdgeInsets.all(15),
              child: Text(
                "Total = ",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 2.0, color: Colors.grey)),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Prediksi Pendapatan per Tahun",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 2.0, color: Colors.grey)),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Pemasukan",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 2.0, color: Colors.grey)),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Pengeluaran",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 2.0, color: Colors.grey)),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Total = ",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
