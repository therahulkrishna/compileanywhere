// import 'package:clipboard/clipboard.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:compileanywhere/ui/models/usermodels.dart';
// import 'package:compileanywhere/ui/widgets/apicalls.dart';
// import 'package:compileanywhere/ui/widgets/languages.dart';
// import 'package:compileanywhere/ui/widgets/localwidgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:progress_dialog/progress_dialog.dart';
// import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

// class PlayGround extends StatefulWidget {
//   @override
//   _PlayGroundState createState() => _PlayGroundState();
// }

// class _PlayGroundState extends State<PlayGround> {
//   TextEditingController _codeController = new TextEditingController();
//   TextEditingController _inputController = new TextEditingController();
//   String currentLang = "C#";
//   String currentLangCode = "csharp";
//   int currentLangVI = 3;

//   Lang selectedLang;
//   List<Lang> langs = [];

//   ProgressDialog pr;

//   bool isPublic = false;

//   @override
//   void initState() {
//     super.initState();
//     langs = Lang.getLang();
//     for (Lang lang in langs) {
//       if (lang.langName == "C#") {
//         setSelectedLang(lang);
//       }
//     }
//   }

//   setSelectedLang(Lang lang) {
//     setState(() {
//       selectedLang = lang;
//       currentLang = selectedLang.langName;
//       currentLangCode = selectedLang.language;
//       currentLangVI = selectedLang.maxVersion;
//     });
//   }

//   List<Widget> createaRadioListPrograms() {
//     List<Widget> widgets = [];
//     for (Lang lang in langs) {
//       widgets.add(Column(
//         children: [
//           SizedBox(
//             height: 16.h,
//           ),
//           SizedBox(
//             width: 328.w,
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Color(0xFF7277F1),
//                   borderRadius: BorderRadius.circular(8.0)),
//               child: RadioListTile(
//                   value: lang,
//                   activeColor: Colors.white,
//                   groupValue: selectedLang,
//                   title: Text(
//                     lang.langName,
//                     style: GoogleFonts.poppins(
//                         color: Colors.white, fontSize: ScreenUtil().setSp(14)),
//                   ),
//                   selected: selectedLang == lang,
//                   onChanged: (currentLang) {
//                     setSelectedLang(currentLang);
//                   }),
//             ),
//           ),
//         ],
//       ));
//     }
//     return widgets;
//   }

//   createInputPopUp(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             backgroundColor: Colors.white,
//             title: Text('Input (Optional)',
//                 style: GoogleFonts.poppins(
//                     fontSize: 20,
//                     color: Color(0xFF7277F1),
//                     fontWeight: FontWeight.w600)),
//             content: SingleChildScrollView(
//               child: TextField(
//                 controller: _inputController,
//                 cursorColor: Colors.black,
//                 keyboardType: TextInputType.multiline,
//                 minLines: 1,
//                 maxLines: 100,
//                 decoration: new InputDecoration(
//                     hintText:
//                         '(Enter Here) Split multiple inputs into separate lines',
//                     hintStyle:
//                         GoogleFonts.poppins(fontSize: 10, color: Colors.black)),
//               ),
//             ),
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(right: 20),
//                     child: GestureDetector(
//                       child: Text('submit',
//                           style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               color: Color(0xFF7277F1),
//                               fontWeight: FontWeight.w600)),
//                       onTap: () {
//                         showResult(context, _codeController.text,
//                             _inputController.text);
//                         pr.show();
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: 50,
//                   )
//                 ],
//               )
//             ],
//           );
//         });
//   }

