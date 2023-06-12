import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../contact_module/dashboard_page.dart';
import '../trash/dashboardScreen.dart';
import 'loginScreen.dart';

import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebae_reg_auth/profiling_module/utils.dart';

class Register extends StatefulWidget {
  static const id = "register_screen";
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // String name = "";
  // String phno = "";
  // String email = "";
  String password = "";
  bool _obscureText = true;

  final _email = TextEditingController();
  final _name = TextEditingController();
  final _phno = TextEditingController();
  final _password = TextEditingController();

  void navToLoginScreen() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
        style: TextStyle(color: Colors.white),
        controller: _name,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
            hintText: "Name",
            hintStyle: TextStyle(color: Colors.white),
            // border:
            //     OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)
            //     )

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(32.0),
          ),

        )
    );
    final phnoField = TextFormField(
        style: TextStyle(color: Colors.white),
        controller: _phno,
        autofocus: false,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
            hintText: "Phno",
          hintStyle: TextStyle(color: Colors.white),
            // border:
            //     OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)
            //     )

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(32.0),
          ),

        )
    );
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
            contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
            hintText: "Email",
          hintStyle: TextStyle(color: Colors.white),
            // border:
            //     OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(32.0),
            //     )

            enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(32.0),
    ),
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
        contentPadding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
        // labelStyle: TextStyle(
        //   color: Colors.white,
        // ),
        hintText: "Password",
        hintStyle: TextStyle(color: Colors.white),
        suffixIcon: IconButton(
          color: Colors.white,
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
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
        //     borderSide:  BorderSide(color: Colors.white,width: 5.0),
        //   borderRadius: BorderRadius.circular(32.0),
        // ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
        backgroundColor: Color(0xFFF9AA33),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            nameField,
            SizedBox(
              height: 6.0,
            ),
            phnoField,
            SizedBox(
              height: 6.0,
            ),
            emailField,
            SizedBox(
              height: 6.0,
            ),
            passwordField,
            const SizedBox(
              height: 3.0,
            ),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Color(0xFFF9AA33),
              child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                onPressed: () async {
                  print(_name.text);
                  print(_email.text);
                  print(_phno.text);
                  print(_password.text);
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: _email.text, password: _password.text);
                    if (newUser != null) {
                      print("User registered");
                      _firestore.collection('users').add({
                        'email': _email.text,
                        'name': _name.text,
                        'number': _phno.text
                      });
                      // Navigator.pushNamed(context, DashBoard.id);
                      Navigator.pushNamed(context, DashboardPage.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TextButton(
              onPressed: navToLoginScreen,
              child: const Text('Have an account?'),
            ),
          ],
        ),
      ),
    );
  }

