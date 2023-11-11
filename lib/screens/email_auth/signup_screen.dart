import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  void createAccount() async {
    // take value of all 3 controllers
    String email = emailController.text.trim(); //trim - removes spaces
    String password = passwordController.text.trim();
    String cPassword = cpasswordController.text.trim();

    if (email == "" || password == "" || cPassword == "") {
      log("Please fill all the details!!");
    } else if (password != cPassword) {
      log("Passwords do not match");
    } else {
      try {
        //Create new Account
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.pop(context);
        }
        log("User Created!");
      } on FirebaseAuthException catch (ex) {
        if (ex.code == "weak-password") {
          //snackbar
        }
        log(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create an Account"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: "Email Address"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: cpasswordController,
                    decoration: InputDecoration(labelText: "Confirm Password"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        createAccount();
                      },
                      child: const Text("Create an Account"))
                ]),
              )
            ],
          ),
        ));
  }
}
