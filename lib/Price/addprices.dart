import 'package:flutter/material.dart';
import 'package:logandprice/Price/price.dart';
import 'package:logandprice/SQlite/sqflite.dart';

class addprice extends StatefulWidget {
  const addprice({super.key});

  @override
  State<addprice> createState() => _AddNotesState();
}

class _AddNotesState extends State<addprice> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController price = TextEditingController();
  TextEditingController weightt = TextEditingController();
  TextEditingController color = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 36, 130, 111),
        title: Text('Add Prices'),
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
                          hintText: "weightt",
                        ),
                      ),
                      TextFormField(
                        controller: weightt,
                        decoration: InputDecoration(
                          hintText: "price",
                        ),
                      ),
                      Container(height: 20),
                      MaterialButton(
                        textColor: Colors.white,
                        color: const Color.fromARGB(-23, 36, 130, 111),
                        child: Text("Add price"),
                        onPressed: () async {
                          int response = await sqlDb.insertData('''
                       INSERT INTO pricestb (price,weightt)
                        VALUES("${price.text}","${weightt.text}")
                     ''');
                          if (response > 0) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => pricee()),
                                (route) => false);
                          }
                        },
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
