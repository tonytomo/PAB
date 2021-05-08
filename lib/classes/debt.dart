import 'package:hive/hive.dart';

part 'debt.g.dart';

@HiveType(typeId: 3)
class DebtList {
  @HiveField(0)
  final int nom;
  @HiveField(1)
  final String name;

  DebtList(this.nom, this.name);
}