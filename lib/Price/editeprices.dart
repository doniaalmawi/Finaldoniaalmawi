import 'package:flutter/material.dart';
import 'package:logandprice/Price/price.dart';
import 'package:logandprice/SQlite/sqflite.dart';

class EditePrice extends StatefulWidget {
  final price;
  final weightt;
  final id;
  const EditePrice({super.key, this.price, this.weightt, this.id});

  @override
  State<EditePrice> createState() => _EditePriceState();
}

class _EditePriceState extends State<EditePrice> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController price = TextEditingController();
  TextEditingController weightt = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    price.text = widget.price;
    weightt.text = widget.weightt;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 36, 130, 111),
        title: Text('Edit Price'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      controller: price,
                      decoration: InputDecoration(
                        hintText: "Price",
                      ),
                    ),
                    TextFormField(
                      controller: weightt,
                      decoration: InputDecoration(
                        hintText: "Weight",
                      ),
                    ),
                    Container(height: 20),
                    MaterialButton(
                      textColor: Colors.white,
                      color: Color.fromARGB(255, 36, 130, 111),
                      child: Text("Edit Price"),
                      onPressed: () async {
                        int response = await sqlDb.updateData('''
                          UPDATE pricestb SET 
                          price = "${price.text}",
                          weightt = "${weightt.text}"
                          WHERE id= ${widget.id}
                        ''');

                        if (response > 0) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Price updated",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 36, 130, 111),
                                    fontSize: 20,
                                  ),
                                ),
                                content: Text(
                                  "The price has been successfully updated.",
                                  textAlign: TextAlign.center,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => pricee()),
                                        (route) => false,
                                      );
                                    },
                                    child: Text(
                                      "OK",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 36, 130, 111),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
