import 'dart:developer';
import 'dart:math' as math;
import 'dart:async';
// Flutter imports:
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebae_reg_auth/createContract.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:flutter/foundation.dart';
import '../contract_creation_module/create_contract_page.dart';
import '../contract_creation_module/audio_player.dart';
// Package imports:
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import '../profiling_module/userProfile_page.dart';
import '../profiling_module/utils.dart';
import 'audio_recorder.dart';
// import 'dummy.dart';
import '../trash/show_audio.dart';
// import 'main.dart';

/// Note that the userID needs to be globally unique,
// final String localUserID = math.Random().nextInt(10000).toString();

// final String localUserID = "03135153425";

// late String iddd;
// final String localUserID = "03123456789";
// final String localUserID = "03350501183";

late String callerNameDummy = "dummy";
late String calleeNameDummy ="dummy";
late String otherPersonNumberDummy = "dummy";
late String yourUserIDDummy = "dummy";
late String callerEmailDummy = "dummy";
late String calleeEmailDummy ="dummy";

class RecordingStarter extends StatefulWidget {
  bool recordingOn = false;
  bool showPlayer = false;
  String? Audiopath;
  RecordingStarter({Key? key, required recordingOn, required showPlayer, required Audiopath }) : super(key: key);

  @override
  State<RecordingStarter> createState() => _RecordingStarterState();
}

class _RecordingStarterState extends State<RecordingStarter> {

  // void navToShowAudio() {
  //   // Navigator.pushNamed(context,ShowAudio.id);
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ShowAudio(showPlayer: widget.showPlayer, audioPath: widget.Audiopath,),
  //     ),
  //   );
  // }

  void navToShowAudio() {
    // Navigator.pushNamed(context,ShowAudio.id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateContract(showPlayer: widget.showPlayer, audioPath: widget.Audiopath,
          callerName: callerNameDummy, callerNumber: yourUserIDDummy, callerEmail: callerEmailDummy ,
          calleeName: calleeNameDummy, calleeNumber: otherPersonNumberDummy, calleeEmail: callerEmailDummy,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AudioRecorder(
        onStop: (path) {
          if (kDebugMode) print('Recorded file path: $path');
          setState(() {
            widget.Audiopath = path;
            widget.showPlayer = true;
            widget.recordingOn = false;
          });
          navToShowAudio();
        },
      ),
    );
  }
}


class CallInvitationPage extends StatefulWidget {
  static const String id = "call_page";
  bool recordingOn;
String otherPersonNumber;
String yourUserID;
  CallInvitationPage({Key? key, required this.recordingOn, required this.otherPersonNumber, required this.yourUserID}) : super(key: key);

  @override
  State<CallInvitationPage> createState() => _CallInvitationPageState();
}

class _CallInvitationPageState extends State<CallInvitationPage> {

  bool showPlayer = false;
  String? Audiopath;
  final TextEditingController inviteeUsersIDTextCtrl = TextEditingController();

  bool _callEnded = false;

  int _recordDuration = 0;
  Timer? _timer;
  final _audioRecorder = Record();
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Amplitude? _amplitude;

  final _auth = FirebaseAuth.instance;
  late User loggedUser;
  final _firestore = FirebaseFirestore.instance;
  // late String? _challenges;
  late List<String?> _contactNames;
  late Map<String, dynamic>? _docOfUser;
  late String callerName = "ccc";
  late String calleeName ="xxx";
  late String callerEmail = "@@@";
  late String calleeEmail ="@-@";

