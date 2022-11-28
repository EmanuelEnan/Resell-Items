import 'package:hive/hive.dart';
part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  String? content;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? image;
  @HiveField(3)
  String? price;

  Transaction({this.content, this.price, this.image, this.title});
}
