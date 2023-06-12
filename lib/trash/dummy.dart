import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebae_reg_auth/profiling_module/utils.dart';

class Scene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // loginfUA (119:251)
        padding: EdgeInsets.fromLTRB(34*fem, 125*fem, 26*fem, 231*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          gradient: LinearGradient (
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: <Color>[Color(0xff000000), Color(0xff000000)],
            stops: <double>[0.047, 0.902],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // loginutJ (119:257)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 8*fem, 137*fem),
              child: Text(
                'Login',
                textAlign: TextAlign.center,
                style: SafeGoogleFont (
                  'Poppins',
                  fontSize: 24*ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.5*ffem/fem,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            Container(
              // autogroup7sycR5x (JtxK8LByE42xgzAZwb7SyC)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 35*fem),
              width: double.infinity,
              height: 45*fem,
              child: Container(
                // component45A3Y (403:200)
                padding: EdgeInsets.fromLTRB(17*fem, 10*fem, 150*fem, 10*fem),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration (
                  border: Border.all(color: Color(0xfff9aa33)),
                  color: Color(0xff545454),
                  borderRadius: BorderRadius.circular(20*fem),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // vectorToL (403:207)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 17*fem, 0*fem),
                      width: 33*fem,
                      height: 25*fem,
                      child: Image.asset(
                        'assets/page-1/images/vector-Cyc.png',
                        width: 33*fem,
                        height: 25*fem,
                      ),
                    ),
                    Container(
                      // usernameasx (403:203)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1*fem),
                      child: Text(
                        'Username',
                        style: SafeGoogleFont (
                          'Poppins',
                          fontSize: 16*ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.5*ffem/fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              // component846rJ (403:208)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 9*fem),
              padding: EdgeInsets.fromLTRB(20*fem, 7*fem, 26*fem, 8*fem),
              width: double.infinity,
              decoration: BoxDecoration (
                border: Border.all(color: Color(0xfff9aa33)),
                color: Color(0xff545454),
                borderRadius: BorderRadius.circular(20*fem),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // vectorNJ2 (403:212)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 17*fem, 0*fem),
                    width: 30*fem,
                    height: 30*fem,
                    child: Image.asset(
                      'assets/page-1/images/vector-t9C.png',
                      width: 30*fem,
                      height: 30*fem,
                    ),
                  ),
                  Container(
                    // passwordgpW (403:211)
                    margin: EdgeInsets.fromLTRB(0*fem, 4*fem, 103*fem, 0*fem),
                    child: Text(
                      'Password ',
                      style: SafeGoogleFont (
                        'Poppins',
                        fontSize: 16*ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.5*ffem/fem,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  Container(
                    // fieyeoffQEi (119:258)
                    width: 22*fem,
                    height: 22*fem,
                    child: Image.asset(
                      'assets/page-1/images/fi-eye-off.png',
                      width: 22*fem,
                      height: 22*fem,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // forgotpasswordL8N (119:256)
              margin: EdgeInsets.fromLTRB(170*fem, 0*fem, 0*fem, 41*fem),
              child: Text(
                'Forgot Password ?',
                textAlign: TextAlign.center,
                style: SafeGoogleFont (
                  'Poppins',
                  fontSize: 13*ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.5*ffem/fem,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            Container(
              // component433Ya (119:252)
              margin: EdgeInsets.fromLTRB(25*fem, 0*fem, 24*fem, 16*fem),
              width: double.infinity,
              height: 45*fem,
              decoration: BoxDecoration (
                color: Color(0xfff9aa33),
                borderRadius: BorderRadius.circular(20*fem),
              ),
              child: Center(
                child: Text(
                  'login',
                  textAlign: TextAlign.center,
                  style: SafeGoogleFont (
                    'Poppins',
                    fontSize: 16*ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.5*ffem/fem,
                    color: Color(0xff000000),
                  ),
                ),
              ),
            ),
            Container(
              // donothaveanaccountsignupht2 (119:259)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 12*fem, 0*fem),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: SafeGoogleFont (
                    'Poppins',
                    fontSize: 10*ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.5*ffem/fem,
                    color: Color(0xffffffff),
                  ),
                  children: [
                    TextSpan(
                      text: 'Do not have an account?',
                    ),
                    TextSpan(
                      text: ' sign up',
                      style: SafeGoogleFont (
                        'Poppins',
                        fontSize: 10*ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.5*ffem/fem,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}