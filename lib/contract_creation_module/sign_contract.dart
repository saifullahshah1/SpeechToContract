import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';

import 'package:firebae_reg_auth/contact_module/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import '../profiling_module/userProfile_page.dart';
import 'mobile.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:firebae_reg_auth/profiling_module/utils.dart';

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

var filter;
var entities;
var text;


class SignContract extends StatefulWidget {
  static const String id = 'sign_contract';
  String? audioPath;

  String? callerName;
  String? calleeName;
  String? callerNumber;
  String? calleeNumber;
  String? callerEmail;
  String? calleeEmail;


  SignContract({Key? key, required this.audioPath,
    required this.callerName, required this.callerNumber, required this.callerEmail,
    required this.calleeName, required this.calleeNumber, required this.calleeEmail,}) : super(key: key);

  @override
  State<SignContract> createState() => _SignContractState();
}

class _SignContractState extends State<SignContract> {
  PdfDocument? generatedDocument;
  //PdfDocument document = PdfDocument();
  final _firestore = FirebaseFirestore.instance;
  final keySignaturePad = GlobalKey<SfSignaturePadState>();

  void navToUserProfile() {
    Navigator.pushNamed(context, UserProfile.id);
  }

  void navBackToPrevScreen(){
    Navigator.pop(context);
  }


  void navToDashBoard(){
    Navigator.pushNamed(context, DashboardPage.id);
  }


