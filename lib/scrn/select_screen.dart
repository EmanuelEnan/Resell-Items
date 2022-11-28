import 'package:backend_flutter/scrn/bag_screen.dart';
import 'package:backend_flutter/scrn/home_page.dart';
import 'package:flutter/material.dart';

import 'input_screen.dart';
import 'name_screen.dart';

class SelectScreen extends StatelessWidget {
  const SelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('select'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const InputScreen()),
                  ),
                );
              },
              child: const Text('post screen'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: ((context) => const EmployeePage()),
            //       ),
            //     );
            //   },
            //   child: const Text('employee screen'),
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const HomePage()),
                  ),
                );
              },
              child: const Text('get screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const SaveFolder()),
                  ),
                );
              },
              child: const Text('cart bag'),
            ),
          ],
        ),
      ),
    );
  }
}
