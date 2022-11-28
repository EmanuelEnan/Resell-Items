import 'dart:io';

import 'package:backend_flutter/api_service.dart/delete_service.dart';
import 'package:backend_flutter/api_service.dart/employee_service.dart';
import 'package:backend_flutter/scrn/bag_screen.dart';
import 'package:backend_flutter/scrn/input_screen.dart';
import 'package:backend_flutter/models/model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import '../main.dart';
import '../models/transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  @override
  void initState() {
    apiService;
    super.initState();
  }

  // List<Color> color = [Colors.blue, Colors.amber, Colors.yellow];

  final rnd = math.Random();

  Color getRandomColor() => Color(rnd.nextInt(0xffffffff)).withOpacity(.6);

  Box<Transaction> myBox = Hive.box<Transaction>(bagName);

  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          elevation: 10,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => const InputScreen()),
              ),
            );
          }),
      appBar: AppBar(
        title: const Text('backend'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => const SaveFolder()),
                ),
              );
            },
            child: const Text('Bag'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Employees>>(
              future: apiService.getApi(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('add a task'));
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const Center(child: Text('no value'));
                } else if (snapshot.hasData) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                      // reverse: true,
                      // shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          margin: const EdgeInsets.all(6),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: getRandomColor(),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              // snapshot.data![index].image!.isNotEmpty
                              //     ? Image.file(
                              //         File(snapshot.data![index].image!),
                              //         width: 300,
                              //         height: 300,
                              //         fit: BoxFit.scaleDown,
                              //       )
                              //     : Container(),
                              Text(
                                DateFormat('yyyy-MM-dd KK:mm:ss a')
                                    .format(
                                      DateTime.parse(
                                        snapshot.data![index].date!,
                                      ),
                                    )
                                    .toString(),
                              ),
                              // Text(snapshot.data![index].userId!),

                              Text(snapshot.data![index].content!),
                              Text(snapshot.data![index].title!),
                              Text('Tk.${snapshot.data![index].price!}'),
                              ElevatedButton(
                                onPressed: () {
                                  var title = snapshot.data![index].title!;

                                  var content = snapshot.data![index].content!;

                                  var price = snapshot.data![index].price!;

                                  var image = snapshot.data![index].image!;

                                  myBox.add(
                                    Transaction(
                                        title: title,
                                        content: content,
                                        price: price),
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      backgroundColor: Colors.grey[850],
                                      content: const Text(
                                        'added!',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  );

                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: ((context) =>
                                  //         BagScreen(title: title)),
                                  //   ),
                                  // );
                                },
                                child: const Text('Add to bag'),
                              ),
                              // ElevatedButton(
                              //   onPressed: () {
                              //     setState(() {
                              //       DeleteService()
                              //           .postApi(snapshot.data![index].userId!);
                              //     });
                              //   },
                              //   child: const Text('delete'),
                              // ),
                            ],
                          ),
                        );
                      }),
                    ),
                  );
                }
                return const Text('Error');
              }),
            ),
          ),
        ],
      ),
    );
  }
}