  @override
  void initState() {
    getLoggedUser();
    // getUserData();
    // getContactsNames();
    Audiopath = "";
    showPlayer = false;
    _callEnded = false;

    // iddd = _challenges! ;

    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      setState(() => _recordState = recordState);
    });
    _amplitudeSub = _audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) => setState(() => _amplitude = amp));


    getCallerCalleData();

    super.initState();
  }

  void getCallerCalleData() async {
    try{

      await for (var snapshot in _firestore.collection('users').snapshots()) {
          for (var message in snapshot.docs) {
            if (message.data()['number'] == widget.yourUserID) {
              setState(() {
                callerName = message.data()['name'];
                callerEmail = message.data()['email'];
              });
            }
            if (message.data()['number'] == widget.otherPersonNumber) {
              setState(() {
                calleeName = message.data()['name'];
                calleeEmail = message.data()['email'];
              });
            }
          }
        }
    } catch (e) {
      print(e);
    }
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

  // void getUserData() async {
  //   await for (var snapshot in _firestore.collection('users').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       if (message.data()['email'] == loggedUser.email) {
  //         // print(message.data()['contact_book']);
  //         setState(() {
  //           _docOfUser = message.data();
  //           _challenges = message.data()['number'];
  //         });
  //         print(_challenges);
  //       }
  //     }
  //   }
  //
  // }

  // void getContactsNames() async{
  //
  //   for(var contact in _challenges)
  //   {
  //     await _firestore.collection('users').where("number", isEqualTo: contact.text).get().then((value) {
  //       setState(() {
  //         _contactNames.add(value.docs[0].data()['name']);
  //       });
  //     });
  //   }
  //   print("=>>>>>>>>>>>>>>>.");
  //   print(_contactNames);
  //
  // }


  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        final isSupported = await _audioRecorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );
        if (kDebugMode) {
          print('${AudioEncoder.aacLc.name} supported: $isSupported');
        }
        // final tempDir = await getTemporaryDirectory();
        final tempDir = await getExternalStorageDirectory();
        print(tempDir?.path);
        Audiopath = '${tempDir?.path}/temp_recording.mp3';


        // final devs = await _audioRecorder.listInputDevices();
        // final isRecording = await _audioRecorder.isRecording();

        await _audioRecorder.start(
          path: Audiopath,
        );
        _recordDuration = 0;

        _startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();
    _recordDuration = 0;

    final path = await _audioRecorder.stop();

    if (path != null) {
      // widget.onStop(path);
      if (kDebugMode) print('Recorded file path: $Audiopath');
      setState(() {
        // Audiopath = path;
        showPlayer = true;
        widget.recordingOn = false;
      });

      print("===>>>>>>>>>>>>>>>>>>");
      print(callerName);
      print(widget.yourUserID);
      print(callerEmail);
      print("===>>>>>>>>>>>>>>>>>>");
      print(calleeName);
      print(widget.otherPersonNumber);
      print(calleeEmail);

      callerNameDummy = callerName;
      calleeNameDummy = calleeName;
      otherPersonNumberDummy = widget.otherPersonNumber;
      yourUserIDDummy = widget.yourUserID;
      callerEmailDummy = callerEmail;
      calleeEmailDummy = calleeEmail;

      navToShowAudio();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    _amplitudeSub?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  @override
  Widget build(BuildContext context) {

    // if(_callEnded == true){
    //   navToShowAudio();
    // }

    return ZegoUIKitPrebuiltCallWithInvitation(
      appID: 1407480931,
      appSign: "93493cd126b97b85e5df6df7a5c9b7cfbbb1fbbd854d1a9ee0bb5a70d71dfe09",
      userID: widget.yourUserID,
      userName: "user_${widget.yourUserID}",
      plugins: [ZegoUIKitSignalingPlugin()],
      child: yourPage(context),

      requireConfig: (ZegoCallInvitationData invitationData) {
        return ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
          ..onHangUp = (){
            print('HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH');
            // setState(() {
            // _callEnded = true;
            // });
            _stop();
          };
      },
    );
  }

  void navToUserProfile() {
    Navigator.pushNamed(context, UserProfile.id);
  }

  void navBackToPrevScreen(){
    Navigator.pop(context);
  }


  Widget yourPage(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      appBar: AppBar(
        // title: const Text('Voice Call'),
        title: Text(
          // profilegE4 (110:120)
          'Voice Call',
          style: SafeGoogleFont (
            'Poppins',
            fontSize: 22*ffem,
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
          Container(
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 20 * fem, 0 * fem),
            child: GestureDetector(
              onTap: navToUserProfile,
              child: Image.asset(
                'assets/page-1/images/profile.png',
              ),
            ),
          ),
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
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0*fem,horizontal: 20.0*fem),
                child: Container(
                  height: 250*fem,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(20*fem),
                    border: Border.all(color: Color(0xff156f1e)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('My Number:'),
                      SizedBox(height: 10.0,),
                      FittedBox(
                        child: Text(
                          widget.yourUserID,
                          style: SafeGoogleFont (
                            'Poppins',
                            fontSize: 18*ffem,
                            fontWeight: FontWeight.w400,
                            height: 1*ffem/fem,
                            color: Color(0xff2b2b2b),
                          ),

                        ),
                      ),
                      Container(
                        // line21SeU (204:80)
                        margin: EdgeInsets.fromLTRB(40*fem, 0*fem, 40*fem, 5*fem),
                        height: 3*fem,
                        color: Color(0xff555558),

                      ),
                      SizedBox(height: 20.0,),
                      Text("Other Person's Number:"),
                      SizedBox(height: 10.0,),
                      FittedBox(
                        child: Text(
                          widget.otherPersonNumber,
                          style: SafeGoogleFont (
                            'Poppins',
                            fontSize: 18*ffem,
                            fontWeight: FontWeight.w400,
                            height: 1*ffem/fem,
                            color: Color(0xff2b2b2b),
                          ),

                        ),
                      ),
                      Container(
                        // line21SeU (204:80)
                        margin: EdgeInsets.fromLTRB(40*fem, 0*fem, 40*fem, 5*fem),
                        height: 3*fem,
                        color: Color(0xff555558),

                      ),
                      SizedBox(height: 20.0,),
                      callButton(false),
                    ],
                  ),
                )
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navToShowAudio() {
    print(
        'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHeeeeeeeeeeeeeeeeeeeeeeeeeee');
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // add your code here.

      Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) =>
                CreateContract(
                  showPlayer: showPlayer, audioPath: Audiopath,
                  callerName: callerName, callerNumber: widget.yourUserID, callerEmail: callerEmail ,
                calleeName: calleeName, calleeNumber: widget.otherPersonNumber,calleeEmail: calleeEmail),));
    });
  }


  //   void navToShowAudio() {
  //
  //   print('HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHeeeeeeeeeeeeeeeeeeeeeeeeeee');
  //   SchedulerBinding.instance.addPostFrameCallback((_) {
  //
  //     // add your code here.
  //
  //     Navigator.push(
  //         context,
  //         new MaterialPageRoute(
  //           builder: (context) => ShowAudio(showPlayer: showPlayer, audioPath: Audiopath,),));
  //   });
  //
  //
  //   // Navigator.push(
  //   //   context,
  //   //   MaterialPageRoute(
  //   //     builder: (context) => ShowAudio(showPlayer: showPlayer, audioPath: Audiopath,),
  //   //   ),
  //   // );
  // }
