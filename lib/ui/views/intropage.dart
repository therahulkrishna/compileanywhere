import 'package:flutter/material.dart';
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
          padding: EdgeInsets.all(329.7),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF5254D8), Color(0xFF1DA1F2)])),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 290),
          child: Container(
            decoration: new BoxDecoration(
                image:
                    DecorationImage(image: new AssetImage("assets/Logo1.png"))),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(58, 340, 0, 0),
          child: Text(
            "Let' get started",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w100,
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(92, 490, 0, 10),
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
              Navigator.pushReplacementNamed(context, "/login");
            },
            borderSide: BorderSide(
              color: Colors.white,
              style: BorderStyle.solid,
              width: 2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(92, 552, 0, 10),
          child: RaisedButton(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(88, 8, 88, 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            onPressed: () {
              // Navigator.pushNamed(context, "/lop1");
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
        College(),
      ])),
    );
  }
}
