import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/screens/phone_auth/verify_otp.dart';

class SigninWithPhoneScreen extends StatefulWidget {
  const SigninWithPhoneScreen({super.key});

  @override
  State<SigninWithPhoneScreen> createState() => _SigninWithPhoneState();
}

class _SigninWithPhoneState extends State<SigninWithPhoneScreen> {
  TextEditingController phoneController = TextEditingController();

  //func to send otp || take phone number and send code - after code send go to verify otp screen
  void sendOTP() async {
    String phone = "+977" + phoneController.text.trim();
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        codeSent: (verificationId, resendToken) {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => VerifyOtpScreen(verificationId: verificationId,)));
        },
        verificationCompleted: (credential) {},
        verificationFailed: (ex) {
          // log(ex.code.toString());
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: Duration(seconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign in with Phone"),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Phone Number"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    sendOTP();
                  },
                  child: Text('Sign in'))
            ]),
          )
        ],
      )),
    );
  }
}
