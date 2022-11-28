import 'package:hive_flutter/hive_flutter.dart';
part 'order.g.dart';

@HiveType(typeId: 1)
class Order extends HiveObject {
  @HiveField(0)
  String? phnNo;

  Order({this.phnNo});
}