//   createSavePopup(BuildContext context) {
//     print('Clicked on save');
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             backgroundColor: Colors.white,
//             title: Text('Save your program',
//                 style: GoogleFonts.poppins(
//                     fontSize: 20,
//                     color: Color(0xFF7277F1),
//                     fontWeight: FontWeight.w600)),
//             content: SingleChildScrollView(
//               child: TextField(
//                 controller: _inputController,
//                 cursorColor: Colors.black,
//                 keyboardType: TextInputType.multiline,
//                 minLines: 1,
//                 maxLines: 100,
//                 decoration: new InputDecoration(
//                     hintText: 'Enter your programs name',
//                     hintStyle:
//                         GoogleFonts.poppins(fontSize: 10, color: Colors.black)),
//               ),
//             ),
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   CheckboxListTile(
//                     title: Text("Make as public"),
//                     value: isPublic,
//                     onChanged: (newValue) {
//                       setState(() {
//                         isPublic = newValue;
//                       });
//                     },
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(right: 20),
//                     child: GestureDetector(
//                       child: Text('submit',
//                           style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               color: Color(0xFF7277F1),
//                               fontWeight: FontWeight.w600)),
//                       onTap: () {
//                         showResult(context, _codeController.text,
//                             _inputController.text);
//                         pr.show();
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: 50,
//                   )
//                 ],
//               )
//             ],
//           );
//         });
//   }

//   showErrorPopup(BuildContext context) {
//     print('Showing Error');
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             backgroundColor: Colors.white,
//             title: Text(''),
//             content: Text('Oops! Something went wrong!',
//                 style: GoogleFonts.poppins(
//                     fontSize: 20,
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500)),
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(right: 20),
//                     child: GestureDetector(
//                       child: Text('Okay',
//                           style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               color: Color(0xFF7277F1),
//                               fontWeight: FontWeight.w600)),
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: 50,
//                   )
//                 ],
//               )
//             ],
//           );
//         });
//   }

