// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:auction/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'present.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data == null)
            return const LoginWidget();
          else if (snapshot.hasError)
            return const LoginWidget();
          else {
            // print(snapshot.data==null);
            return const Home();
            // return const LoginWidget();
          }
        });
  }
}
