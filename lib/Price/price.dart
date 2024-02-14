import 'package:flutter/material.dart';
import 'package:logandprice/Price/addprices.dart';
import 'package:logandprice/Price/editeprices.dart';
import 'package:logandprice/SQlite/sqflite.dart';

void main() {
  runApp(const pricee());
}

class pricee extends StatefulWidget {
  const pricee({super.key});

  @override
  State<pricee> createState() => _HomeState();
}

class _HomeState extends State<pricee> {
  SqlDb sqlDb = SqlDb();

  List pricestb = [];
  bool isLoading = true;
  Future readData() async {
    List<Map> response = await sqlDb.readData("select * from pricestb");
    pricestb.addAll(response);
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
        title: const Text('Shipping prices'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addprice()),
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
                    itemCount: pricestb.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                          title: Text("${pricestb[i]['price']}"),
                          subtitle: Text("${pricestb[i]['weightt']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  int response = await sqlDb.deleteData(
                                    "DELETE FROM pricestb where  id =${pricestb[i]['id']} ",
                                  );
                                  if (response > 0) {
                                    pricestb.removeWhere((element) =>
                                        element['id'] == pricestb[i]['id']);
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
                                    builder: (context) => EditePrice(
                                      price: pricestb[i]['price'],
                                      weightt: pricestb[i]['weightt'],
                                      id: pricestb[i]['id'],
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
