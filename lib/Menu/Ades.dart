import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logandprice/Menu/Notofication.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const ades());
}

class ades extends StatelessWidget {
  const ades({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 36, 130, 111),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAppBar(),
            _buildUserList(),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Widget _buildAppBar() {
    return Container(
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
              'Addresses.. ',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
            subtitle: Text(
              'The reservation period is from 7 to 10 days.',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white54,
                  ),
            ),
            trailing: const CircleAvatar(
              radius: 30,
              backgroundImage:
                  AssetImage('assest/user.png'), // Corrected typo in 'assets'
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(200),
          ),
        ),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 1,
          crossAxisSpacing: 40,
          mainAxisSpacing: 40,
          children: [
            _buildUserDetails(
              'assest/a.png', // Corrected typo in 'assets'
              'United States of America\n',
              'Full Name: Libyan Express / NF201\n'
                  'Address Line 1: 12540 SW Leveton Dr., #F0262\n'
                  'Address Line 2: NF201\n'
                  'City: Tualatin\n'
                  'State: Oregon\n'
                  'Zip / Post code: 97062\n'
                  'Phone number: +14245296998\n',
            ),
            _buildUserDetails(
              'assest/u.png', // Corrected typo in 'assets'
              'United Arab Emirates\n',
              '          Full Name : LE CCMNOS / NF201\n'
                  '         Address Line 1  : STREET 29 ,DEIRA ALKHABISI\n         AREA CCMNOS\n'
                  '         Address line 2 : NEAR KANGAROO PLASTICS\n         STORE NO 5 (NF201)\n'
                  '         City : Dubai\n'
                  '         State : DEIRA\n'
                  '         Zip / Post code : 0000\n'
                  '         Phone number : +971509293890\n',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserDetails(String image, String title, String details) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Theme.of(context).primaryColor.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            image,
            width: 70,
            height: 70,
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Flexible(
            child: Text(
              details,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => menu()),
        );
      },
      backgroundColor: Color.fromARGB(255, 36, 130, 111),
      child: Icon(
        Icons.arrow_back,
        color: Colors.white, // Change the icon color
      ),
    );
  }
}
