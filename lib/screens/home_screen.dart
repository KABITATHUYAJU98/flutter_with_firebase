import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/screens/email_auth/login_screen.dart';
import 'package:flutter_with_firebase/screens/phone_auth/signin_with_phone.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController ageCont = TextEditingController();
  File? profilePicture;

  void logout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.popUntil(context, (route) => route.isFirst);
    //close all pages
    Navigator.pushReplacement(context,
        CupertinoPageRoute(builder: (context) => SigninWithPhoneScreen()));
  }

  void saveUser() async {
    String name = nameCont.text.trim();
    String email = emailCont.text.trim();
    String ageString = ageCont.text.trim();

    int age = int.parse(ageString);

    nameCont.clear();
    emailCont.clear();
    ageCont.clear();

    if (name != "" && email != "" && profilePicture != null) {
      //if not empty - map the data and store it in firestore

      //uploading profile pic - select instance of storage
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("profilePictures")
          .child(Uuid().v1())
          .putFile(profilePicture!);

      StreamSubscription taskSubscription =
          uploadTask.snapshotEvents.listen((snapshot) {
        double percentage =
            snapshot.bytesTransferred / snapshot.totalBytes * 100;
        log(percentage.toString());
      });

      TaskSnapshot taskSnapShot = await uploadTask;
      //after finishing this uploadTask we get task snapshot
      String downloadUrl = await taskSnapShot.ref
          .getDownloadURL(); //future string so need of await

      //download url milesi task subscription lai..cancel gardinxam

      Map<String, dynamic> userData = {
        "name": name,
        "email": email,
        "age": age,
        "profilepicture": downloadUrl,
      };

      FirebaseFirestore.instance.collection("users").add(userData);
    } else {
      log("Please fill all the fields");
    }

    setState(() {
      profilePicture = null;
    });
  }

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((message) {
      //after receiving message.show snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        // content: Text(message.notification!.body.toString()),
        content: Text(message.data["myname"].toString()),
        duration: const Duration(seconds: 10),
        backgroundColor: Colors.green,
      ));

      log("message received! ${message.notification!.title}");
    });
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
            CupertinoButton(
              onPressed: () async {
                //while tapping - opens file browser - helps to browse image
                XFile? selectedImage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);

                if (selectedImage != null) {
                  File convertedFile = File(selectedImage.path);
                  // while selecting file then..it will equal to profilePicture
                  setState(() {
                    profilePicture = convertedFile;
                  });
                  log("Image is Selected!!");
                } else {
                  log("Image is not Selected!!");
                }
              },
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                backgroundImage: (profilePicture != null
                    ? FileImage(profilePicture!)
                    : null),
              ),
            ),
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
            TextField(
              controller: ageCont,
              decoration: InputDecoration(hintText: "Age"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                child: const Text("Save"),
                onPressed: () {
                  saveUser();
                }),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where("age", isGreaterThan: 1)
                  .orderBy("age", descending: true)
                  .snapshots(),
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
                            leading: CircleAvatar(
                                // fetching from firebase storage
                                backgroundImage:
                                    NetworkImage(userMap["profilepicture"])),
                            title:
                                Text(userMap["name"] + "(${userMap["age"]})"),
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
                    return const Text("No Data!!");
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
