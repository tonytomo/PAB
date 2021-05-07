import 'package:flutter/material.dart';
import 'package:pab_dompet/classes/history.dart';
import 'package:hive/hive.dart';

class inputPendapatan extends StatefulWidget {
  @override
  _inputPendapatanState createState() => _inputPendapatanState();
  int plus;
  String ket;
  String sym;
  inputPendapatan(this.plus,this.ket,this.sym);

}

class _inputPendapatanState extends State<inputPendapatan> {
  @override
  void initState() {
    super.initState();
  if(widget.sym=="+")
    status="Pemasukan";
  else if(widget.sym=="-")
    status="Pengeluaran";
  }

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
    addHistory(newHistory);
    Navigator.pop(context);

    //sesuatu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Masukan Jumlah $status"),
      ),
      body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 50),
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
                      return 'Pengeluaran tidak boleh kosong!';
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
                    padding: EdgeInsets.symmetric(
                    ),
                    child: Text(
                      "Simpan",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                    onPressed: () {
                      _submit();
                      setState(() {

                      });
                    }
                )
              ],
            ),
          )),
    );
  }
}
