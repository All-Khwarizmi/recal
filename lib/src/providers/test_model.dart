import 'package:hive/hive.dart';

part 'test_model.g.dart';

@HiveType(typeId: 0)
class Memo extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late DateTime lastRecall = DateTime.now();
  @HiveField(2)
  late DateTime nextRecall = lastRecall.add(const Duration(days: 2));
}
