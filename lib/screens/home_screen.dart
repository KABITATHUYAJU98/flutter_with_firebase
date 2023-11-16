import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/screens/email_auth/login_screen.dart';
import 'package:flutter_with_firebase/screens/phone_auth/signin_with_phone.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();

  void logout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.popUntil(context, (route) => route.isFirst);
    //close all pages
    Navigator.pushReplacement(context,
        CupertinoPageRoute(builder: (context) => SigninWithPhoneScreen()));
  }

  void saveUser() {
    String name = nameCont.text.trim();
    String email = emailCont.text.trim();

    nameCont.clear();
    emailCont.clear();

    if (name != "" && email != "") {
      //if not empty - map the data and store it in firestore

      Map<String, dynamic> userData = {"name": name, "email": email};

      FirebaseFirestore.instance.collection("users").add(userData);
    } else {
      log("Please fill all the fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home'),
        actions: [
          IconButton.outlined(
              onPressed: () {
                logout();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: nameCont,
              decoration: InputDecoration(hintText: "Name"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailCont,
              decoration: InputDecoration(hintText: "Email Address"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                child: const Text("Save"),
                onPressed: () {
                  saveUser();
                }),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (context, snapshot) {
                //it comes form  .snapshots
                //.get() - we get query snapshot but from .snapshots() - it gives real time data

                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    //show data
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          // from docs we have to select current index

                          //map for easiness
                          Map<String, dynamic> userMap =
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;

                          return ListTile(
                            title: Text(userMap["name"]),
                            subtitle: Text(userMap["email"]),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                //Delete the particular document
                              },
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    //show error message
                    return Text("No Data!!");
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      )),
    );
  }
}
