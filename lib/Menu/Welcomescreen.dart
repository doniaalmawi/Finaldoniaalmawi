import 'package:flutter/material.dart';
import 'package:logandprice/Menu/aboutus.dart';

class welcomescreen extends StatelessWidget {
  const welcomescreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildContainer1(context),
          _buildContainer2(context),
          _buildImage(context),
          _buildContainer3(context),
          _buildContainer4(context),
        ],
      ),
    );
  }

  Widget _buildContainer1(BuildContext context) {
    return Positioned.fill(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.6,
        decoration: BoxDecoration(
          color: const Color.fromARGB(233, 255, 255, 255),
        ),
      ),
    );
  }

  Widget _buildContainer2(BuildContext context) {
    return Positioned.fill(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.6,
        decoration: BoxDecoration(
          color: const Color.fromARGB(-23, 36, 130, 111),
          borderRadius: BorderRadius.only(
            bottomRight: const Radius.circular(70),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 4,
      left: MediaQuery.of(context).size.width / 6,
      child: Image.asset(
        'assest/interface1.png',
        scale: 0.8,
      ),
    );
  }

  Widget _buildContainer3(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.666,
        decoration: BoxDecoration(
          color: const Color.fromARGB(-23, 36, 130, 111),
        ),
      ),
    );
  }

  Widget _buildContainer4(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.666,
        padding: const EdgeInsets.only(top: 40, bottom: 30),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 248, 247, 246),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(70),
          ),
        ),
        child: Column(
          children: [
            Text(
              'Leading Shipping',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                wordSpacing: 2,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Your First Destination for International Shipping',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Material(
              color: const Color.fromARGB(-23, 36, 130, 111),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutUs(),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
