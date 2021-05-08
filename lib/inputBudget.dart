import 'package:flutter/material.dart';
import 'package:pab_dompet/classes/budget.dart';
import 'package:pab_dompet/classes/saldo.dart';
import 'package:hive/hive.dart';

import 'classes/budget.dart';
import 'classes/budget.dart';

class inputBudget extends StatefulWidget {
  @override
  _inputBudgetState createState() => _inputBudgetState();
  final String sym;


  inputBudget(this.sym);
}

class _inputBudgetState extends State<inputBudget> {
  @override
  void initState() {
    super.initState();

    if (widget.sym == "+")
      status = "Pemasukan";
    else if (widget.sym == "-") status = "Pengeluaran";

  }

  int nom;
  String ket;
  DateTime crDate;
  String period;

  //final saldoBox = Hive.box('saldo');
  var _formKey = GlobalKey<FormState>();
  final budgetBox = Hive.box('budget');
  String status;
  String _valueChoose;
  List _periode = ["Daily", "Weekly", "Monthly"];

  void addBudget(BudgetList budget) {
    budgetBox.add(budget);
  }

  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    final newBudget = BudgetList(widget.sym, nom, ket, crDate, _valueChoose);;
    addBudget(newBudget);

    nom=null;
    ket=null;
    crDate=null;
    _valueChoose=null;


    Navigator.pop(context);

   // currentSaldo(newSaldo);
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
                    nom = int.parse(value);
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
                    ket = value2;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Keterangan tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField(
                  hint: Text("Periode"),
                  value: _valueChoose,
                  onChanged: (newValue) {
                    setState(() {
                      _valueChoose = newValue;
                    });
                  },
                  validator: (value) => value == null ? 'Periode tidak boleh kosong' : null,
                  items: _periode.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
                RaisedButton(
                    padding: EdgeInsets.symmetric(),
                    color: Colors.teal[700],
                    child: Text(
                      "Simpan",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      crDate= DateTime.now();
                      _submit();
                      setState(() {});
                    })
              ],
            ),
          )),
    );
  }
}
