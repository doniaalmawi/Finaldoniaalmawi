import 'package:flutter/material.dart';

class pricepagee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيقك',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: ListView(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 15, bottom: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 132, 107, 14),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            // تنفيذ الإجراء المناسب عند تحديد عنصر من القائمة الفرعية
                            if (value == 'Task 1') {
                              // إجراء 1
                            } else if (value == 'Task 2') {
                              // إجراء 2
                            } else if (value == 'Task 3') {
                              // إجراء 3
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                value: 'Task 1',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.shopping_cart,
                                      color: Color.fromARGB(255, 132, 107, 14),
                                    ), // أيقونة العنصر
                                    SizedBox(
                                        width: 10), // مسافة بين الأيقونة والنص
                                    Text('طلباتي الأخيرة'), // النص
                                  ],
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'Task 2',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.inbox,
                                      color: Color.fromARGB(255, 132, 107, 14),
                                    ), // أيقونة العنصر
                                    SizedBox(
                                        width: 10), // مسافة بين الأيقونة والنص
                                    Text('شحناتي الأخيرة'), // النص
                                  ],
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'Task 3',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.exit_to_app,
                                      color: Colors.red,
                                    ), // أيقونة العنصر
                                    SizedBox(
                                        width: 10), // مسافة بين الأيقونة والنص
                                    Text('تسجيل خروج'), // النص
                                  ],
                                ),
                              ),
                            ];
                          },
                          child: Icon(
                            Icons.menu,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.notifications,
                          size: 30,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 3, bottom: 15),
                      child: Text(
                        "قائمة الأسعار",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          wordSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: Container(
                  width: 300,
                  height: 500,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(100, 132, 107, 14),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
