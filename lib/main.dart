import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_with_firebase/screens/email_auth/login_screen.dart';
import 'package:flutter_with_firebase/screens/phone_auth/signin_with_phone.dart';
import 'package:flutter_with_firebase/services/notification_service.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // initialization of flutter app related configurations
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationService.initialize();

  // /** Fetching Data **/
  // // QuerySnapshot snapshot =
  // //     await FirebaseFirestore.instance.collection("users").get();

  // DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //     .collection("users")
  //     .doc("ac0eR78yu6prRjyJkJmk")
  //     .get();

  // log(snapshot.data().toString());

  // // for (var doc in snapshot.docs) {
  // //   log(doc.data().toString());
  // // }
  // // log(snapshot.docs.toString());
  // //specific doc - provide ID to get

  //*****Writing DAta */

  // FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Map<String, dynamic> newUserData = {
  //   "name": "writing data",
  //   "email": "writing@gmail.com"
  // }; //data of new user

  // // await _firestore.collection("users").add(newUserData);
  // await _firestore.collection("users").doc("id-here").set(newUserData); //manually giving doc id

  // log("New User Saved!!");

  //***Updating Data */
  // await _firestore
  //     .collection("users")
  //     .doc("id-here")
  //     .update({"email": "kabs@gmail.com"});

  // log("User Updated!!");

  /*** Deleting User */
  // await _firestore.collection("users").doc("id-here").delete();
  // log("User Deleted!!");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null)
          ? HomeScreen()
          // : LoginScreen(), //if you are not logged in then login screen --- otherwise in home screen
          : SigninWithPhoneScreen(),
    );
  }
}
