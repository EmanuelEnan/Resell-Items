import 'package:backend_flutter/main.dart';
import 'package:backend_flutter/models/order.dart';
import 'package:backend_flutter/scrn/my_verify.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PlaceOrder extends StatelessWidget {
  PlaceOrder({Key? key}) : super(key: key);

  TextEditingController noController = TextEditingController();

  var countryCode = '+88';

  Box<Order> myOrder = Hive.box<Order>(orderName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('place order'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: noController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                myOrder.put(
                  'cred',
                  Order(phnNo: countryCode + noController.text),
                );
                noController.text.isNotEmpty
                    ? await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: countryCode + noController.text,
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          MyVerify.verify = verificationId;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: ((context) => const MyVerify()),
                            ),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      )
                    : '';
              },
              child: const Text('send the code'),
            ),
          ],
        ),
      ),
    );
  }
}
