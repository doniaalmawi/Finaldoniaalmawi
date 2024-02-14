import 'package:flutter/material.dart';
import 'package:logandprice/Menu/Notofication.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 36, 130, 111),
          title: const Text('About us'),
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
        body: Stack(
          children: [
            // Background Image
            BackgroundPhoto(),

            // Custom AppBar
            CustomAppBar(),

            // Your other widgets can be added on top of the background
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          // You can add more widgets to the right of the back arrow icon if needed
        ],
      ),
    );
  }
}

class BackgroundPhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assest/Back.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
