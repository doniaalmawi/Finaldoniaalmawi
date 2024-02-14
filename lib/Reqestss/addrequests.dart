import 'package:flutter/material.dart';
import 'package:logandprice/Reqestss/Requests.dart';
import 'package:logandprice/SQlite/sqflite.dart';

class addrequests extends StatefulWidget {
  const addrequests({super.key});

  @override
  State<addrequests> createState() => _AddNotesState();
}

class _AddNotesState extends State<addrequests> {
  SqlDb sqlDb = SqlDb();
  String selectedStatus = 'All'; // Default status

  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController codeorder = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 36, 130, 111),
        title: Text('Add Requests'),
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
                      controller: codeorder,
                      decoration: InputDecoration(
                        hintText: "Code Order",
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '___________________ Status ___________________',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 36, 130, 111),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(width: 10),
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 115, vertical: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color.fromARGB(255, 36, 130, 111),
                          width: 0,
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: selectedStatus,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 50,
                        style: TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedStatus = newValue!;
                          });
                        },
                        items: <String>[
                          'All',
                          'Pending',
                          'Shipped',
                          'Delivered'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 20),
                    MaterialButton(
                      textColor: Colors.white,
                      color: Color.fromARGB(255, 36, 130, 111),
                      child: Text("Add Requests"),
                      onPressed: () async {
                        int response = await sqlDb.insertData('''
                          INSERT INTO orderstb (codeorder, stateorder)
                          VALUES("${codeorder.text}", "$selectedStatus")
                        ''');
                        if (response > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => requestt()),
                            (route) => false,
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
