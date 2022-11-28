import 'package:backend_flutter/scrn/select_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'models/order.dart';
import 'models/transaction.dart';

const String bagName = 'bag';

const String orderName = 'order';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appDocDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);

  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(OrderAdapter());
  await Hive.openBox<Transaction>(bagName);
  await Hive.openBox<Order>(orderName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(scheme: FlexScheme.bigStone),
      // The Mandy red, dark theme.
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.bigStone),
      // Use dark or light theme based on system setting.
      themeMode: ThemeMode.system,
      title: 'Resell Items',
      home: const SelectScreen(),
    );
  }
}
