import 'package:hive/hive.dart';
part 'Account.g.dart';

@HiveType(typeId: 0)
class Account {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String work;

  @HiveField(2)
  late String dob;

  Account({required this.name, required this.work, required this.dob});
}
