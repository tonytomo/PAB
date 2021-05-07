import 'package:hive/hive.dart';

part 'history.g.dart';

@HiveType(typeId: 0)
class History {
  @HiveField(0)
  final String sym;
  @HiveField(1)
  final int nominal;
  @HiveField(2)
  final String ket;

  History(this.sym, this.nominal, this.ket);
}