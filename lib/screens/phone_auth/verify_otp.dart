import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/screens/home_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String verificationId;

  const VerifyOtpScreen({super.key, required this.verificationId});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  TextEditingController otpController = TextEditingController();

  void verifyOTP() async {
    //max min length of otp -- 6 in firebase
    String otp = otpController.text.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        //after success do whatever you want to
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (ex) {
      log(ex.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Verify OTP'),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              TextField(
                controller: otpController,
                maxLength: 6,
                decoration: const InputDecoration(labelText: "6-Digit OTP"),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    verifyOTP();
                  },
                  child: const Text('Verify'))
            ]),
          )
        ],
      )),
    );
  }
}
