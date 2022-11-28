import 'package:backend_flutter/scrn/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NameScreen extends StatelessWidget {
  NameScreen({Key? key}) : super(key: key);

  TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('input'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: inputController,
            ),
            ElevatedButton(
              onPressed: () async {
                var name = inputController.text;

                // await http
                //     .get(
                //         Uri.parse('http://192.168.0.163:4000/api/employee/new'))
                //     .then((value) => Navigator.of(context).push(
                //           MaterialPageRoute(
                //             builder: ((context) => HomePage(
                //                   userId: name,
                //                 )),
                //           ),
                //         ));
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: ((context) => HomePage(
                //           userId: name,
                //         )),
                //   ),
                // );
              },
              child: const Text('next'),
            ),
          ],
        ),
      ),
    );
  }
}
