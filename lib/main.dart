import 'package:auction/additem.dart';
import 'package:auction/mainpage.dart';
import 'package:flutter/material.dart';
import 'present.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import 'mainpage.dart';

bool confirm = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Present(),
      // home: MainPage(),
      initialRoute: '/mainpage',
          routes: {
            '/mainpage':(context) => const MainPage(),
            '/login':(context) => const LoginWidget(),
            '/home': (context) => const Home(),
            '/additem': (context) => const AddItem(),
            // '/itempage':(context)=> const ItemPage(),
          },

    );
  }
}