/*
  // @override
  // Widget build(BuildContext context) {
  //   double baseWidth = 360;
  //   double fem = MediaQuery.of(context).size.width / baseWidth;
  //   double ffem = fem * 0.97;
  //   return Scaffold(
  //     body:Container(
  //       width: double.infinity,
  //       child: Container(
  //         // signupyKC (1:205)
  //         width: double.infinity,
  //         height: 800*fem,
  //         decoration: BoxDecoration (
  //           gradient: LinearGradient (
  //             begin: Alignment(0, -1),
  //             end: Alignment(0, 1),
  //             colors: <Color>[Color(0xff020202), Color(0xff000000)],
  //             stops: <double>[0.047, 0.902],
  //           ),
  //         ),
  //         child: Stack(
  //           children: [
  //             Positioned(
  //               // component432YN (115:337)
  //               left: 54*fem,
  //               top: 538*fem,
  //               child: Container(
  //                 width: 251*fem,
  //                 height: 45*fem,
  //                 decoration: BoxDecoration (
  //                   color: Color(0xfff9aa33),
  //                   borderRadius: BorderRadius.circular(20*fem),
  //                 ),
  //                 child: Center(
  //                   child: Text(
  //                     'Sign up',
  //                     textAlign: TextAlign.center,
  //                     style: SafeGoogleFont (
  //                       'Poppins',
  //                       fontSize: 16*ffem,
  //                       fontWeight: FontWeight.w400,
  //                       height: 1.5*ffem/fem,
  //                       color: Color(0xff000000),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //               // component41sYz (115:335)
  //               left: 31*fem,
  //               top: 339*fem,
  //               child: Container(
  //                 padding: EdgeInsets.fromLTRB(29*fem, 10*fem, 29*fem, 11*fem),
  //                 width: 300*fem,
  //                 height: 45*fem,
  //                 decoration: BoxDecoration (
  //                   border: Border.all(color: Color(0xfff9aa33)),
  //                   color: Color(0xff545454),
  //                   borderRadius: BorderRadius.circular(20*fem),
  //                 ),
  //                 child: Text(
  //                   'Email',
  //                   textAlign: TextAlign.center,
  //                   style: SafeGoogleFont (
  //                     'Poppins',
  //                     fontSize: 16*ffem,
  //                     fontWeight: FontWeight.w400,
  //                     height: 1.5*ffem/fem,
  //                     color: Color(0xffffffff),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //               // component42KQz (115:336)
  //               left: 31*fem,
  //               top: 423*fem,
  //               child: Container(
  //                 padding: EdgeInsets.fromLTRB(29*fem, 10*fem, 29*fem, 11*fem),
  //                 width: 300*fem,
  //                 height: 45*fem,
  //                 decoration: BoxDecoration (
  //                   border: Border.all(color: Color(0xfff9aa33)),
  //                   color: Color(0xff545454),
  //                   borderRadius: BorderRadius.circular(20*fem),
  //                 ),
  //                 child: Text(
  //                   'Password',
  //                   textAlign: TextAlign.center,
  //                   style: SafeGoogleFont (
  //                     'Poppins',
  //                     fontSize: 16*ffem,
  //                     fontWeight: FontWeight.w400,
  //                     height: 1.5*ffem/fem,
  //                     color: Color(0xffffffff),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //
  //
  //
  //
  //
  //             Positioned(
  //               // forgotpasswordn3g (1:220)
  //               left: 205*fem,
  //               top: 479*fem,
  //               child: Align(
  //                 child: SizedBox(
  //                   width: 118*fem,
  //                   height: 20*fem,
  //                   child: Text(
  //                     'Forgot Password ?',
  //                     textAlign: TextAlign.center,
  //                     style: SafeGoogleFont (
  //                       'Poppins',
  //                       fontSize: 13*ffem,
  //                       fontWeight: FontWeight.w400,
  //                       height: 1.5*ffem/fem,
  //                       color: Color(0xffffffff),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //               // signupGjY (1:216)
  //               left: 135*fem,
  //               top: 125*fem,
  //               child: Align(
  //                 child: SizedBox(
  //                   width: 91*fem,
  //                   height: 36*fem,
  //                   child: Text(
  //                     'Sign Up',
  //                     textAlign: TextAlign.center,
  //                     style: SafeGoogleFont (
  //                       'Poppins',
  //                       fontSize: 24*ffem,
  //                       fontWeight: FontWeight.w400,
  //                       height: 1.5*ffem/fem,
  //                       color: Color(0xffffffff),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //               // fieyeoffApv (1:217)
  //               left: 289*fem,
  //               top: 433*fem,
  //               child: Align(
  //                 child: SizedBox(
  //                   width: 24*fem,
  //                   height: 24*fem,
  //                   child: Image.asset(
  //                     'assets/page-1/images/fi-eye-off-SC6.png',
  //                     width: 24*fem,
  //                     height: 24*fem,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //               // component44g2a (122:288)
  //               left: 31*fem,
  //               top: 258*fem,
  //               child: Container(
  //                 padding: EdgeInsets.fromLTRB(31*fem, 10*fem, 31*fem, 11*fem),
  //                 width: 300*fem,
  //                 height: 45*fem,
  //                 decoration: BoxDecoration (
  //                   border: Border.all(color: Color(0xfff9aa33)),
  //                   color: Color(0xff545454),
  //                   borderRadius: BorderRadius.circular(20*fem),
  //                 ),
  //                 child: Text(
  //                   'Contact',
  //                   textAlign: TextAlign.center,
  //                   style: SafeGoogleFont (
  //                     'Poppins',
  //                     fontSize: 16*ffem,
  //                     fontWeight: FontWeight.w400,
  //                     height: 1.5*ffem/fem,
  //                     color: Color(0xffffffff),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
*/

}
