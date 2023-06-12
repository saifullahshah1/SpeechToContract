import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'audio_player.dart';
import '../contract_typeSelection.dart';
import '../profiling_module/userProfile_page.dart';
import '../profiling_module/utils.dart';
import 'sign_contract.dart';

class CreateContract extends StatefulWidget {
  static const String id = "create_contract_page";

  bool showPlayer;
  String? audioPath;

  String? callerName;
  String? calleeName;
  String? callerNumber;
  String? calleeNumber;
  String? callerEmail;
  String? calleeEmail;

  CreateContract({Key? key, required this.showPlayer, required this.audioPath,
    required this.callerName, required this.callerNumber, required this.callerEmail,
    required this.calleeName, required this.calleeNumber, required this.calleeEmail,}) : super(key: key);



  @override
  State<CreateContract> createState() => _CreateContractState();
}

class _CreateContractState extends State<CreateContract> {


  void navBackToPrevScreen(){
    Navigator.pop(context);
  }

  void navToUserProfile() {
    Navigator.pushNamed(context, UserProfile.id);
  }

  // void navToContractTypeSelection() {
  //   Navigator.pushNamed(context, ContractTypeSelection.id);
  // }

  // void navToSignContract() {
  //   Navigator.pushNamed(context, SignContract.id);
  // }

