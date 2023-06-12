import 'package:flutter/material.dart';

import '../profiling_module/userProfile_page.dart';
import '../trash/userProfile.dart';

import 'package:firebae_reg_auth/profiling_module/utils.dart';


class Contract extends StatefulWidget {
  static const String id = 'contract_screen';
  const Contract({Key? key}) : super(key: key);

  @override
  State<Contract> createState() => _ContractState();
}

class _ContractState extends State<Contract> {
  void navToUserProfile() {
    Navigator.pushNamed(context, UserProfile.id);
  }

  void navBackToPrevScreen(){
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {

    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;

    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;


    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          // appBar: AppBar(
          //   title: Text("Contract",style: TextStyle(fontSize: 25.0),),
          //   centerTitle: true,
          //   backgroundColor: Color(0xFFF9AA33),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.vertical(
          //       bottom: Radius.circular(30),
          //     ),
          //   ),
          //   actions: [
          //     IconButton(
          //       onPressed: navToUserProfile,
          //       icon: Image.asset('images/profile_icon.jpg',
          //           width: 60, height: 60),
          //       padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
          //     ),
          //   ],
          // ),

          appBar: AppBar(
            // title: const Text('Dashboard'),
            title: Text(
              // profilegE4 (110:120)
              'Contract',
              style: SafeGoogleFont (
                'Poppins',
                fontSize: 22*ffem,
                fontWeight: FontWeight.w400,
                height: 1.5*ffem/fem,
                color: Color(0xffffffff),
              ),
            ),
            titleTextStyle: TextStyle(
              fontSize: 20,
            ),
            backgroundColor: Colors.black,
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
            actions: [
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 20 * fem, 0 * fem),
                child: GestureDetector(
                  onTap: navToUserProfile,
                  child: Image.asset(
                    'assets/page-1/images/profile.png',
                  ),
                ),
              ),

/*
          // Container(
          //   // component75hFn (208:127)
          //   margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 25 * fem, 0 * fem),
          //   padding:
          //       EdgeInsets.fromLTRB(15 * fem, 15 * fem, 15 * fem, 15 * fem),
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

              // IconButton(
              //   onPressed: () {navToUserProfile();},
              //   // icon: const Icon(
              //   //   Icons.person,
              //   //   size: 30,
              //   // ),
              //   icon: Image.asset('images/profile.png',
              //       width: 160, height: 160),
              //   padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              // ),
              // const SizedBox(width: 10),
            ],
          ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Center(
          child: InkWell(
            child: Container(
              width: 280.00,
              child:  Image(image: AssetImage("images/contract_icon.png")),),
          ),
        ),
      ]),
    ));
  }
}
