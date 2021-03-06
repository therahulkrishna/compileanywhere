import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:compileanywhere/ui/widgets/localwidgets.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(        
          child: Stack(children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF5254D8), Color(0xFF1DA1F2)])),
        ),
      
                  Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 240.h),
          
          child: Container(
            decoration: new BoxDecoration(
                image:
                    DecorationImage(image: new AssetImage("assets/Logo1.png"))),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(42.w, 335.h, 0, 0),
          child: Text(
            "Let's get started",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w100,
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(74.w, 460.h, 0, 10.h),
          child: OutlineButton(
            padding: EdgeInsets.fromLTRB(88, 8, 88, 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            child: Text(
              'Sign in',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              Navigator.pushNamed(context, "/login");
            },
            borderSide: BorderSide(
              color: Colors.white,
              style: BorderStyle.solid,
              width: 2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(74.w, 510.h, 0, 10.h),
          child: RaisedButton(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(88, 8, 88, 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: Text(
              'Sign up',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        Positioned(
          top:600.h,left:63.w,
          child: College(),
        ),
      ])),
    );
  }
}
