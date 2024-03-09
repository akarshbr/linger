import 'package:flutter/material.dart';

import '../../controller/sql_helper.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void registerUser(String name, String email, String password) async {
      var id = await SQLFunction.addUser(name, email, password);
      if (id != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration Failed"), backgroundColor: Colors.redAccent));
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
              "SIGNUP",
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            Image(
              image: AssetImage("assets/hotel/hotellogo.png"),
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  hintText: "Name",
                  hintStyle: TextStyle(color: Colors.purple),
                  labelText: "Name",
                  labelStyle: TextStyle(color: Colors.purple),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: TextFormField(
                controller: emailController,
                validator: (enteredEmail) {
                  if (enteredEmail!.isEmpty || !enteredEmail.contains("@")) {
                    return "Enter proper email dumbass";
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
                    return "Password should be at least 6 character";
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
                  var users = await SQLFunction.checkUserRegistered(emailController.text);
                  if (users.isNotEmpty) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("User Already Registered!!!"), backgroundColor: Colors.redAccent));
                  } else {
                    registerUser(nameController.text, emailController.text, passwordController.text);
                  }
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Please Verify All the Fields"), backgroundColor: Colors.redAccent));
                }
              },
              child: Text(
                "SignUp",
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
          ],
        ),
      ),
    );
  }
}
