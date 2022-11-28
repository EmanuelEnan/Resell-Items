import 'package:backend_flutter/scrn/place_order.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import '../main.dart';
import '../models/order.dart';
import '../models/transaction.dart';

class SaveFolder extends StatefulWidget {
  const SaveFolder({Key? key}) : super(key: key);

  @override
  State<SaveFolder> createState() => _SaveFolderState();
}

class _SaveFolderState extends State<SaveFolder> {
  Box<Order> myOrder = Hive.box<Order>(orderName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('save'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Transaction>(bagName).listenable(),
          builder: (context, box, _) {
            _totalPrice() {
              double total = 0;
              // for (int i = 0;
              //     i < Hive.box<Transaction>(bagName).values.length;
              //     i++) {
              //   total += double.parse(price);
              // }

              Hive.box<Transaction>(bagName).values.forEach((element) {
                total += double.parse(element.price!);
              });
              return total.toString();
            }

            if (Hive.box<Transaction>(bagName).values.isEmpty) {
              return const Center(
                child: Text('no data'),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: Hive.box<Transaction>(bagName).length,
                    itemBuilder: (context, index) {
                      // final transactions = box.getAt(index) as Transaction;
                      int itemCount = Hive.box<Transaction>(bagName).length;
                      // int reversedIndex = itemCount - 1 - index;
                      final transactions =
                          Hive.box<Transaction>(bagName).values.toList();

                      var price = transactions[index].price!;

                      //  get totalPrice => _totalPrice;

                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                (index + 1).toString(),
                              ),
                              Text(
                                transactions[index].content!,
                              ),
                              Text(
                                transactions[index].title!,
                              ),
                              Text(
                                '${transactions[index].price!}tk.',
                              ),

                              const SizedBox(height: 10),

                              // ElevatedButton(
                              //   onPressed: () async {
                              //     await Hive.box('transactions').getAt(index);
                              //     print('go to the tweet');
                              //   },
                              //   child: const Text('delete'),
                              // ),

                              ElevatedButton(
                                onPressed: () async {
                                  await Hive.box<Transaction>(bagName)
                                      .deleteAt(index);
                                  // setState(() {});
                                  print('deleted');
                                },
                                child: const Text('delete'),
                              ),

                              // Row(
                              //   children: [
                              //     const Text('total: '),
                              //     Text(transactions[0].price! +
                              //         transactions[1].price!),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        'Tk.${_totalPrice()}',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () {
                      myOrder.get('cred') == null
                          ? Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) => PlaceOrder()),
                              ),
                            )
                          : showAlertDialog(context);

                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     duration: const Duration(milliseconds: 500),
                      //     backgroundColor: Colors.grey[850],
                      //     content: const Text(
                      //       'Order placed!',
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // );
                    },
                    child: const Text('Place Order'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        myOrder.delete('cred');
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: ((context) => PlaceOrder()),
        //   ),
        // );
        Navigator.of(context).pop();
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 1500),
            backgroundColor: Colors.grey[850],
            content: const Text(
              'Please register your number again by pressing PLACE ORDER',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        // print('${myOrder.get('cred')!.phnNo} deleted');
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 500),
            backgroundColor: Colors.grey[850],
            content: const Text(
              'Order placed!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("AlertDialog"),
      content: Text(
          "You're placing order from ${myOrder.get('cred')!.phnNo}. Is it OK?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
