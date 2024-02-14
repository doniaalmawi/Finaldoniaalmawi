import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:logandprice/Menu/Ades.dart';
import 'package:logandprice/Menu/Trac.dart';
import 'package:logandprice/Menu/aboutus.dart';
import 'package:logandprice/Price/price.dart';
import 'package:logandprice/Setings.dart';

import '../Reqestss/Requests.dart';

class menu extends StatelessWidget {
  const menu({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Page of Shipping Company',
      theme: ThemeData(
        primaryColor: Color.fromARGB(-23, 36, 130, 111),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userType = "User"; // يمكنك تعديل قيمة userType هنا

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text(
                    'Welcome Dear..',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Color.fromARGB(255, 246, 246, 246)),
                  ),
                  subtitle: Text(
                    'Have a nice day',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white54),
                  ),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assest/user.png'),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 50,
                children: [
                  itemDashboard(
                    ' Addresses',
                    Icons.location_on,
                    const Color.fromARGB(-23, 36, 130, 111),
                    () {
                      // Navigate to AddressesScreen when Addresses item is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ades()),
                      );
                    },
                  ),
                  itemDashboard(
                    'Requests ',
                    Icons.shopping_cart,
                    const Color.fromARGB(-23, 36, 130, 111),
                    () {
                      if (userType == "Admin") {
                        // إذا كان اليوزر من نوع "User" قم بعرض النافذة المنبثقة
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "Permission Denied",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 36, 130, 111),
                                  fontSize: 15,
                                ),
                              ),
                              content: Text(
                                "You don't have permission to access this.",
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
                                      color: Color.fromARGB(255, 36, 130, 111),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else if (userType == "Admin") {
                        // إذا كان اليوزر من نوع "Admin" قم بعرض الشاشة requstt
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => requestt()),
                        );
                      }
                    },
                  ),
                  itemDashboard(
                    'Prices',
                    CupertinoIcons.money_dollar,
                    const Color.fromARGB(-23, 36, 130, 111),
                    () {
                      // Navigate to AddressesScreen when Addresses item is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => pricee()),
                      );
                    },
                  ),
                  itemDashboard(
                    'Tracking ',
                    Icons.flight_takeoff_rounded,
                    const Color.fromARGB(-23, 36, 130, 111),
                    () {
                      // Navigate to AddressesScreen when Addresses item is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Track()),
                      );
                    },
                  ),
                  itemDashboard(
                    'Settings',
                    Icons.settings,
                    const Color.fromARGB(-23, 36, 130, 111),
                    () {
                      // Navigate to AddressesScreen when Addresses item is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()),
                      );
                    },
                  ),
                  itemDashboard(
                    'About us',
                    Icons.people_alt_outlined,
                    const Color.fromARGB(-23, 36, 130, 111),
                    () {
                      // Navigate to AddressesScreen when Addresses item is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutUs()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  Widget itemDashboard(String title, IconData iconData, Color background,
          Function? onPressed) =>
      GestureDetector(
        onTap: () {
          if (onPressed != null) {
            onPressed();
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    color: Theme.of(context).primaryColor.withOpacity(.2),
                    spreadRadius: 2,
                    blurRadius: 5)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: Colors.white)),
              const SizedBox(height: 8),
              Text(title, style: Theme.of(context).textTheme.titleMedium)
            ],
          ),
        ),
      );
}
