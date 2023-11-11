import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_with_firebase/screens/email_auth/login_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // initialization of flutter app related configurations
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
          : LoginScreen(), //if you are not logged in then login screen --- otherwise in home screen
    );
  }
}
