// import 'package:flutter/material.dart';
//
// import 'profiling_module/userProfile_page.dart';
// import 'trash/userProfile.dart';
//
// class ContractRequest extends StatefulWidget {
//   static const String id = 'contract_request_screen';
//   const ContractRequest({Key? key}) : super(key: key);
//
//   @override
//   State<ContractRequest> createState() => _ContractRequestState();
// }
//
// class _ContractRequestState extends State<ContractRequest> {
//
//   void navToUserProfile() {
//     Navigator.pushNamed(context, UserProfile.id);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text("Contract Requests",style: TextStyle(fontSize: 25.0),),
//         centerTitle: true,
//         backgroundColor: Color(0xFFF9AA33),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(30),
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: navToUserProfile,
//             icon: Image.asset('images/profile_icon.jpg',
//                 width: 60, height: 60),
//             padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
//           ),
//         ],
//       ),
//       body: Column(
//           children: [
//
//             InkWell(
//               child: Container(
//                 height: 125.00,
//                 child:  Image(image: AssetImage("images/contract_card_icon.png")),),
//             ),
//             InkWell(
//               child: Container(
//                 height: 125.00,
//                 child:  Image(image: AssetImage("images/contract_card_icon.png")),),
//             ),
//           ]),
//     );
//   }
// }
