import 'package:flutter/material.dart';
import 'package:logandprice/Menu/Notofication.dart';
import 'package:logandprice/Reqestss/addrequests.dart';
import 'package:logandprice/Reqestss/editenrequests.dart';
import 'package:logandprice/SQlite/sqflite.dart';

void main() {
  runApp(const requestt());
}

class requestt extends StatefulWidget {
  const requestt({super.key});

  @override
  State<requestt> createState() => _HomeState();
}

class _HomeState extends State<requestt> {
  SqlDb sqlDb = SqlDb();

  List orderstb = [];
  bool isLoading = true;
  Future readData() async {
    List<Map> response = await sqlDb.readData("select * from orderstb");
    orderstb.addAll(response);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 36, 130, 111),
        title: const Text('Orders'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => menu()),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addrequests()),
          )..then((value) {
              // This is the callback when returning from addprice screen
            });
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 36, 130, 111),
      ),
      body: isLoading == true
          ? Center(child: Text(' loading..... '))
          : Container(
              child: ListView(
                children: [
                  MaterialButton(
                    onPressed: () async {
                      await sqlDb.mydeletetabase();
                    },
                    child: Text(
                      "Updated on date ${_getCurrentDate()}",
                      style: TextStyle(
                        color: Color.fromARGB(255, 36, 130, 111),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  ListView.builder(
                    itemCount: orderstb.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                          title: Text("${orderstb[i]['codeorder']}"),
                          subtitle: Text("${orderstb[i]['stateorder']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  int response = await sqlDb.deleteData(
                                    "DELETE FROM orderstb where  idorder =${orderstb[i]['idorder']} ",
                                  );
                                  if (response > 0) {
                                    orderstb.removeWhere((element) =>
                                        element['idorder'] ==
                                        orderstb[i]['idorder']);
                                    setState(() {});
                                    // Show the success dialog
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Deleted Successfully",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 36, 130, 111),
                                              fontSize: 15,
                                            ),
                                          ),
                                          content: Text(
                                            "The item has been deleted.",
                                            textAlign: TextAlign.center,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 36, 130, 111),
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
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditeOrder(
                                      codeorder: orderstb[i]['codeorder'],
                                      stateorder: orderstb[i]['stateorder'],
                                      idorder: orderstb[i]['idorder'],
                                    ),
                                  ));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Color.fromARGB(255, 36, 130, 111),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}/${now.month}/${now.year}";
    return formattedDate;
  }
}