  @override
  Widget build(BuildContext context) {

    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(

      appBar: AppBar(
        // title: const Text('Contract Request'),

        title: Text(
          // profilegE4 (110:120)
          'Sign Contract',
          style: SafeGoogleFont (
            'Poppins',
            fontSize: 20*ffem,
            fontWeight: FontWeight.w400,
            height: 1.5*ffem/fem,
            color: Color(0xffffffff),
          ),
        ),

        backgroundColor: Colors.black,
        // leading: Container(
        //                 // vectorA9n (204:122)
        //                 margin: EdgeInsets.fromLTRB(15*fem, 0*fem, 0*fem, 0*fem),
        //                 width: 25*fem,
        //                 height: 25*fem,
        //                 child: Image.asset(
        //                   'assets/page-1/images/arroww.png',
        //                   width: 25*fem,
        //                   height: 25*fem,
        //                 ),
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
        actions: [

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
          //
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
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SfSignaturePad(
              key: keySignaturePad,
              backgroundColor: Colors.grey[200],
              strokeColor: Colors.black,
              minimumStrokeWidth: 1,
              maximumStrokeWidth: 4,
            ),

            ElevatedButton(
              onPressed: navToDashBoard,
              child: Center(
                child: Text(
                  'Create PDF',
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

            ElevatedButton(child: Text('Create PDF'), onPressed: _createPDF),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> _readImageData(String name) async {
    final data = await rootBundle.load('images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  void getCallerCalleData() async {
    late Map<String,dynamic> x;
    try{
      await for (var snapshot in _firestore.collection('users').snapshots()) {
        for (var message in snapshot.docs) {
          if (message.data()['number'] == widget.calleeNumber) {
            print(message.data());
            x = message.data();
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> savePDFDocumentToFirestore(PdfDocument document) async {
    // Convert the PDFDocument to Uint8List
    //final bytes = document.save();

  }

  Future<void> _createPDF() async {
    //String audioasset = "audio/file.wav";
    String audioasset = "/storage/emulated/0/Android/data/com.saifullah.firebae_reg_auth/files/temp_recording.mp3";
    // String? audioasset= widget.audioPath;
    //String? audioFilePath = widget.audioPath;
    print("In Create PDF ftn: JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ");
    print(widget.audioPath);

    print("===>>>>>>>>>>>>>>>>>>");
    print(widget.callerName);
    print(widget.callerNumber);
    print(widget.callerEmail);
    print("===>>>>>>>>>>>>>>>>>>");
    print(widget.calleeName);
    print(widget.calleeNumber);
    print(widget.calleeEmail);

    // getCallerCalleData();

    Uint8List audioFile = await _loadFile(audioasset);

    // ByteData bytes2 =
    // await rootBundle.load(audioFile); //load audio from assets
    // // Uint8List audioFile =
    // bytes2.buffer.asUint8List(bytes2.offsetInBytes, bytes2.lengthInBytes);

    // var url = 'http://127.0.0.1:5000/transcribe';
    // //var audioFile =
    // var request = http.MultipartRequest('POST', Uri.parse(url));
    // print("Flutter app ke andar hun");
    // //request.files.add(await http.MultipartFile.fromPath('file', audioFile));
    // request.files.add(
    //     http.MultipartFile.fromBytes('file', audioFile));
    //
    // var response = await request.send();
    var url = 'http://127.0.0.1:5000/transcribe';
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Create a MultipartFile from the audio data
    var multipartFile = http.MultipartFile.fromBytes('file', audioFile, filename: 'audio.mp3');

    // Add the file to the request
    request.files.add(multipartFile);

    // Send the request and get the response
    var response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse = await response.stream.bytesToString();
      var data = json.decode(jsonResponse);
      print(data);
      text = data['text'];
      filter = data['filter'];
      entities = data['entities'];
      // do something with the response data
    } else {
      // handle error
    }

    final image = await keySignaturePad.currentState?.toImage();
    final imageSignature =
    await image!.toByteData(format: ui.ImageByteFormat.png);
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    // Add logo image
    page.graphics.drawImage(PdfBitmap(await _readImageData('profile_icon.jpg')),
        Rect.fromLTWH(440, 0, 75, 75));
    page.graphics.drawString(
      'Speech 2 Contract',
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(0, 0, page.getClientSize().width, 50),
      format: PdfStringFormat(
        //alignment: PdfTextAlignment.right,
        lineAlignment: PdfVerticalAlignment.middle,
      ),
    );
    // Add title
    page.graphics.drawString(
      'Sale/Purchase Agreement',
      PdfStandardFont(PdfFontFamily.helvetica, 20, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(0, 20, page.getClientSize().width, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle,
      ),
    );

    // Add agreement details
    String? sellerName = 'John Doe';
    String? sellerPhoneNo = '1234567890';

    String? buyerName = 'John Buy';
    String? buyerPhoneNo = '1234567891';

    String? buyerEmail=widget.callerEmail;
    String? sellerEmail=widget.calleeEmail;

    final sellerCNIC = '12345-6789012-3';
    final sellerLicense = 'ABC-1234';

    sellerName=widget.callerName;
    sellerPhoneNo=widget.callerNumber;

    buyerName=widget.calleeName;
    buyerPhoneNo=widget.calleeNumber;

    page.graphics.drawString(
      'Seller Information\nName: $sellerName\nPhone no: $sellerPhoneNo\nEmail: $sellerEmail \n\nBuyer Information\nName: $buyerName\nPhone no: $buyerPhoneNo\nEmail: $buyerEmail\n\nThis Agreement is made and entered into on ${entities["RENTAL_PERIOD"]}\rnProduct Detail: ${entities}\nPrice: ${entities["PRICE"]}\nAdvance Amount: ${entities["PRICE"]}',
      PdfStandardFont(PdfFontFamily.helvetica, 14),
      bounds: Rect.fromLTWH(
        50,
        100,
        page.getClientSize().width - 100,
        page.getClientSize().height - 200,
      ),
      format: PdfStringFormat(lineSpacing: 1.5),
    );

    page.graphics.drawString(
      'Terms and Conditions:\n1. The Product(s) shall be delivered to the Buyer in the condition as described by the Sell and agreed upon by the Buyer.\n2. The Product(s) shall be delivered to the Buyer in the condition as described by the Seller and agreed upon by the Buyer.\n3. In case the Buyer fails to make payment for the Product(s) as agreed, the Seller reservesthe right to terminate this contract and to retain any deposit made by the Buyer asliquidated damages.\n4. The Buyer shall inspect the Product(s) immediately upon delivery and shall inform theSeller of any defects or damages within 5 days of delivery.\n5. The Seller warrants that the Product(s) are free from defects in material and workmanshipfor a period of 2 months from the date of delivery. If the Product(s) are found to bedefective within the warranty period, the Seller will repair or replace the defectiveProduct(s) at no additional cost to the Buyer.',
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(
        50,
        450,
        page.getClientSize().width - 100,
        page.getClientSize().height - 200,
      ),
      format: PdfStringFormat(lineSpacing: 1.5),
    );

    // Add signature lines
    page.graphics.drawString(
      'Seller Signature: ________________________________________________________',
      PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(
        50,
        page.getClientSize().height - 100,
        page.getClientSize().width / 2 - 75,
        50,
      ),
    );

    page.graphics.drawString(
      'Buyer Signature: ',
      PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(
        page.getClientSize().width / 2 + 25,
        page.getClientSize().height - 100,
        page.getClientSize().width / 2 - 75,
        50,
      ),
    );

    drawSignature(page, imageSignature!);

    List<int> bytes = document.save();
    document.dispose();
    generatedDocument = document;

    saveAndLaunchFile(bytes, 'Output.pdf');
  }
  Future<Uint8List> _loadFile(String path) async {
    try {
      final file = File(path);
      return await file.readAsBytes();
    } catch (e) {
      print('Error loading file: $e');
      return Uint8List(0);
    }
  }

  static void drawSignature(PdfPage page, ByteData imageSignature) {
    final pageSize = page.getClientSize();
    final PdfBitmap image = PdfBitmap(imageSignature.buffer.asUint8List());
    page.graphics.drawImage(image,
        Rect.fromLTWH(pageSize.width / 2 + 50, pageSize.height - 80, 150, 50));
  }


  Future<Uint8List> _loadLogoImage() async {
    final ByteData data = await rootBundle.load('assets/fyp.jpg');
    return data.buffer.asUint8List();
  }
}
