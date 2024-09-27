import 'package:flutter/material.dart';
import 'classes/history.dart';
import 'classes/saldo.dart';
import 'package:hive/hive.dart';

class inputPendapatan extends StatefulWidget {
  @override
  _inputPendapatanState createState() => _inputPendapatanState();
  int plus;
  String ket;
  String sym;

  inputPendapatan(this.plus, this.ket, this.sym);
}

class _inputPendapatanState extends State<inputPendapatan> {
  @override
  void initState() {
    super.initState();
    if (widget.sym == "+")
      status = "Pemasukan";
    else if (widget.sym == "-") status = "Pengeluaran";
  }

  void currentSaldo(Saldo saldo) {
    saldoBox.putAt(0, saldo);
  }

  final saldoBox = Hive.box('saldo');
  var _formKey = GlobalKey<FormState>();
  final historyBox = Hive.box('history');
  String status;

  void addHistory(History history) {
    historyBox.add(history);
  }

  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    final newHistory = History(widget.sym, widget.plus, widget.ket);
    var saldo = saldoBox.get(0) as Saldo;
    var newSaldo = Saldo(saldo.nom);
    if (status == "Pemasukan")
      newSaldo = Saldo(saldo.nom + widget.plus);
    else if (status == "Pengeluaran") newSaldo = Saldo(saldo.nom - widget.plus);
    addHistory(newHistory);
    Navigator.pop(context);

    currentSaldo(newSaldo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          alignment: Alignment.centerLeft,
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Input $status"),
        backgroundColor: Colors.teal[700],
      ),
      body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: '$status',
                  ),
                  onSaved: (String value) {
                    widget.plus = int.parse(value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return '$status tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Keterangan',
                  ),
                  onChanged: (String value2) {
                    widget.ket = value2;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Keterangan tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                RaisedButton(
                    padding: EdgeInsets.symmetric(),
                    color: Colors.teal[700],
                    child: Text(
                      "Simpan",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      _submit();
                      setState(() {});
                    })
              ],
            ),
          )),
    );
  }
}
