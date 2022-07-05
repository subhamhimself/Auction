// ignore_for_file: avoid_print, curly_braces_in_flow_control_structures
// import 'package:auction/present.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}
class _LoginWidgetState extends State<LoginWidget> {
  final _textController = TextEditingController();
  final _userPasswordController = TextEditingController();
  bool _passwordVisible = false;
  Future signup() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _textController.text, password: _userPasswordController.text);
      Fluttertoast.showToast(msg: 'Signed in', gravity: ToastGravity.CENTER);
      // setState(() {});
    } on FirebaseAuthException catch (e) {
      try {
        switch (e.code) {
          case "ERROR_WRONG_PASSWORD":
          case "wrong-password":
          case "ERROR_TOO_MANY_REQUESTS":
          case "operation-not-allowed":
          case "too-many-requests":
          case "ERROR_USER_DISABLED":
          case "user-disabled":
          case "ERROR_OPERATION_NOT_ALLOWED":
          case "ERROR_INVALID_EMAIL":
          case "invalid-email":
            rethrow;
          default:
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _textController.text,
                password: _userPasswordController.text);
            Fluttertoast.showToast(
                msg:
                    'Succesfully signed up and signed in for ${_textController.text}',
                gravity: ToastGravity.CENTER);
        }
      } on FirebaseAuthException catch (e) {
        String x = e.toString();
        int i = 0;
        while (x[i] != ']') i++;
        i++;
        x = x.substring(i);
        if (e.code == 'wrong-password') x = 'Wrong password entered !';
        Fluttertoast.showToast(msg: x, gravity: ToastGravity.CENTER);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SignIn/SignUp")),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(50, 100, 50, 0),
        child: Column(children: [
          TextFormField(
            controller: _textController,
            autofocus: true,
            decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter Email',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _textController.clear();
                  },
                )),
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: _userPasswordController,
            obscureText: !_passwordVisible, //This will obscure text dynamically
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              // Here is key idea
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              child: const Text("Submit"),
              onPressed: () {
                signup();
              },
            ),
          )
        ]),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(title: const Text("lol")),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () => signup(),
    //     child: const Icon(Icons.login),
    //   ),
    // );
  }
}
