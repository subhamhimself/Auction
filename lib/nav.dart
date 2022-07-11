// ignore: sort_child_properties_last

// ignore_for_file: unused_import, use_build_context_synchronously, curly_braces_in_flow_control_structures
import 'confirmation.dart';
import 'package:auction/present.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'main.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _signOut() async {
    await _firebaseAuth.signOut();
    Fluttertoast.showToast(
        msg: 'Signed out successfully', gravity: ToastGravity.CENTER);
    while (Navigator.canPop(context)) Navigator.pop(context);
    //       }
    //     }));
  }

  @override
  Widget build(BuildContext context) {
    String? email = FirebaseAuth.instance.currentUser!.email;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
           DrawerHeader(
            // ignore: sort_child_properties_last
            child: Text(
              'Welcome $email',
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
          // ListTile(
          //   // leading: const Icon(Icons.input),
          //   title: Text('Welcome $email',
          //   style: TextStyle(fontSize: 24),),
          //   onTap: () => {},
          // ),
          // ListTile(
          //   leading: const Icon(Icons.verified_user),
          //   title: const Text('Profile'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          // ListTile(
          //   leading: const Icon(Icons.settings),
          //   title: const Text('Settings'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          // ListTile(
          //   leading: const Icon(Icons.border_color),
          //   title: const Text('Feedback'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => {
              _signOut()
              // LogOutDialog(context)

              // Navigator.pushNamed(context,const Home())
            },
          ),
        ],
      ),
    );
  }
}
