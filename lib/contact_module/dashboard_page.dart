import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../call_module/callPage.dart';
import '../profiling_module/userProfile_page.dart';
import 'contract_request_page.dart';
import 'contractRenewal.dart';
import 'gallery.dart';

import 'package:firebae_reg_auth/profiling_module/utils.dart';


class DashboardPage extends StatefulWidget {
  static const String id = 'dashboard_screen';
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _auth = FirebaseAuth.instance;
  late User loggedUser;

  final _firestore = FirebaseFirestore.instance;

  late List<dynamic> _challenges;
  late List<String?> _contactNames;
  late Map<String, dynamic>? _docOfUser;
  late String _yourUserID;
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    getLoggedUser();
    getUserData();
    getContactsNames();
  }

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
    await for (var snapshot in _firestore.collection('users').snapshots()) {
      for (var message in snapshot.docs) {
        if (message.data()['email'] == loggedUser.email) {
          // print(message.data()['contact_book']);
          setState(() {
            _docOfUser = message.data();
            _challenges = message.data()['contact_book'];
            _yourUserID = message.data()['number'];
          });
          print(_challenges);
        }
      }
    }
  }

  void getContactsNames() async {
    for (var contact in _challenges) {
      await _firestore
          .collection('users')
          .where("number", isEqualTo: contact.text)
          .get()
          .then((value) {
        setState(() {
          _contactNames.add(value.docs[0].data()['name']);
        });
      });
    }
    print("=>>>>>>>>>>>>>>>.");
    print(_contactNames);
  }

  void signoutFtn() async {
    await _auth.signOut();
    print("Logging Out");
    Navigator.pop(context);
  }

  void navToUserProfile() {
    Navigator.pushNamed(context, UserProfile.id);
  }

  void navToContractRenewal() {
    Navigator.pushNamed(context, ContractRenewal.id);
  }

  void navToContractRequest() {
    Navigator.pushNamed(context, ContractRequest.id);
  }

  void navToGallery() {
    Navigator.pushNamed(context, Gallery.id);
  }

  void navToCallPage(String otherPersonNumber, String yourUserID) {
    // Navigator.pushNamed(context, CallInvitationPage.id);
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => CallInvitationPage(
                  recordingOn: false,
                  otherPersonNumber: otherPersonNumber,
                  yourUserID: yourUserID,
                )));
  }

  @override
  Widget build(BuildContext context) {

    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;

    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // title: const Text('Dashboard'),
        title: Text(
          // profilegE4 (110:120)
          'Dashboard',
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
            onTap: signoutFtn,
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 140,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child:
                          // Tab(
                          //   icon: Image.asset( //        <-- Image
                          //     'assets/page-1/images/gallery.png',
                          //     // height: 44,
                          //     // fit: BoxFit.cover,
                          //   ),
                          // ),
                          IconButton(
                            onPressed: () {
                              navToGallery();
                            },
                            icon: const Icon(
                              Icons.folder,
                              color: Colors.orange,
                              size: 30,
                            ),
                          ),
                        ),
                        Container(
                          width: 2,
                          color: Colors.white,
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: GestureDetector(
                              onTap: navToGallery,
                              child: Text(
                                'Gallery',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 140,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: IconButton(
                            onPressed: () {navToContractRequest();},
                            icon: const Icon(
                              // Icons.request_quote,
                              Icons.file_open_rounded,
                              color: Colors.blue,
                              size: 30,
                            ),
                          ),
                        ),
                        Container(
                          width: 2,
                          color: Colors.white,
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: GestureDetector(
                              onTap: navToContractRequest,
                              child: Text(
                                'Contract Request',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 140,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: IconButton(
                            onPressed: () {
                              navToContractRenewal();
                            },
                            icon: const Icon(
                              // Icons.autorenew,
                              Icons.restore_page_rounded,
                              color: Colors.green,
                              size: 30,
                            ),
                          ),
                        ),
                        Container(
                          width: 2,
                          color: Colors.white,
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: GestureDetector(
                              onTap: navToContractRenewal,
                              child: Text(
                                'Contract Renewal',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'My Contacts',
              style: TextStyle(color: Colors.grey, fontSize: 25),

              // Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                // itemCount: 2, /// change this with contact list height
                itemCount: _challenges.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () {
                        /// navigate to the contact screen here
                        /// get the user details using the contact list and index
                        log('Contact $index Tapped');
                      },
                      child: Container(
                        height: 80,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  child: Image.asset('images/avatar.png'),
                                  backgroundColor: Colors.grey.shade700,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Text('Aaron',
                                    Text('Kamran',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                    const SizedBox(height: 5),
                                    Text(
                                      _challenges?[index],
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  navToCallPage(
                                      _challenges?[index], _yourUserID);
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 16,
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
