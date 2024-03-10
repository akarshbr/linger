import 'package:flutter/material.dart';
import 'package:linger/view/current_screen/current_screen.dart';
import 'package:linger/view/login_signup_screen/signup_screen.dart';

import '../../controller/sql_helper.dart';
import '../admin_screen/admin_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void loginUser(String email, String password) async {
      if (email == "@admin" && password == "root123") {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AdminScreen()));
      } else {
        var data = await SQLFunction.checkUserExist(email, password);
        if (data.isNotEmpty) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CurrentScreen(data: data)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Invalid Email or password"),
            backgroundColor: Colors.redAccent,
          ));
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LOGIN",
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            Image(
              image: AssetImage("assets/logo/hotellogo.png"),
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                controller: emailController,
                validator: (enteredEmail) {
                  if (enteredEmail!.isEmpty || !enteredEmail.contains("@")) {
                    return "Enter Proper Email Idiot";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.purple),
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.purple),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: TextFormField(
                controller: passwordController,
                validator: (enteredPassword) {
                  if (enteredPassword!.isEmpty || enteredPassword.length < 6) {
                    return "Password length should be greater than 6";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.purple),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.purple),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var valid = formkey.currentState!.validate();
                if (valid == true) {
                  loginUser(emailController.text, passwordController.text);
                  emailController.clear();
                  passwordController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please Verify All the Fields"),
                    backgroundColor: Colors.redAccent,
                  ));
                }
              },
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  // If the button is pressed, return green, otherwise blue
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.white;
                  }
                  return Colors.purple;
                }),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text("Dont have an Account,"),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                    },
                    child: Text(
                      "Sign UP",
                      style: TextStyle(color: Colors.purple),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