//   Future showResult(BuildContext context, String program, String input) async {
//     var response = await CompileCode()
//         .getOutput(program, input, currentLangCode, currentLangVI);
//     print(response);
//     var output = response['output'];
//     if (pr.isShowing()) {
//       pr.hide();
//     }
//     Navigator.pop(context);
//     if (response['statusCode'] == 200) {
//       showModalBottomSheet(
//           context: context,
//           builder: (context) {
//             return Container(
//               color: Color(0xFF7277F1),
//               height: MediaQuery.of(context).size.height * .5,
//               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Output',
//                         style: GoogleFonts.poppins(
//                             fontSize: ScreenUtil().setSp(14),
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       IconButton(
//                           icon: Icon(
//                             Icons.share,
//                             color: Colors.white,
//                             size: 24.h,
//                           ),
//                           onPressed: () {
//                             FlutterClipboard.copy(output.toString())
//                                 .then((value) {
//                               showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     Future.delayed(Duration(seconds: 2), () {
//                                       Navigator.of(context).pop(true);
//                                     });
//                                     return AlertDialog(
//                                       title: Text(
//                                           'Copied output to your clipboard!',
//                                           style: GoogleFonts.poppins(
//                                               fontSize: 15)),
//                                     );
//                                   });
//                             });
//                           }),
//                     ],
//                   ),
//                   SizedBoxPadding(),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Text(output,
//                           style: GoogleFonts.sourceCodePro(
//                               fontSize: ScreenUtil().setSp(14),
//                               color: Colors.white)),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           });
//     } else {
//       showErrorPopup(context);
//     }
//   }

//   Firestore db = Firestore.instance;
//   @override
//   Widget build(BuildContext context) {
//     pr = ProgressDialog(
//       context,
//       type: ProgressDialogType.Normal,
//       textDirection: TextDirection.ltr,
//       isDismissible: false,
//     );

//     pr.style(
//       message: 'Compiling',
//       borderRadius: 10.0,
//       backgroundColor: Colors.white,
//       elevation: 10.0,
//       insetAnimCurve: Curves.easeInOut,
//       messageTextStyle: GoogleFonts.poppins(
//           fontSize: 30, color: Colors.black, fontWeight: FontWeight.w500),
//     );
//     ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);

//     return BackgroundBox(
//       appBar: TransparentAppBar(
//         title: "Playground",
//         actionIcon: Icons.save,
//         actionOnPressed: () {},
//       ),
//       child: playGround(context, 'hello'),
//       // StreamBuilder(
//       //     stream: db
//       //         .collection('faculty')
//       //         // .where("__id == fK3ddutEpD2qQqRMXNW5")
//       //         //  .where('uid', isEqualTo: UserDetails().uid)
//       //         .snapshots(),
//       //     builder: (context, snapshot) {
//       //       print("Jahan " + snapshot.data.documents.length.toString());
//       //       print("Jahan :: the data is printeddddddddddd");

//       //       final specificDocument = snapshot.data.documents.where((f) {
//       //         return f.documentID == "HaIqpMrp0aPs4SogDmp";
//       //       }).toList();

//       //     print("Jahan ::::::::::" + specificDocument.toString());

//       //       // Map<String, dynamic> documentFields = snapshot.data.data;
//       //       //  documentFields.keys.forEach((element) => {
//       //       //    print("Jahan ::::::::::" + element.toString())
//       //       //  });

//       //       // snapshot.data.documents.forEach((doc) => {
//       //       //       print("Jahna ============= " +
//       //       //           doc['name'] +
//       //       //           " " +
//       //       //           doc['popularity'].toString())
//       //       //     });

//       //       // snapshot.data.documents.map((doc) => {
//       //       //       print("Jahna ============= " + doc.name),
//       //       //       print("Jahna ============= " + doc.id)
//       //       //     });

//       //       if (!snapshot.hasData) {
//       //         return Center(
//       //           child: CircularProgressIndicator(),
//       //         );
//       //       } else {
//       //         print("inside else block");
//       //         return ListView.builder(
//       //             itemCount: snapshot.data.documents.length,
//       //             itemBuilder: (context, index) {
//       //               print("Testing data " +
//       //                   index.toString() +
//       //                   " " +
//       //                   snapshot.data.documents[index]["name"].toString());
//       //               return playGround(context,
//       //                   snapshot.data.documents[index]["name"].toString());
//       //             });
//       //       }
//       //     }),
//       bottomSheet: SolidBottomSheet(
//         toggleVisibilityOnTap: true,
//         headerBar: Container(
//           color: Colors.white,
//           height: 60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                   padding: EdgeInsets.only(left: 20),
//                   child: Row(
//                     children: [
//                       Text(currentLang,
//                           style: GoogleFonts.poppins(
//                             fontSize: 25,
//                             color: Color(0xFF5254D8),
//                           )),
//                       Icon(
//                         Icons.keyboard_arrow_down,
//                         color: Color(0xFF5254D8),
//                       )
//                     ],
//                   )),
//               FlatButton(
//                 padding:
//                     EdgeInsets.only(left: 25, right: 15, top: 15, bottom: 10),
//                 disabledColor: Color(0xFF7277F1),
//                 color: Color(0xFF7277F1),
//                 onPressed: () {
//                   createInputPopUp(context);
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Run',
//                       style: GoogleFonts.poppins(
//                           fontSize: 25,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600),
//                     ),
//                     Icon(
//                       Icons.play_arrow,
//                       color: Colors.white,
//                       size: 35,
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: Container(
//           padding: EdgeInsets.only(left: 15, right: 15),
//           color: Colors.white,
//           child: SingleChildScrollView(
//             child: Column(
//               children: createaRadioListPrograms(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget playGround(BuildContext context, String title) {
//   TextEditingController _codeController = new TextEditingController();

//   return Column(
//     children: [
//       SizedBoxPadding(),
//       Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: SizedBox(
//           width: 328.w,
//           height: 484.h,
//           child: Container(
//             decoration: BoxDecoration(
//                 color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
//             child: SingleChildScrollView(
//               //  child:Text(title),
//               child: TextFormField(
//                 initialValue: 'he',
//                 // initialValue: "hello",
//                 controller: _codeController,
//                 cursorColor: Colors.black,
//                 style: GoogleFonts.sourceCodePro(
//                   fontSize: ScreenUtil().setSp(14),
//                   color: Color(0xFF333333),
//                 ),
//                 textCapitalization: TextCapitalization.none,
//                 maxLines: 5000,
//                 autofocus: false,
//                 showCursor: true,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   focusedBorder: InputBorder.none,
//                   enabledBorder: InputBorder.none,
//                   errorBorder: InputBorder.none,
//                   disabledBorder: InputBorder.none,
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//                   hintText: 'Enter Your {code} here',
//                   hintStyle: GoogleFonts.sourceCodePro(
//                     fontWeight: FontWeight.w300,
//                     fontSize: ScreenUtil().setSp(12),
//                     color: Color(0xff333333),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }

// import 'package:compileanywhere/ui/widgets/apicalls.dart';
// import 'package:compileanywhere/ui/widgets/languages.dart';
// import 'package:compileanywhere/ui/widgets/localwidgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
// import 'package:progress_dialog/progress_dialog.dart';
// import 'package:flutter/services.dart';
// import 'package:clipboard/clipboard.dart';

// class PlayGround extends StatefulWidget {
//   @override
//   _PlayGroundState createState() => _PlayGroundState();
// }

// class _PlayGroundState extends State<PlayGround> {
//   TextEditingController _codeController = new TextEditingController();
//   TextEditingController _inputController = new TextEditingController();
//   String currentLang = "C#";
//   String currentLangCode = "csharp";
//   int currentLangVI = 3;

//   Lang selectedLang;
//   List<Lang> langs = [];

//   ProgressDialog pr;

//   bool isPublic = false;

//   @override
//   void initState() {
//     super.initState();
//     langs = Lang.getLang();
//     for (Lang lang in langs) {
//       if (lang.langName == "C#") {
//         setSelectedLang(lang);
//       }
//     }
//   }

//   setSelectedLang(Lang lang) {
//     setState(() {
//       selectedLang = lang;
//       currentLang = selectedLang.langName;
//       currentLangCode = selectedLang.language;
//       currentLangVI = selectedLang.maxVersion;
//     });
//   }

//   List<Widget> createaRadioListPrograms() {
//     List<Widget> widgets = [];
//     for (Lang lang in langs) {
//       widgets.add(SizedBox(
//         width: MediaQuery.of(context).size.width * 0.97,
//         height: 60,
//         child: Card(
//           color: Color(0xFF7277F1),
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10))),
//           child: RadioListTile(
//               value: lang,
//               activeColor: Colors.white,
//               groupValue: selectedLang,
//               title: Text(
//                 lang.langName,
//                 style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
//               ),
//               selected: selectedLang == lang,
//               onChanged: (currentLang) {
//                 setSelectedLang(currentLang);
//               }),
//         ),
//       ));
//     }
//     return widgets;
//   }

