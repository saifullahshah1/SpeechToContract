import 'package:firebae_reg_auth/main.dart';
import 'package:flutter/material.dart';

import '../contract_module/contract.dart';
import '../profiling_module/userProfile_page.dart';

import 'package:firebae_reg_auth/profiling_module/utils.dart';

class Gallery extends StatefulWidget {
  static const String id = 'gallery_screen';
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  void navToUserProfile() {
    Navigator.pushNamed(context, UserProfile.id);
  }

  void navToContract() {
    Navigator.pushNamed(context, Contract.id);
  }

  void navBackToPrevScreen(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          // title: const Text('Gallery'),
          title: Text(
            // profilegE4 (110:120)
            'Gallery',
            style: SafeGoogleFont (
              'Poppins',
              fontSize: 20*ffem,
              fontWeight: FontWeight.w400,
              height: 1.5*ffem/fem,
              color: Color(0xffffffff),
            ),
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
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
          child: ListView.builder(
            itemCount: 20,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: GestureDetector(
                  onTap: navToContract,
                  child: Container(
                    height: 100,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white70)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.calendar_month, color: Colors.orange, size: 18),
                            SizedBox(width: 5),
                            Text(
                              '8-06-2022',

                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'ID $index',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 7),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Rental Agreement',
                              style: TextStyle(color: Colors.tealAccent),
                            ),
                            Text('{PDF}')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
