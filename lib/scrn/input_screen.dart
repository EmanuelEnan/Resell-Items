import 'dart:io';

import 'package:backend_flutter/scrn/home_page.dart';
import 'package:backend_flutter/api_service.dart/input_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController countryController = TextEditingController();

  TextEditingController idController = TextEditingController();

  TextEditingController typeController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  InputService inputService = InputService();

  File imageFile = File('');

  var uuid = const Uuid();

  // Image? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => imageFile = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // SizedBox(
            //   child: TextField(
            //     controller: idController,
            //     decoration: const InputDecoration(
            //       hintText: 'id (required)',
            //     ),
            //   ),
            // ),
            SizedBox(
              child: TextField(
                style: const TextStyle(fontSize: 22),
                controller: countryController,
                decoration: const InputDecoration(
                  hintText: 'title',
                  border: InputBorder.none,
                ),
              ),
            ),
            TextField(
              controller: typeController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'content',
                border: InputBorder.none,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .55,
            ),

            TextField(
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 22),
              controller: priceController,
              decoration: const InputDecoration(
                hintText: 'price',
                border: InputBorder.none,
              ),
            ),
            ElevatedButton(
              onPressed: () => pickImage(),
              child: const Text('pick a image (optional)'),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                var image = imageFile.path;
                var title = countryController.text;
                var id = uuid.v4();
                var content = typeController.text;
                var price = priceController.text;
                countryController.text.isNotEmpty &&
                        typeController.text.isNotEmpty &&
                        priceController.text.isNotEmpty
                    ? inputService
                        .postApi(id, image, content, title, price)
                        .then(
                          (value) => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: ((context) => const HomePage()),
                            ),
                          ),
                        )
                    : ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.grey[850],
                          content: const Text(
                            'Complete all the options!',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
              },
              child: const Text('ADD'),
            ),
          ],
        ),
      ),
    );
  }
}