//   createInputPopUp(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             backgroundColor: Colors.white,
//             title: Text('Input (Optional)',
//                 style: GoogleFonts.poppins(
//                     fontSize: 20,
//                     color: Color(0xFF7277F1),
//                     fontWeight: FontWeight.w600)),
//             content: SingleChildScrollView(
//               child: TextField(
//                 controller: _inputController,
//                 cursorColor: Colors.black,
//                 keyboardType: TextInputType.multiline,
//                 minLines: 1,
//                 maxLines: 100,
//                 decoration: new InputDecoration(
//                     hintText:
//                         '(Enter Here) Split multiple inputs into separate lines',
//                     hintStyle:
//                         GoogleFonts.poppins(fontSize: 10, color: Colors.black)),
//               ),
//             ),
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(right: 20),
//                     child: GestureDetector(
//                       child: Text('submit',
//                           style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               color: Color(0xFF7277F1),
//                               fontWeight: FontWeight.w600)),
//                       onTap: () {
//                         showResult(context, _codeController.text,
//                             _inputController.text);
//                         pr.show();
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: 50,
//                   )
//                 ],
//               )
//             ],
//           );
//         });
//   }

//   createSavePopup(BuildContext context) {
//     print('Clicked on save');
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             backgroundColor: Colors.white,
//             title: Text('Save your program',
//                 style: GoogleFonts.poppins(
//                     fontSize: 20,
//                     color: Color(0xFF7277F1),
//                     fontWeight: FontWeight.w600)),
//             content: SingleChildScrollView(
//               child: TextField(
//                 controller: _inputController,
//                 cursorColor: Colors.black,
//                 keyboardType: TextInputType.multiline,
//                 minLines: 1,
//                 maxLines: 100,
//                 decoration: new InputDecoration(
//                     hintText: 'Enter your programs name',
//                     hintStyle:
//                         GoogleFonts.poppins(fontSize: 10, color: Colors.black)),
//               ),
//             ),
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   CheckboxListTile(
//                     title: Text("Make as public"),
//                     value: isPublic,
//                     onChanged: (newValue) {
//                       setState(() {
//                         isPublic = newValue;
//                       });
//                     },
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(right: 20),
//                     child: GestureDetector(
//                       child: Text('submit',
//                           style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               color: Color(0xFF7277F1),
//                               fontWeight: FontWeight.w600)),
//                       onTap: () {
//                         showResult(context, _codeController.text,
//                             _inputController.text);
//                         pr.show();
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: 50,
//                   )
//                 ],
//               )
//             ],
//           );
//         });
//   }

//   showErrorPopup(BuildContext context) {
//     print('Showing Error');
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             backgroundColor: Colors.white,
//             title: Text(''),
//             content: Text('Oops! Something went wrong!',
//                 style: GoogleFonts.poppins(
//                     fontSize: 20,
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500)),
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(right: 20),
//                     child: GestureDetector(
//                       child: Text('Okay',
//                           style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               color: Color(0xFF7277F1),
//                               fontWeight: FontWeight.w600)),
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: 50,
//                   )
//                 ],
//               )
//             ],
//           );
//         });
//   }

