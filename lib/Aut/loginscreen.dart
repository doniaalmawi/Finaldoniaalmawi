import 'package:flutter/material.dart';
import 'package:logandprice/Aut/singup.dart';
import 'package:logandprice/Menu/Notofication.dart';
import 'package:logandprice/SQlite/sqflite.dart';
import 'package:logandprice/json/users.dart';

class loginn extends StatefulWidget {
  const loginn({Key? key}) : super(key: key);

  @override
  _loginnState createState() => _loginnState();
}

class _loginnState extends State<loginn> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isVisible = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoginTrue = false;
  final SqlDb sqlDb = SqlDb();

  String selectedUserType = 'User';

  void login() async {
    var response = await sqlDb.login(
      Users(
        usrName: username.text,
        usrPassword: password.text,
        userType: selectedUserType,
      ),
    );

    if (response == true) {
      // If login is correct, show a pop-up
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Login Successful",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 36, 130, 111),
                fontSize: 20,
              ),
            ),
            content: Text(
              "Welcome back, ${username.text}!",
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => menu(),
                    ),
                  );
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
    } else {
      // If not, set the bool value to show an error message
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  void navigateToSignUp() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => singup()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    "assest/loginp.png", // Corrected asset path
                    width: 210,
                  ),
                  const SizedBox(height: 15),
                  buildInputField(
                    controller: username,
                    labelText: 'Username',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Username is required';
                      }
                      return null;
                    },
                    icon: Icons.person,
                  ),
                  buildInputField(
                    controller: password,
                    labelText: 'Password',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Username is required';
                      }
                      return null;
                    },
                    icon: Icons.lock,
                    obscureText: !isVisible,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: Icon(
                        isVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  buildDropdownButton(),
                  const SizedBox(height: 10),
                  buildLoginButton(),
                  buildSignUpLink(),
                  if (isLoginTrue)
                    const Text(
                      'Username or Password is incorrect',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField({
    required TextEditingController controller,
    required String labelText,
    required FormFieldValidator<String> validator,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromARGB(30, 36, 134, 95),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          icon: Icon(icon),
          border: InputBorder.none,
          labelText: labelText,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  Widget buildDropdownButton() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 126, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromARGB(30, 36, 134, 95),
      ),
      child: DropdownButton<String>(
        value: selectedUserType,
        icon: const Icon(Icons.admin_panel_settings),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        onChanged: (String? newValue) {
          setState(() {
            selectedUserType = newValue!;
          });
        },
        items: <String>['User', 'Admin']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget buildLoginButton() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromARGB(255, 36, 130, 111),
      ),
      child: TextButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            login();
          }
        },
        child: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'),
        TextButton(
          onPressed: navigateToSignUp,
          child: const Text(
            'Sign Up',
            style: TextStyle(color: Color.fromARGB(255, 36, 130, 111)),
          ),
        ),
      ],
    );
  }
}