  void navToSignContract() {
    // Navigator.pushNamed(context,ShowAudio.id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignContract(audioPath: widget.audioPath,
          callerName: widget.callerName, callerNumber: widget.callerNumber, callerEmail: widget.callerEmail,
          calleeName: widget.calleeName, calleeNumber: widget.calleeNumber, calleeEmail: widget.calleeEmail,
        ),
      ),
    );
  }


  void navBackToDashboard() {
    Navigator.popUntil(context, ModalRoute.withName('dashboard_screen'));
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(

      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Color(0xff000000),
      //   title: Text(
      //     // recordingMhi (110:45)
      //     'Recording',
      //     style: SafeGoogleFont (
      //       'Poppins',
      //       fontSize: 24*ffem,
      //       fontWeight: FontWeight.w400,
      //       height: 1.5*ffem/fem,
      //       color: Color(0xffffffff),
      //     ),
      //   ),
      //   leading: Container(
      //     // vectorbq2 (110:49)
      //     margin: EdgeInsets.fromLTRB(15*fem, 15*fem, 15*fem, 15*fem),
      //     width: 20*fem,
      //     height: 19*fem,
      //     child: GestureDetector(
      //       onTap: navBackToPrevScreen,
      //       child: Image.asset(
      //         'assets/page-1/images/vector-Pxk.png',
      //         width: 20*fem,
      //         height: 19*fem,
      //       ),
      //     ),
      //   ),
      //   actions: [
      //     Container(
      //       // component75hFn (208:127)
      //       margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 15*fem, 0*fem),
      //       padding: EdgeInsets.fromLTRB(15*fem, 15*fem, 15*fem, 15*fem),
      //       height: double.infinity,
      //       decoration: BoxDecoration (
      //         border: Border.all(color: Color(0xffffffff)),
      //         borderRadius: BorderRadius.circular(100*fem),
      //         gradient: LinearGradient (
      //           begin: Alignment(0, -1),
      //           end: Alignment(0, 1),
      //           colors: <Color>[Color(0xff1b1a1a), Color(0x00d9d9d9)],
      //           stops: <double>[0, 1],
      //         ),
      //       ),
      //       child: Center(
      //         // groupxSc (I208:127;141:269)
      //         child: SizedBox(
      //           width: 18.53*fem,
      //           height: 21.61*fem,
      //           child: GestureDetector(
      //             onTap: navToUserProfile,
      //             child: Image.asset(
      //               'assets/page-1/images/group-cyv.png',
      //               width: 18.53*fem,
      //               height: 21.61*fem,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),

        appBar: AppBar(
          // title: const Text('Contract Renewal'),

          title: Text(
            // profilegE4 (110:120)
            'Recording',
            style: SafeGoogleFont (
              'Poppins',
              fontSize: 20*ffem,
              fontWeight: FontWeight.w400,
              height: 1.5*ffem/fem,
              color: Color(0xffffffff),
            ),
          ),
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
          backgroundColor: Colors.black,
          actions: [
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(
            //     Icons.person,
            //     size: 30,
            //   ),
            // ),
            // const SizedBox(width: 10),

            /*
          // Container(
          //   // component75hFn (208:127)
          //   margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 25 * fem, 0 * fem),
          //   padding:
          //   EdgeInsets.fromLTRB(15 * fem, 15 * fem, 15 * fem, 15 * fem),
          //   height: double.infinity,
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Color(0xffffffff)),
          //     borderRadius: BorderRadius.circular(100 * fem),
          //     gradient: LinearGradient(
          //       begin: Alignment(0, -1),
          //       end: Alignment(0, 1),
          //       colors: <Color>[Color(0xff1b1a1a), Color(0x00d9d9d9)],
          //       stops: <double>[0, 1],
          //     ),
          //   ),
          //   child: Center(
          //     // groupxSc (I208:127;141:269)
          //     child: SizedBox(
          //       width: 18.53 * fem,
          //       height: 21.61 * fem,
          //       child: GestureDetector(
          //         onTap: navToUserProfile,
          //         child: Image.asset(
          //           'assets/page-1/images/group-cyv.png',
          //           width: 18.53 * fem,
          //           height: 21.61 * fem,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          */

            Container(
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 20 * fem, 0 * fem),
              child: GestureDetector(
                onTap: navToUserProfile,
                child: Image.asset(
                  'assets/page-1/images/profile.png',
                ),
              ),
            ),


          ],
        ),

      body: Container(
        padding: EdgeInsets.fromLTRB(30*fem, 30*fem, 30*fem, 35*fem),
        width: double.infinity,
        color: Color(0xff000000),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              // component78Gy6 (209:163)
              margin: EdgeInsets.fromLTRB(35*fem, 0*fem, 35*fem, 5*fem),
              width: double.infinity,
              height: 200*fem,
              child: SizedBox(
                width: 300*fem,
                height: 300*fem,
                child: Image.asset(
                  'assets/page-1/images/Component78.png',
                  width: 300*fem,
                  height: 300*fem,
                ),
              ),
              // Stack(
              //   children: [
              //     Positioned(
              //       // component38Pnp (209:161)
              //       left: 38*fem,
              //       top: 55*fem,
              //       child: Container(
              //         width: 124*fem,
              //         height: 107*fem,
              //         decoration: BoxDecoration (
              //           color: Color(0xff000000),
              //         ),
              //         child: Stack(
              //           children: [
              //             Positioned(
              //               // ellipse96hE (I209:161;3:652)
              //               left: 27*fem,
              //               top: 7*fem,
              //               child: Align(
              //                 child: SizedBox(
              //                   width: 70*fem,
              //                   height: 70*fem,
              //                   child: Container(
              //                     decoration: BoxDecoration (
              //                       borderRadius: BorderRadius.circular(35*fem),
              //                       color: Color(0xffa50000),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Positioned(
              //               // recBig (I209:161;3:645)
              //               left: 54.9040527344*fem,
              //               top: 34*fem,
              //               child: Align(
              //                 child: SizedBox(
              //                   width: 23*fem,
              //                   height: 18*fem,
              //                   child: Text(
              //                     'REC',
              //                     textAlign: TextAlign.center,
              //                     style: SafeGoogleFont (
              //                       'Poppins',
              //                       fontSize: 12*ffem,
              //                       fontWeight: FontWeight.w400,
              //                       height: 1.5*ffem/fem,
              //                       color: Color(0xffffffff),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Positioned(
              //               // ellipse8UBz (I209:161;3:646)
              //               left: 42*fem,
              //               top: 37*fem,
              //               child: Align(
              //                 child: SizedBox(
              //                   width: 10.02*fem,
              //                   height: 9.62*fem,
              //                   child: Image.asset(
              //                     'assets/page-1/images/ellipse-8.png',
              //                     width: 10.02*fem,
              //                     height: 9.62*fem,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //     Positioned(
              //       // ellipse14Ppk (209:132)
              //       left: 25*fem,
              //       top: 25*fem,
              //       child: Align(
              //         child: SizedBox(
              //           width: 150*fem,
              //           height: 150*fem,
              //           child: Container(
              //             decoration: BoxDecoration (
              //               borderRadius: BorderRadius.circular(75*fem),
              //               border: Border.all(color: Color(0x7fa50000)),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Positioned(
              //       // ellipse15HfE (209:162)
              //       left: 0*fem,
              //       top: 0*fem,
              //       child: Align(
              //         child: SizedBox(
              //           width: 200*fem,
              //           height: 200*fem,
              //           child: Image.asset(
              //             'assets/page-1/images/ellipse-15.png',
              //             width: 200*fem,
              //             height: 200*fem,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ),
            // Container(
            //   margin: EdgeInsets.fromLTRB(110*fem, 20*fem, 120*fem, 65*fem),
            //   width: double.infinity,
            //   height: 28*fem,
            //   child: Align(
            //     alignment: Alignment.center,
            //           child: SizedBox(
            //             width: 70*fem,
            //             height: 28*fem,
            //             child: Text(
            //               '3:25:00',
            //               style: SafeGoogleFont (
            //                 'Nunito',
            //                 fontSize: 20*ffem,
            //                 fontWeight: FontWeight.w400,
            //                 height: 1.3625*ffem/fem,
            //                 color: Color(0xffffffff),
            //               ),
            //             ),
            //           ),
            //         ),
            // ),
            Container(
              child: AudioPlayer(
              source: widget.audioPath!,
              // onDelete: () {
              //   setState(() => widget.showPlayer = false);
              //   // Navigator.pop(context, widget.showPlayer);
              //   // Navigator.popUntil(context, ModalRoute.withName('dashboard_screen'));
              // },
            ),),
            GestureDetector(
              // onTap: navToContractTypeSelection,
              onTap: navToSignContract,
              child: Container(
                // component77M2p (209:159)
                margin: EdgeInsets.fromLTRB(45*fem, 0*fem, 45*fem, 5*fem),
                width: double.infinity,
                height: 48*fem,
                decoration: BoxDecoration (
                  border: Border.all(color: Color(0xff156f1e)),
                  borderRadius: BorderRadius.circular(20*fem),
                ),
                child: Center(
                  child: Text(
                    'Create Contract',
                    style: SafeGoogleFont (
                      'Nunito',
                      fontSize: 20*ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.3625*ffem/fem,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(3*fem, 0*fem, 0*fem, 17*fem),
              child: Text(
                'or',
                style: SafeGoogleFont (
                  'Nunito',
                  fontSize: 20*ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.3625*ffem/fem,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            GestureDetector(
              onTap: navBackToDashboard,
              child: Container(
                // component76wmi (209:158)
                margin: EdgeInsets.fromLTRB(45*fem, 0*fem, 45*fem, 0*fem),
                width: double.infinity,
                height: 48*fem,
                decoration: BoxDecoration (
                  border: Border.all(color: Color(0xffe32424)),
                  borderRadius: BorderRadius.circular(20*fem),
                ),
                child: Center(
                  child: Text(
                    'Cancel Contract',
                    style: SafeGoogleFont (
                      'Nunito',
                      fontSize: 20*ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.3625*ffem/fem,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}