/**/
  // Widget inviteeUserIDInput() {
  //   return Expanded(
  //     child: TextFormField(
  //       controller: inviteeUsersIDTextCtrl,
  //       inputFormatters: [
  //         FilteringTextInputFormatter.allow(RegExp('[0-9,]')),
  //       ],
  //       decoration: const InputDecoration(
  //         isDense: true,
  //         hintText: "Please Enter Invitees ID",
  //         labelText: "Invitees ID, Separate ids by ','",
  //       ),
  //     ),
  //   );
  // }

  Widget callButton(bool isVideoCall) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: inviteeUsersIDTextCtrl,
      builder: (context, inviteeUserID, _) {
        // var invitees = getInvitesFromTextCtrl(inviteeUsersIDTextCtrl.text);
        var invitees = getInvitesFromTextCtrl(widget.otherPersonNumber);
        return ZegoStartCallInvitationButton(
          isVideoCall: isVideoCall,
          invitees: invitees,
          iconSize: const Size(50, 50),
          buttonSize: const Size(60, 60),
          onPressed: (String code, String message, List<String> errorInvitees) {

            _start();
            if (errorInvitees.isNotEmpty) {
              String userIDs = "";
              for (int index = 0; index < errorInvitees.length; index++) {
                if (index >= 5) {
                  userIDs += '... ';
                  break;
                }

                var userID = errorInvitees.elementAt(index);
                userIDs += userID + ' ';
              }
              if (userIDs.isNotEmpty) {
                userIDs = userIDs.substring(0, userIDs.length - 1);
              }

              var message = 'User doesn\'t exist or is offline: $userIDs';
              if (code.isNotEmpty) {
                message += ', code: $code, message:$message';
              }
              showToast(
                message,
                position: StyledToastPosition.top,
                context: context,
              );
            } else if (code.isNotEmpty) {
              showToast(
                'code: $code, message:$message',
                position: StyledToastPosition.top,
                context: context,
              );
            }

          },
        );
      },
    );
  }

  List<ZegoUIKitUser> getInvitesFromTextCtrl(String textCtrlText) {
    List<ZegoUIKitUser> invitees = [];
    // var inviteeIDs = textCtrlText.trim().replaceAll('，', '');
    // inviteeIDs.split(",").forEach((inviteeUserID) {
    //   if (inviteeUserID.isEmpty) {
    //     return;
    //   }
    //
    //   invitees.add(ZegoUIKitUser(
    //     id: inviteeUserID,
    //     name: 'user_$inviteeUserID',
    //   ));
    // });

    invitees.add(ZegoUIKitUser(
      id: textCtrlText,
      name: 'user_$textCtrlText',
    ));

    return invitees;
  }


}
