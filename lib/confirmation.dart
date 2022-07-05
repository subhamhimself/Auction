// ignore_for_file: unused_import

import 'package:auction/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'present.dart';
import 'main.dart';

LogOutDialog(BuildContext context) {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Widget cancelButton = ElevatedButton(
    child: const Text("No"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = ElevatedButton(
    child: const Text("Yes"),
    onPressed: () async {
      ()async{
      await firebaseAuth.signOut();
      };
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: const Text("Confirmation"),
    content: const Text("Sign out ?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
