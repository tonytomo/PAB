import 'package:flutter/material.dart';
import 'package:pab_dompet/classes/budget.dart';
import 'package:pab_dompet/classes/saldo.dart';
import 'package:hive/hive.dart';
import 'package:cron/cron.dart';

import 'classes/budget.dart';
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
  final budgetDailyBox = Hive.box('budgetdaily');
  final budgetWeeklyBox = Hive.box('budgetweekly');
  final budgetMonthlyBox = Hive.box('budgetmonthly');
  String status;
  String _valueChoose;
  List _periode = ["Daily", "Weekly", "Monthly"];

  void addBudgetDaily(BudgetList budget) {
    budgetDailyBox.add(budget);
  }

  void addBudgetWeekly(BudgetList budget) {
    budgetWeeklyBox.add(budget);
  }

  void addBudgetMonthly(BudgetList budget) {
    budgetMonthlyBox.add(budget);
  }

  void addTransactionDaily() {
    // Pengurangan saldo dan penambahan transaksi di homepage
  }

  void addTransactionWeekly() {
    // Pengurangan saldo dan penambahan transaksi di homepage
  }

  void addTransactionMonthly() {
    // Pengurangan saldo dan penambahan transaksi di homepage
  }

  void scheduleDaily() {
    final cron = Cron();
    cron.schedule(new Schedule.parse('0 0 * * *'), () async {
      // Daily
      addTransactionDaily();
    });
  }

  void scheduleWeekly() {
    final cron = Cron();
    cron.schedule(new Schedule.parse('0 0 0 0 *'), () async {
      // Weekly
      addTransactionWeekly();
    });
  }

  void scheduleMonthly() {
    final cron = Cron();
    cron.schedule(new Schedule.parse('0 0 0 * 0'), () async {
      // Monthly
      addTransactionMonthly();
    });
  }

  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    final newBudget = BudgetList(widget.sym, nom, ket, crDate, _valueChoose);
    if (newBudget.period == "Daily") {
      addBudgetDaily(newBudget);
      scheduleDaily();
    } else if (newBudget.period == "Weekly") {
      addBudgetWeekly(newBudget);
      scheduleWeekly();
    } else if (newBudget.period == "Monthly") {
      addBudgetMonthly(newBudget);
      scheduleMonthly();
    }

    nom = null;
    ket = null;
    crDate = null;
    _valueChoose = null;

    Navigator.pop(context);
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
                  validator: (value) =>
                      value == null ? 'Periode tidak boleh kosong' : null,
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
                      crDate = DateTime.now();
                      _submit();
                      setState(() {});
                    })
              ],
            ),
          )),
    );
  }
}
