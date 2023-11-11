import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/screens/email_auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              const TextField(
                decoration: InputDecoration(labelText: "Email Address"),
              ),
              const SizedBox(
                height: 10,
              ),
              const TextField(
                decoration: InputDecoration(labelText: "Password"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(child: const Text("Login"), onPressed: () {}),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  child: const Text('Create a new Account'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const SignupScreen()));
                  })
            ]),
          )
        ],
      )),
    );
  }
}
