import 'package:flutter/material.dart';
import 'package:logandprice/Reqestss/Requests.dart';
import 'package:logandprice/SQlite/sqflite.dart';

class EditeOrder extends StatefulWidget {
  final codeorder;
  final stateorder;
  final idorder;

  const EditeOrder({super.key, this.codeorder, this.stateorder, this.idorder});

  @override
  State<EditeOrder> createState() => _EditeOrderState();
}

class _EditeOrderState extends State<EditeOrder> {
  SqlDb sqlDb = SqlDb();
  String selectedStatus = 'All'; // Default status

  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController codeorder = TextEditingController();
  TextEditingController stateorder = TextEditingController();

  @override
  void initState() {
    codeorder.text = widget.codeorder;
    stateorder.text = widget.stateorder;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 36, 130, 111),
        title: Text('Edit Requests'),
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
                        horizontal: 115,
                        vertical: 1,
                      ),
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
                    Container(height: 20),
                    MaterialButton(
                      textColor: Colors.white,
                      color: Color.fromARGB(255, 36, 130, 111),
                      child: Text("Edit Requests"),
                      onPressed: () async {
                        int response = await sqlDb.updateData('''
                          UPDATE orderstb SET 
                          codeorder = "${codeorder.text}",
                          stateorder = "$selectedStatus"
                          WHERE idorder= ${widget.idorder}
                        ''');

                        if (response > 0) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Order updated",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 36, 130, 111),
                                    fontSize: 20,
                                  ),
                                ),
                                content: Text(
                                  "The Order has been successfully updated.",
                                  textAlign: TextAlign.center,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) => requestt(),
                                        ),
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
