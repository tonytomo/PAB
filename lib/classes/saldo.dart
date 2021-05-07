import 'package:hive/hive.dart';

part 'saldo.g.dart';

@HiveType(typeId: 1)
class Saldo {
  @HiveField(0)
  int nom;

  Saldo(this.nom);
}