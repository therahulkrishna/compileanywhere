// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:compileanywhere/ui/models/usermodels.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   TextEditingController _emailController = new TextEditingController();
//   TextEditingController _passwordController = new TextEditingController();

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//  login(String email ,String password)async{
//     try {
//       FirebaseUser user = (await _auth.signInWithEmailAndPassword(
//               email: email, password: password))
//           .user;
//                Firestore.instance.collection('users').document(user.uid).get().then((document){
//                print('User details');
//                 print(document.data['name']);
//                  UserDetails().updateUser(document.data['name'],document.data['username'], document.data['email'], user.uid, document.data['profilepicurl'],user);
//                });

         

//     } catch (e) {
//       showError(e.message);
//     }
//   }
//      @override
//   void initState() {
//     super.initState();
//     checkAuthentication();
//     super.initState();
    
//   }
//   checkAuthentication() {
//     _auth.onAuthStateChanged.listen((user) async {
//       if (user != null) {
//         Navigator.of(context).pop();
//         Navigator.pushReplacementNamed(context, '/lop');
//       }
//     });
//   }

//   // signIn(String email, String password) async {
//   //   try {
//   //     FirebaseUser user = (await _auth.signInWithEmailAndPassword(
//   //             email: email, password: password))
//   //         .user;
//   //   } catch (e) {
//   //     showError(e.message);
//   //   }
//   // }

//   showError(String errorMessage) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text(errorMessage),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//               colors: [Color(0xFF5254D8), Color(0xFF1DA1F2)],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             )),
//             child: ListView(children: [
//               Stack(children: [

              
//                 Container(
//                   padding: EdgeInsets.fromLTRB(0, 28, 0, 0),
//                   alignment: Alignment(0, 1),
//                   child: Text(
//                       'Sign in',
//               style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 30,
//                 color: Colors.white,
//               ),
//                   ),
//                 ),
//                 Container(
//                     padding: EdgeInsets.only(left: 5, top: 23),
//                     child: IconButton(
//                         icon: Icon(
//                           Icons.arrow_back_ios,
//                           color: Colors.white,
//                         ),
//                         onPressed: () {
//                          Navigator.pushReplacementNamed(context, '/intro');
//                          // Navigator.of(context).pop();
//                         })),
//               ]),
//               Container(
//                 padding: EdgeInsets.only(left: 15, right: 15, top: 65),
//                 child: TextField(
//                   controller: _emailController,
//                   cursorColor: Colors.white,
//                   style: TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.only(top: 15),
//                     hintText: 'email',
//                     hintStyle: GoogleFonts.poppins(
//                       fontWeight: FontWeight.w200,
//                       color: Colors.white,
//                       fontSize: 14,
//                     ),
//                     enabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.fromLTRB(13, 15, 13, 0),
//                 child: TextField(
//                   controller: _passwordController,
//                   cursorColor: Colors.white,
//                   style: TextStyle(color: Colors.white),
//                   obscureText: true,
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(top: 15),
//                       hintText: 'password',
//                       hintStyle: GoogleFonts.poppins(
//                         fontWeight: FontWeight.w200,
//                         fontSize: 14,
//                         color: Colors.white,
//                       ),
//                       enabledBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white))),
//                 ),
//               ),
//               Stack(children: [
//                 Column(children: [
//                   Stack(children: [
                    
//                     Container(
//                       padding: EdgeInsets.fromLTRB(15, 37, 230, 2),
//                       child: Text('No account? ',
//                           style: GoogleFonts.poppins(
//                             fontWeight: FontWeight.w200,
//                             color: Colors.white,
//                             fontSize: 14,
//                           )),
//                     ),
//                     Container(
//                         padding: EdgeInsets.only(left: 90, top: 24),
//                         child: FlatButton(
//                             onPressed: () {
//                               Navigator.of(context).pushNamed("/signup");
//                             },
//                             child: Text(' Create one!',
//                                 style: GoogleFonts.poppins(
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.white,
//                                   fontSize: 14,
//                                 ))))
//                   ])
//                 ]),
//                 Positioned(
//                   child: Container(
//                     padding: EdgeInsets.fromLTRB(15, 93, 250, 0),
//                     child: Text('Forgot password?',
//                         style: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w400,
//                           fontSize: 14,
//                         )),
//                   ),
//                 ),
//                 Positioned(
//                   child: Container(
//                       padding: EdgeInsets.fromLTRB(260, 80, 0, 0),
//                       child: RaisedButton(
//                         padding: EdgeInsets.fromLTRB(40, 7, 40, 7),
//                         color: Colors.white,
//                         shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(36))),
//                         onPressed: () {

//                               login(_emailController.text, _passwordController.text);
//                             // Navigator.pushReplacementNamed(context, '/lop');
//                         },
//                         child: Text('Sign in',
//                             style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF1DA1F2),
//                               fontSize: 19,
//                             )),
//                       )),
//                 ),
//               ]),
//               Container(
//                   padding: EdgeInsets.fromLTRB(80, 258, 0, 0),
//                   child: Text(
//                     'SRI SAIRAM COLLEGE OF ENGINEERING',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   )),


                  
//             ])),
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compileanywhere/ui/models/usermodels.dart';
import 'package:compileanywhere/ui/widgets/background_box.dart';
import 'package:compileanywhere/ui/widgets/customgooglebutton.dart';
import 'package:compileanywhere/ui/widgets/localwidgets.dart';
import 'package:compileanywhere/ui/widgets/show_error.dart';
import 'package:compileanywhere/ui/widgets/solid_small_button.dart';
import 'package:compileanywhere/ui/widgets/text_field_colured.dart';
import 'package:compileanywhere/ui/widgets/transparentappbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  login(String email, String password) async {
    try {
      FirebaseUser user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      Firestore.instance
          .collection('users')
          .document(user.uid)
          .get()
          .then((document) {
        print('User details');
        print(document.data['name']);
        UserDetails().updateUser(
            document.data['name'],
            document.data['username'],
            document.data['email'],
            user.uid,
            document.data['profilepicurl'],
            user);
      });
    } catch (e) {
      showError("images/sad_face.png", e.message, context);
    }
  }

  @override
  void initState() {
    super.initState();
    checkAuthentication();
    super.initState();
  }

  checkAuthentication() {
    _auth.onAuthStateChanged.listen((user) async {
      if (user != null) {
        Navigator.of(context).pop();
        Navigator.pushReplacementNamed(context, '/lop');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundBox(
      resizeToAvoidBottomInset: false,
      appBar: TransparentAppBar(
        title: "Sign in",
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 46.h,
                ),
                TextFieldColoured(
                  hintText: 'email',
                  obscureText: false,
                  isWhite: true,
                  controller: _emailController,
                ),
                SizedBoxPadding(),
                TextFieldColoured(
                  hintText: 'password',
                  obscureText: true,
                  isWhite: true,
                  controller: _passwordController,
                ),
                SizedBox(
                  height: 36.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed("/signup");
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'No account? ',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(11),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Create one!',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(12),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Forgot Password?',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(13),
                      ),
                    ),
                    SolidSmallButton(
                      isWhite: false,
                      title: 'Sign in',
                      onPressed: () {
                        login(_emailController.text, _passwordController.text);
                      },
                    ),
                  ],
                ),
               Padding(
                 padding: EdgeInsets.only(top:280.h),
                 child: College())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
