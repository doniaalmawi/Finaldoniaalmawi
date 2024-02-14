import 'package:flutter/material.dart';
import 'package:logandprice/Reqestss/editenrequests.dart';
import 'package:logandprice/SQlite/sqflite.dart';

void main() {
  runApp(const Track());
}

class Track extends StatefulWidget {
  const Track({super.key});

  @override
  State<Track> createState() => _HomeState();
}

class _HomeState extends State<Track> {
  SqlDb sqlDb = SqlDb();

  List orderstb = [];
  bool isLoading = true;
  bool isEditMode = false; // Add this variable
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
        title: const Text('Tracking'),
      ),
      floatingActionButton: null, // Hide FloatingActionButton
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
                              if (!isEditMode)
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
                                    color: Color.fromARGB(3, 248, 243, 249),
                                  ),
                                ),
                              if (!isEditMode)
                                IconButton(
                                  onPressed: () async {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EditeOrder(
                                          codeorder: orderstb[i]['codeorder'],
                                          stateorder: orderstb[i]['stateorder'],
                                          idorder: orderstb[i]['idorder'],
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Color.fromARGB(3, 248, 243, 249),
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
