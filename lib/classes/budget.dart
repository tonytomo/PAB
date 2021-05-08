import 'package:hive/hive.dart';

part 'budget.g.dart';

@HiveType(typeId: 2)
class BudgetList {
  @HiveField(0)
  final String sym;
  @HiveField(1)
  int nom;
  @HiveField(2)
  String ket;
  @HiveField(3)
  DateTime crDate;

  BudgetList(this.sym, this.nom, this.ket, this.crDate);
}