//   Future showResult(BuildContext context, String program, String input) async {
//     var response = await CompileCode()
//         .getOutput(program, input, currentLangCode, currentLangVI);
//     print(response);
//     var output = response['output'];
//     if (pr.isShowing()) {
//       pr.hide();
//     }
//     Navigator.pop(context);
//     if (response['statusCode'] == 200) {
//       showModalBottomSheet(
//           context: context,
//           builder: (context) {
//             return Container(
//               color: Color(0xFF7277F1),
//               height: MediaQuery.of(context).size.height * .5,
//               padding: EdgeInsets.all(15),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Output',
//                           style: GoogleFonts.poppins(
//                               fontSize: 20,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600)),
//                       IconButton(
//                           icon: Icon(
//                             Icons.share,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {
//                             FlutterClipboard.copy(output.toString())
//                                 .then((value) {
//                               showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     Future.delayed(Duration(seconds: 2), () {
//                                       Navigator.of(context).pop(true);
//                                     });
//                                     return AlertDialog(
//                                       title: Text(
//                                           'Copied output to your clipboard!',
//                                           style: GoogleFonts.poppins(
//                                               fontSize: 15)),
//                                     );
//                                   });
//                             });
//                           }),
//                     ],
//                   ),
//                   Divider(
//                     color: Colors.white,
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Text(output,
//                           style: GoogleFonts.poppins(
//                               fontSize: 15, color: Colors.white)),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           });
//     } else {
//       showErrorPopup(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     pr = ProgressDialog(
//       context,
//       type: ProgressDialogType.Normal,
//       textDirection: TextDirection.ltr,
//       isDismissible: false,
//     );

//     pr.style(
//       message: 'Compiling',
//       borderRadius: 10.0,
//       backgroundColor: Colors.white,
//       elevation: 10.0,
//       insetAnimCurve: Curves.easeInOut,
//       messageTextStyle: GoogleFonts.poppins(
//           fontSize: 30, color: Colors.black, fontWeight: FontWeight.w500),
//     );

//     return Scaffold(
//       body: SafeArea(
//           child: Stack(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: ThemeColor().returnColor())),
//           ),
//           Padding(
//             padding:  EdgeInsets.only(
//                       top: MediaQuery.of(context).size.width * 0.03
//             ),
//             child: Row(
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(
//                       left: MediaQuery.of(context).size.width * 0.03),
//                   child: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(
//                       Icons.arrow_back_ios,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       left: MediaQuery.of(context).size.width * 0.1512),
//                   child: Text(
//                     'Playground',
//                     style: GoogleFonts.poppins(
//                       fontSize: 30,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SingleChildScrollView(
//             child: Center(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 80,
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.97,
//                     height: MediaQuery.of(context).size.height * 0.75,
//                     child: Card(
//                       color: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                       child: Container(
//                         padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
//                         child: SingleChildScrollView(
//                           child: TextField(
//                             controller: _codeController,
//                             cursorColor: Colors.black,
//                             style: GoogleFonts.poppins(
//                                 fontSize: 14, color: Colors.black),
//                             textCapitalization: TextCapitalization.none,
//                             maxLines: 5000,
//                             autofocus: false,
//                             showCursor: true,
//                             // mouseCursor: MouseCursor.defer,
//                             decoration: InputDecoration(
//                               contentPadding: EdgeInsets.only(top: 15),
//                               hintText: 'Enter your {code} here!',
//                               hintStyle: GoogleFonts.poppins(
//                                 fontWeight: FontWeight.w200,
//                                 color: Colors.black,
//                                 fontSize: 14,
//                               ),
//                               enabledBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       )),
//       bottomSheet: SolidBottomSheet(
//         toggleVisibilityOnTap: true,
//         headerBar: Container(
//           color: Colors.white,
//           height: 60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                   padding: EdgeInsets.only(left: 20),
//                   child: Row(
//                     children: [
//                       Text(currentLang,
//                           style: GoogleFonts.poppins(
//                             fontSize: 25,
//                             color: Color(0xFF5254D8),
//                           )),
//                       Icon(
//                         Icons.keyboard_arrow_down,
//                         color: Color(0xFF5254D8),
//                       )
//                     ],
//                   )),
//               FlatButton(
//                 padding:
//                     EdgeInsets.only(left: 25, right: 15, top: 15, bottom: 10),
//                 disabledColor: Color(0xFF7277F1),
//                 color: Color(0xFF7277F1),
//                 onPressed: () {
//                   createInputPopUp(context);
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Run',
//                       style: GoogleFonts.poppins(
//                           fontSize: 25,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600),
//                     ),
//                     Icon(
//                       Icons.play_arrow,
//                       color: Colors.white,
//                       size: 35,
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: Container(
//           padding: EdgeInsets.only(left: 15, right: 15),
//           color: Colors.white,
//           child: SingleChildScrollView(
//             child: Column(
//               children: createaRadioListPrograms(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }













// import 'package:compileanywhere/ui/widgets/apicalls.dart';
// import 'package:compileanywhere/ui/widgets/input_pop.dart';
// import 'package:compileanywhere/ui/widgets/languages.dart';
// import 'package:compileanywhere/ui/widgets/localwidgets.dart';
// import 'package:compileanywhere/ui/widgets/save_pop.dart';
// import 'package:compileanywhere/ui/widgets/show_error.dart';
// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:progress_dialog/progress_dialog.dart';
// import 'package:flutter/services.dart';
// import 'package:clipboard/clipboard.dart';

// class PlayGround extends StatefulWidget {
//   @override
//   _PlayGroundState createState() => _PlayGroundState();
// }

// class _PlayGroundState extends State<PlayGround> {
//   TextEditingController _codeController = new TextEditingController();
//   TextEditingController _inputController = new TextEditingController();
//   String currentLang = "C#";
//   String currentLangCode = "csharp";
//   int currentLangVI = 3;

//   Lang selectedLang;
//   List<Lang> langs = [];

//   ProgressDialog pr;

//   bool isPublic = false;

//   @override
//   void initState() {
//     super.initState();
//     langs = Lang.getLang();
//     for (Lang lang in langs) {
//       if (lang.langName == "C#") {
//         setSelectedLang(lang);
//       }
//     }
//   }

//   setSelectedLang(Lang lang) {
//     setState(() {
//       selectedLang = lang;
//       currentLang = selectedLang.langName;
//       currentLangCode = selectedLang.language;
//       currentLangVI = selectedLang.maxVersion;
//     });
//   }

//   List<Widget> createaRadioListPrograms() {
//     List<Widget> widgets = [];
//     for (Lang lang in langs) {
//       widgets.add(Column(
//         children: [
//           SizedBox(
//             height: 16.h,
//           ),
//           SizedBox(
//             width: 328.w,
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Color(0xFF7277F1),
//                   borderRadius: BorderRadius.circular(8.0)),
//               child: RadioListTile(
//                   value: lang,
//                   activeColor: Colors.white,
//                   groupValue: selectedLang,
//                   title: Text(
//                     lang.langName,
//                     style: GoogleFonts.poppins(
//                         color: Colors.white, fontSize: ScreenUtil().setSp(14)),
//                   ),
//                   selected: selectedLang == lang,
//                   onChanged: (currentLang) {
//                     setSelectedLang(currentLang);
//                   }),
//             ),
//           ),
//         ],
//       ));
//     }
//     return widgets;
//   }

//   createInputPopUp(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             backgroundColor: Colors.white,
//             title: Text('Input (Optional)',
//                 style: GoogleFonts.poppins(
//                     fontSize: 20,
//                     color: Color(0xFF7277F1),
//                     fontWeight: FontWeight.w600)),
//             content: SingleChildScrollView(
//               child: TextField(
//                 controller: _inputController,
//                 cursorColor: Colors.black,
//                 keyboardType: TextInputType.multiline,
//                 minLines: 1,
//                 maxLines: 100,
//                 decoration: new InputDecoration(
//                     hintText:
//                         '(Enter Here) Split multiple inputs into separate lines',
//                     hintStyle:
//                         GoogleFonts.poppins(fontSize: 10, color: Colors.black)),
//               ),
//             ),
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(right: 20),
//                     child: GestureDetector(
//                       child: Text('submit',
//                           style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               color: Color(0xFF7277F1),
//                               fontWeight: FontWeight.w600)),
//                       onTap: () {
//                         showResult(context, _codeController.text,
//                             _inputController.text);
//                         pr.show();
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: 50,
//                   )
//                 ],
//               )
//             ],
//           );
//         });
//   }

//   createSavePopup(BuildContext context) {
//     print('Clicked on save');
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             backgroundColor: Colors.white,
//             title: Text('Save your program',
//                 style: GoogleFonts.poppins(
//                     fontSize: 20,
//                     color: Color(0xFF7277F1),
//                     fontWeight: FontWeight.w600)),
//             content: SingleChildScrollView(
//               child: TextField(
//                 controller: _inputController,
//                 cursorColor: Colors.black,
//                 keyboardType: TextInputType.multiline,
//                 minLines: 1,
//                 maxLines: 100,
//                 decoration: new InputDecoration(
//                     hintText: 'Enter your programs name',
//                     hintStyle:
//                         GoogleFonts.poppins(fontSize: 10, color: Colors.black)),
//               ),
//             ),
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   CheckboxListTile(
//                     title: Text("Make as public"),
//                     value: isPublic,
//                     onChanged: (newValue) {
//                       setState(() {
//                         isPublic = newValue;
//                       });
//                     },
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(right: 20),
//                     child: GestureDetector(
//                       child: Text('submit',
//                           style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               color: Color(0xFF7277F1),
//                               fontWeight: FontWeight.w600)),
//                       onTap: () {
//                         showResult(context, _codeController.text,
//                             _inputController.text);
//                         pr.show();
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: 50,
//                   )
//                 ],
//               )
//             ],
//           );
//         });
//   }

//   Future showResult(BuildContext context, String program, String input) async {
//     var response = await CompileCode()
//         .getOutput(program, input, currentLangCode, currentLangVI);
//     print(response);
//     var output = response['output'];
//     if (pr.isShowing()) {
//       pr.hide();
//     }
//     Navigator.pop(context);
//     if (response['statusCode'] == 200) {
//       showModalBottomSheet(
//           context: context,
//           builder: (context) {
//             return Container(
//               color: Color(0xFF7277F1),
//               height: 320.h,
//               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Output',
//                         style: GoogleFonts.poppins(
//                             fontSize: ScreenUtil().setSp(14),
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       IconButton(
//                           icon: Icon(
//                             Icons.share,
//                             color: Colors.white,
//                             size: 24.h,
//                           ),
//                           onPressed: () {
//                             FlutterClipboard.copy(output.toString())
//                                 .then((value) {
//                               showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     Future.delayed(Duration(seconds: 2), () {
//                                       Navigator.of(context).pop(true);
//                                     });
//                                     return AlertDialog(
//                                       title: Text(
//                                           'Copied output to your clipboard!',
//                                           style: GoogleFonts.poppins(
//                                               fontSize: 15)),
//                                     );
//                                   });
//                             });
//                           }),
//                     ],
//                   ),
//                   SizedBoxPadding(),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Text(output,
//                           style: GoogleFonts.sourceCodePro(
//                               fontSize: ScreenUtil().setSp(14),
//                               color: Colors.white)),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           });
//     } else {
//       showError(
//           'images/cloud_crossed.png', "Oops something went wrong", context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     pr = ProgressDialog(
//       context,
//       type: ProgressDialogType.Normal,
//       textDirection: TextDirection.ltr,
//       isDismissible: false,
//     );

//     pr.style(
//       message: 'Compiling',
//       borderRadius: 10.0,
//       backgroundColor: Colors.white,
//       elevation: 10.0,
//       insetAnimCurve: Curves.easeInOut,
//       messageTextStyle: GoogleFonts.poppins(
//           fontSize: 30, color: Colors.black, fontWeight: FontWeight.w500),
//     );
//     ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);

//     return BackgroundBox(
//       appBar: TransparentAppBar(
//         title: "Playground",
//         actionIcon: Icons.save,
//         actionOnPressed: () {
//           savePop(
//               _inputController,
//               () {
//                 showResult(
//                     context, _codeController.text, _inputController.text);
//                 pr.show();
//               },
//               isPublic,
//               (newValue) {
//                 setState(() {
//                   isPublic = newValue;
//                 });
//               },
//               context);
//         },
//       ),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           child: Column(
//             children: [
//               SizedBoxPadding(),
//               ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight: 484.h,
//                   maxHeight: 484.h,
//                 ),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8.h)),
//                   child: TextField(
//                     cursorColor: Color(0xff333333),
//                     style: GoogleFonts.sourceCodePro(
//                       fontWeight: FontWeight.w400,
//                       fontSize: ScreenUtil().setSp(14),
//                       color: Color(0xff333333),
//                     ),
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       focusedBorder: InputBorder.none,
//                       enabledBorder: InputBorder.none,
//                       errorBorder: InputBorder.none,
//                       disabledBorder: InputBorder.none,
//                       contentPadding: EdgeInsets.symmetric(
//                           horizontal: 16.w, vertical: 16.h),
//                       hintText: "Enter the Program",
//                       hintStyle: GoogleFonts.sourceCodePro(
//                         fontWeight: FontWeight.w300,
//                         fontSize: ScreenUtil().setSp(12),
//                         color: Color(0xff333333),
//                       ),
//                     ),
//                     minLines: 1,
//                     maxLengthEnforced: true,
//                     maxLines: 80,
//                   ),
//                 ),
//               ),
//               SizedBoxPadding(),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: ExpandableNotifier(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ExpandableButton(
//               child: Container(
//                 color: Colors.white,
//                 height: 48.h,
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 16.w,
//                     ),
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Text(
//                             currentLang,
//                             style: GoogleFonts.poppins(
//                               fontSize: ScreenUtil().setSp(14),
//                               color: Color(0xFF7277F1),
//                             ),
//                           ),
//                           Expanded(
//                             child: SizedBox(
//                               width: 4.w,
//                             ),
//                           ),
//                           Icon(
//                             Icons.keyboard_arrow_down,
//                             color: Color(0xFF7277F1),
//                             size: ScreenUtil().setSp(24),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: 16.w,
//                     ),
//                     SizedBox(
//                       width: 88.w,
//                       height: 48.h,
//                       child: Container(
//                         color: Color(0xFF7277F1),
//                         child: MaterialButton(
//                           padding: EdgeInsets.symmetric(horizontal: 16.w),
//                           disabledColor: Color(0xFF7277F1),
//                           color: Color(0xFF7277F1),
//                           onPressed: () {
//                             inputPop(_inputController, () {
//                               showResult(context, _codeController.text,
//                                   _inputController.text);
//                               pr.show();
//                             }, context);
//                           },
//                           child: FittedBox(
//                             child: Row(
//                               children: [
//                                 Text(
//                                   'Run',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: ScreenUtil().setSp(18),
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                                 Icon(
//                                   Icons.play_arrow,
//                                   color: Colors.white,
//                                   size: ScreenUtil().setSp(24),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Expandable(
//               expanded: SizedBox(
//                 height: 320.h,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 16.w),
//                   color: Colors.white,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Column(
//                           children: createaRadioListPrograms(),
//                         ),
//                         SizedBox(
//                           height: 16.h,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

