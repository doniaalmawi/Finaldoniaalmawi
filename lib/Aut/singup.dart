import 'package:flutter/material.dart';
import 'package:logandprice/Aut/loginscreen.dart';
import 'package:logandprice/SQlite/sqflite.dart';
import 'package:logandprice/json/users.dart';

class singup extends StatefulWidget {
  const singup({Key? key}) : super(key: key);

  @override
  State<singup> createState() => _SignUpState();
}

class _SignUpState extends State<singup> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isVisible = false;
  String selectedUserType = 'User';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assest/loginp.png',
                    height: 150,
                  ),
                  Text(
                    'Welcome to Shipping Company',
                    style: TextStyle(
                      color: const Color.fromARGB(137, 255, 251, 251),
                      fontSize: 15,
                    ),
                  ),
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
                        return 'Password is required';
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
                  buildInputField(
                    controller: confirmPassword,
                    labelText: 'Confirm Password',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Password is required';
                      } else if (password.text != confirmPassword.text) {
                        return 'Passwords do not match';
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
                  const SizedBox(height: 10),
                  buildDropdownButton(),
                  const SizedBox(height: 10),
                  buildSignUpButton(),
                  buildLoginLink(),
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

  Widget buildSignUpButton() {
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
            signUp();
          }
        },
        child: const Text(
          'Sign up',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const loginn(),
              ),
            );
          },
          child: const Text(
            'Login',
            style: TextStyle(color: Color.fromARGB(255, 36, 130, 111)),
          ),
        ),
      ],
    );
  }

  void signUp() async {
    final db = SqlDb();

    await db
        .signup(
      Users(
        usrName: username.text,
        usrPassword: password.text,
        userType: selectedUserType,
      ),
    )
        .then((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Account Created',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 36, 130, 111),
                fontSize: 20,
              ),
            ),
            content: Text(
              'Your account has been created successfully',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const loginn(),
                    ),
                  );
                },
                child: Text(
                  'OK',
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
    });
  }
}
