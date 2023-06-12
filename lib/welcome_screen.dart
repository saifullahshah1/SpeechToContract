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
        // welcomevbg (1:156)
        width: double.infinity,
        height: 800*fem,
        decoration: BoxDecoration (
          color: Color(0xff000000),
          gradient: LinearGradient (
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: <Color>[Color(0x330a0909), Color(0x338c8080), Color(0x330a0909)],
            stops: <double>[0, 0.193, 1],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              // rectangle5QFx (1:158)
              left: 28*fem,
              top: 353*fem,
              child: Align(
                child: SizedBox(
                  width: 309*fem,
                  height: 94*fem,
                  child: Container(
                    decoration: BoxDecoration (
                      borderRadius: BorderRadius.circular(30*fem),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // welcomeKdp (1:161)
              left: 97.5*fem,
              top: 211*fem,
              child: Align(
                child: SizedBox(
                  width: 166*fem,
                  height: 51*fem,
                  child: Text(
                    'WELCOME',
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont (
                      'Poppins',
                      fontSize: 34*ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.5*ffem/fem,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // speechtocontractDDQ (1:165)
              left: 53*fem,
              top: 486*fem,
              child: Align(
                child: SizedBox(
                  width: 262*fem,
                  height: 36*fem,
                  child: Text(
                    'SPEECH TO CONTRACT',
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
              ),
            ),
            Positioned(
              // component45h8a (123:290)
              left: 86*fem,
              top: 285*fem,
              child: Container(
                padding: EdgeInsets.fromLTRB(8*fem, 0*fem, 0*fem, 0*fem),
                width: 188*fem,
                height: 162*fem,
                decoration: BoxDecoration (
                  color: Color(0xff000000),
                ),
                child: Align(
                  // rectangle171QHt (1:166)
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 180*fem,
                    height: 162*fem,
                    child: Image.asset(
                      'assets/page-1/images/rectangle-17-1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}