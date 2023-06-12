import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'utils.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile extends StatefulWidget {
  static const String id = "user_profile_screen";

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User loggedUser;
  String? name = 'Username';
  String? phno = 'Phone Number';
  String? email = 'Email';

  void getLoggedUser() async {
    try {
      final checkLoggedUser = await _auth.currentUser;
      if (checkLoggedUser != null) {
        loggedUser = checkLoggedUser;
        print("Current User: ");
        print(loggedUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void getUserData() async {
    await for (var snapshot in _firestore.collection('users').snapshots()){
      for(var message in snapshot.docs){
        if(message.data()['email'] == loggedUser.email)
        {
          print(message.data()['email'] + "  " + message.data()['name'] + "   " + message.data()['number']);
          setState((){
            name = message.data()['name'];
            email = message.data()['email'];
            phno = message.data()['number'];
          });
        }
      }
    }
  }

  void navBackToPrevScreen(){
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    getLoggedUser();
    // _getdata();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;
    double baseWidth = 360;
    double fem = screenWidth / baseWidth;
    double ffem = fem * 0.97;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff000000),
          title: Text(
            // profilegE4 (110:120)
            'Profile',
            style: SafeGoogleFont (
              'Poppins',
              fontSize: 24*ffem,
              fontWeight: FontWeight.w400,
              height: 1.5*ffem/fem,
              color: Color(0xffffffff),
            ),
          ),
            // leading: Container(
            //   // vectorwnG (110:124)
            //   margin: EdgeInsets.fromLTRB(15*fem, 15*fem, 15*fem, 15*fem),
            //   width: 25*fem,
            //   height: 25*fem,
            //   child: GestureDetector(
            //     onTap: navBackToPrevScreen,
            //     child: Image.asset(
            //       'assets/page-1/images/arroww.png',
            //       width: 25*fem,
            //       height: 25*fem,
            //     ),
            //   ),
            // ),
          leading: Container(
            // vectorA9n (204:122)
            margin: EdgeInsets.fromLTRB(15*fem, 0*fem, 0*fem, 0*fem),
            width: 25*fem,
            height: 25*fem,
            child: GestureDetector(
              onTap: navBackToPrevScreen,
              child: Image.asset(
                'assets/page-1/images/arroww.png',
                width: 25*fem,
                height: 25*fem,
              ),
            ),
          ),
        ),
        body: Container(
            width: screenWidth,
            color: Color(0xff000000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(38*ffem, 30*ffem, 38*ffem, 30*ffem),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(80*fem, 0*fem, 80*fem, 40*fem),
                        padding: EdgeInsets.fromLTRB(33.75*fem, 38.75*fem, 7.5*fem, 0*fem),
                        width: double.infinity,
                        height: 125*fem,
                        decoration: BoxDecoration (
                          color: Color(0xff191a1c),
                          borderRadius: BorderRadius.circular(62.5*fem),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // vector1fe (121:553)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 27.5*fem, 18.75*fem),
                              width: 56.25*fem,
                              height: 47.5*fem,
                              child: Image.asset(
                                'assets/page-1/images/vector-rhN.png',
                                width: 56.25*fem,
                                height: 47.5*fem,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        // autogroupuvreF4C (7LDwvG899X24tUDYkFuvRe)
                        margin: EdgeInsets.fromLTRB(6*fem, 0*fem, 0*fem, 8*fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // vectorAwr (204:97)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 24*fem, 0*fem),
                              width: 22*fem,
                              height: 22*fem,
                              child: Image.asset(
                                'assets/page-1/images/vector-j36.png',
                                width: 22*fem,
                                height: 22*fem,
                              ),
                            ),
                            Container(
                              width: screenWidth - 140*fem,
                              height : 18*fem,
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                child: Text(
                                  name!,
                                  style: SafeGoogleFont (
                                    'Poppins',
                                    fontSize: 18*ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1*ffem/fem,
                                    color: Color(0xff606062),
                                  ),

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // line21SeU (204:80)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 5*fem),
                        width: double.infinity,
                        height: 3*fem,
                        color: Color(0xff555558),

                      ),

                      Container(
                        // autogroupuvreF4C (7LDwvG899X24tUDYkFuvRe)
                        margin: EdgeInsets.fromLTRB(6*fem, 20*fem, 0*fem, 8*fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // vectorAwr (204:97)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 24*fem, 0*fem),
                              width: 22*fem,
                              height: 22*fem,
                              child: Image.asset(
                                'assets/page-1/images/auto-group-ayui.png',
                                width: 22*fem,
                                height: 22*fem,
                              ),
                            ),

                            Container(
                              width: screenWidth - 140*fem,
                              height : 18*fem,
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                child: Text(
                                  email!,
                                  style: SafeGoogleFont (
                                    'Poppins',
                                    fontSize: 18*ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1*ffem/fem,
                                    color: Color(0xff606062),
                                  ),

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // line21SeU (204:80)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 5*fem),
                        width: double.infinity,
                        height: 3*fem,
                        color: Color(0xff555558),

                      ),

                      Container(
                        // autogroupuvreF4C (7LDwvG899X24tUDYkFuvRe)
                        margin: EdgeInsets.fromLTRB(6*fem, 20*fem, 0*fem, 8*fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // vectorAwr (204:97)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 24*fem, 0*fem),
                              width: 22*fem,
                              height: 22*fem,
                              child: Image.asset(
                                'assets/page-1/images/vector-2pY.png',
                                width: 22*fem,
                                height: 22*fem,
                              ),
                            ),
                            Container(
                              width: screenWidth - 140*fem,
                              height : 18*fem,
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                child: Text(
                                  phno!,
                                  style: SafeGoogleFont (
                                    'Poppins',
                                    fontSize: 18*ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1*ffem/fem,
                                    color: Color(0xff606062),
                                  ),

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // line21SeU (204:80)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 5*fem),
                        width: double.infinity,
                        height: 3*fem,
                        color: Color(0xff555558),

                      ),

                      Container(
                        // rectangle39rn4 (121:676)
                        margin: EdgeInsets.fromLTRB(70*fem, 80*fem, 70*fem, 0*fem),
                        width: double.infinity,
                        height: 45*fem,
                        decoration: BoxDecoration (
                          border: Border.all(color: Colors.white),
                          color: Color(0xffff9b21),
                          borderRadius: BorderRadius.circular(90*fem),
                        ),
                        child: Center(
                          child: Text(
                            'Edit',
                            style: SafeGoogleFont (
                              'Poppins',
                              fontSize: 18*ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5*ffem/fem,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
              ),
      ),
    );
  }
}
