import 'package:firebae_reg_auth/contract_creation_module/sign_contract.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'contact_module/contract_request_page.dart';
import 'contact_module/contractRenewal.dart';
import 'contact_module/dashboard_page.dart';
import 'contact_module/gallery.dart';
import 'contract_creation_module/create_contract_page.dart';
import 'firebase_options.dart';

import 'auth_module/loginScreen.dart';
import 'profiling_module/userProfile_page.dart';
import 'auth_module/register.dart';
import 'trash/dashboardScreen.dart';
import 'trash/userProfile.dart';
import 'trash/gallery.dart';
import 'contract_module/contract.dart';
import 'trash/Contacts.dart';
import 'contract_typeSelection.dart';
import 'call_module/callPage.dart';
import 'previewContract.dart';
import 'trash/contractRequest.dart';
import 'createContact.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Main());
}

class Main extends StatefulWidget {
  static const String id = "main_page";
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speech2Contract',
      initialRoute: LoginScreen.id,
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        Register.id: (context) => Register(),
        // DashBoard.id: (context) => DashBoard(),
        DashboardPage.id : (context) => DashboardPage(),
        UserProfile.id: (context) => UserProfile(),
        Gallery.id: (context) => Gallery(),
        Contract.id: (context) => Contract(),
        SignContract.id: (context) => SignContract(audioPath: "",callerName: "", callerNumber: "02222222222", callerEmail: "" ,calleeName: "", calleeNumber: "03333333333", calleeEmail: ""),
        // Contacts.id: (context) => Contacts(),
        CallInvitationPage.id : (context) => CallInvitationPage(recordingOn: false, otherPersonNumber: '03333333333', yourUserID: '02222222222',),
        CreateContact.id: (context) => CreateContact(),
        ContractRequest.id: (context) => ContractRequest(),
        ContractRenewal.id: (context) => ContractRenewal(),
        CreateContract.id: (context) => CreateContract(showPlayer: false,audioPath: "",callerName: "", callerNumber: "02222222222", callerEmail: "",  calleeName: "", calleeNumber: "03333333333",calleeEmail: "",),
        ContractTypeSelection.id: (context) => ContractTypeSelection(),
        PreviewContract.id: (context) => PreviewContract(),
        // Home.id : (context) => Home(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const String id = 'home_screen';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void navToRegisterScreen() {
    Navigator.pushNamed(context, Register.id);
  }

  void navToLoginScreen() {
    Navigator.pushNamed(context, LoginScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ElevatedButton(onPressed: navToRegisterScreen, child: Text("SignUp")),
        ElevatedButton(onPressed: navToLoginScreen, child: Text("LogIn")),
      ],
    ));
  }
}
