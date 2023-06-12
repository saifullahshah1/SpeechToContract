import 'package:firebae_reg_auth/trash/dashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../contact_module/dashboard_page.dart';
import '../firebase_options.dart';
import '../trash/dashboardScreen.dart';
import '../main.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  // String email = "";
  // String password = "";

  bool _obscureText = true;
  final _email = TextEditingController();
  final _password = TextEditingController();

  void navToRegisterScreen() {
    Navigator.pushNamed(context, Register.id);
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        style: TextStyle(color: Colors.white),
        controller: _email,
        autofocus: false,
        validator: (value) {
          if (value != null) {
            if (value.contains('@') && value.endsWith('.com')) {
              return null;
            }
            return 'Enter a Valid Email Address';
          }
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email",
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(32.0),
          ),

            // border:
            //     OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)
            //     )
        )
    );

    final passwordField = TextFormField(
        style: TextStyle(color: Colors.white),
        obscureText: _obscureText,
        controller: _password,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          if (value.trim().length < 6) {
            return 'Password must be at least 6 characters in length';
          }
          // Return null if the entered password is valid
          return null;
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.white),
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(32.0),
            ),

            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(32.0),
            // )
        )
    );

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Log In"),
          centerTitle: true,
          backgroundColor: Color(0xFFF9AA33),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        // backgroundColor: Colors.grey,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text("Email"),
              // TextField(onChanged: (value) {
              //   email = value;
              // }),
              // SizedBox(
              //   height: 8.0,
              // ),
              // Text("Password"),
              // SizedBox(
              //   height: 8.0,
              // ),
              // TextField(onChanged: (value) {
              //   password = value;
              // }),
              // SizedBox(
              //   height: 8.0,
              // ),
              // MaterialButton(
              //   onPressed: () async {
              //     try {
              //       final user = await _auth.signInWithEmailAndPassword(
              //           email: email, password: password);
              //       if (user != null) {
              //         print("User Logged In");
              //         Navigator.pushNamed(context, DashBoard.id);
              //       }
              //     } catch (e) {
              //       print(e);
              //     }
              //   },
              //   minWidth: 200.0,
              //   height: 42.0,
              //   child: Text(
              //     'Log In',
              //     style: TextStyle(color: Colors.red),
              //   ),
              // ),

              const SizedBox(height: 45.0),
              emailField,
              const SizedBox(height: 25.0),
              passwordField,
              const SizedBox(height: 25.0),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Color(0xFFF9AA33),
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () async {
                    print(_email.text);
                    print(_password.text);
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: _email.text, password: _password.text);
                      if (user != null) {
                        print("User Logged In");
                        // Navigator.pushNamed(context, DashBoard.id);
                        Navigator.pushNamed(context, DashboardPage.id);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              TextButton(
                  onPressed: navToRegisterScreen,
                  child: const Text('Register Here')),
            ],
          ),
        ),
    );
  }
}
