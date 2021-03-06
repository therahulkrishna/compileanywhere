import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  bool isSignedIn;
  String uId;

  @override
  void initState() {
    isSignedIn = false;
    super.initState();
    checkAuthentication();
    // getUser();
  }

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((event) {
      if (event == null) {
        Navigator.pushReplacementNamed(context, '/splashscreen');
      }else{
        Navigator.pushReplacementNamed(context,'/lop');
      }
    });
  }

  // getUser() async {
  //   FirebaseUser firebaseUser = await _auth.currentUser();
  //   await firebaseUser?.reload();
  //   firebaseUser = await _auth.currentUser();

  //   if (firebaseUser != null) {
  //     setState(() {
  //       this.user = firebaseUser;
  //       this.isSignedIn = true;
  //       this.uId = user.uid;
  //     });
  //   }
  // }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: isSignedIn
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "welcome: " + user.displayName,
                    ),
                    Text(
                      "your id is " + this.uId,
                    ),
                    // RaisedButton(
                    //   onPressed: signOut,
                    //   child: Text('Signout'),
                    // )
                  ],
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
