import 'package:ant_icons/ant_icons.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compileanywhere/ui/models/usermodels.dart';
import 'package:compileanywhere/ui/views/commentsPage.dart';
import 'package:compileanywhere/ui/views/playground_senthiil.dart';
import 'package:compileanywhere/ui/widgets/background_box.dart';
import 'package:compileanywhere/ui/widgets/localwidgets.dart';
import 'package:compileanywhere/ui/widgets/show_error.dart';
import 'package:compileanywhere/ui/widgets/transparentappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ProgramView extends StatefulWidget {
  final DocumentSnapshot document;
  ProgramView({Key key, @required this.document}) : super(key: key);
  @override
  _ProgramViewState createState() => _ProgramViewState(this.document);
}

class _ProgramViewState extends State<ProgramView> {
  final DocumentSnapshot document;
  _ProgramViewState(this.document);

  _increment() {
    print('i got clicked');
    Firestore.instance.runTransaction((transaction) async {
      DocumentSnapshot freshSnap = await transaction.get(document.reference);
      await transaction.update(freshSnap.reference, {
        'likes': freshSnap['likes'] + 1,
      });
    });
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      showError('assets/images/iconImg/sad_face.png',
          "YouTube url insn't provided", context);
    }
  }

  bool icons = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _coments;
  String _commments;

  postComment() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // print(_coments);

      try {
        Firestore.instance.collection('comments').add({
          'avatar_link': UserDetails().profilepic,
          'creation_date': DateTime.now(),
          'userName': UserDetails().username,
          'comments': _coments,
          'programId': document.documentID
        });
        Navigator.of(context).pop();
      } catch (e) {}
    }
  }

  List<String> _comments = [];
  void _addComment(String val) {
    setState(() {
      print('inside the set state::::::::::::::::::::::::::');
      _comments.add(val);
      postComment();
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(this.document.documentID + 'ashikkkkk');
    return BackgroundBox(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: Icon(
          Icons.menu,
          color: Color(0xff7277F1),
          size: ScreenUtil().setSp(24),
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          showDialog(
              barrierColor: null,
              // barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Stack(
                    // alignment: Alignment.bottomRight,
                    // fit:StackFit.loose,

                    children: [
                      // SizedBox(height: 640.h,width: 360.w,
                      // ),
                      Positioned(
                        bottom: 50.h,
                        left: 138.w,
                        child: LimitedBox(
                          maxHeight: 216.h,
                          maxWidth: 240.w,
                          child: Dialog(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.h),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff5254d8),
                                borderRadius: BorderRadius.circular(8.h),
                              ),
                              child: SizedBox(
                                width: 16.w,
                                height: 300.h,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 16.h,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      PopButton(
                                        iconn: Icons.input,
                                        onTap: () {
                                          _settingModalBottomSheetforInput(
                                              context);
                                        },
                                        title: 'Input',
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _settingModalBottomSheetforOutput(
                                              context);
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                                height: 24.h,
                                                child: Image.asset(
                                                    'assets/output.png')),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Text(
                                              ' Output',
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PopButton(
                                        iconn: Icons.play_arrow,
                                        onTap: () {},
                                        title: 'Run',
                                      ),
                                      PopButton(
                                        iconn: AntIcons.youtube_outline,
                                        onTap: () {
                                          _launchInBrowser(document['youtube']);
                                        },
                                        title: 'YouTube',
                                      ),
                                      PopButton(
                                        iconn: Icons.chat_bubble_outline,
                                        onTap: () {
                                          _settingModalBottomSheet(context);
                                        },
                                        title: 'Q&A',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]);
              });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      resizeToAvoidBottomInset: true,
      appBar: TransparentAppBar(
        title: "Program",
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(width: 360.w),
            SizedBox(
              width: 328.w,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 56.h,
                      child: Align(
                        alignment: Alignment.center,
                        child: ListTile(
                          leading: FittedBox(
                            child: CircularProfileAvatar(
                              null,
                              child: Image(
                                image:
                                    NetworkImage(document['Profile_pic_url']),
                              ),
                              borderColor: Color(0xFF7277F1),
                              borderWidth: ScreenUtil().setSp(1),
                              radius: ScreenUtil().setSp(36),
                            ),
                          ),
                          title: RichText(
                            text: TextSpan(
                              text: document['UserName'],
                              style: GoogleFonts.poppins(
                                color: Color(0xFF333333),
                                fontSize: ScreenUtil().setSp(13),
                              ),
                              children: [
                                TextSpan(
                                  text: '  last updated on',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF828282),
                                    fontSize: ScreenUtil().setSp(9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Text(
                            document['Date'],
                            // "here the time vll come",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF4f4f4f),
                              fontSize: ScreenUtil().setSp(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(0xFF7277f1),
                      thickness: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.all(ScreenUtil().setSp(16)),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Title',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF828282),
                                fontSize: ScreenUtil().setSp(8),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 4.h, 0, 16.h),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                // document['title'],
                                document['Lab'],

                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF333333),
                                  fontSize: ScreenUtil().setSp(12),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Description',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF828282),
                                fontSize: ScreenUtil().setSp(8),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                // document['description'],
                                document['Program_Description'],
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF333333),
                                  fontSize: ScreenUtil().setSp(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 74.h,
                // maxHeight: 504.h,
              ),
              child: SizedBox(
                width: 328.w,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: EdgeInsets.all(ScreenUtil().setSp(16)),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Code',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF828282),
                              fontSize: ScreenUtil().setSp(10),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: ScreenUtil().setSp(4.h)),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              document['Program_Code'],

                              // 'program vll come here',
                              style: GoogleFonts.sourceCodePro(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF333333),
                                  fontSize: ScreenUtil().setSp(14)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    //  DocumentSnapshot document;
    // _settingModalBottomSheet(document);
    Firestore db = Firestore.instance;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          // print("eeeeeeeeeeeeee");

          print(document.documentID + "document.doc id it seems");
          return Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: _formKey,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 22.0.w,
                        top: 10.h,
                      ),
                      child: Text(
                        'Q&A',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Color(0xff4740e8),
                          fontSize: ScreenUtil().setSp(18),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 28.0.w, top: 10.h),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xff4740e8),
                          size: ScreenUtil().setSp(28),
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Color(0xff4740e8),
                  thickness: 1,
                ),
                Expanded(
                  child:
                      // _buildCommentList(),
                      StreamBuilder(
                    stream: db
                        .collection('comments')
                        .orderBy('creation_date', descending: true)
                        .where('programId', isEqualTo: document.documentID)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: Text('Be the first one to add comment'));
                      }
                      print('stream builer::::::::::::::::::::::::::::::');
                      return Container(
                        child: ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) => GestureDetector(
                              onTap: () {},
                              child: Commment(
                                userName: snapshot.data.documents[index]
                                    ['userName'],
                                comment: snapshot.data.documents[index]
                                    ['comments'],
                                avatar: snapshot.data.documents[index]
                                    ['avatar_link'],
                              )),
                        ),
                      );
                    },
                  ),
                ),
                TextFormField(
                  // onFieldSubmitted:postComment(),
                  onFieldSubmitted: (String submittedStr) {
                    _addComment(submittedStr);
                  },

                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20),
                      hintText: "Add coment",
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.black,
                      )),
                  validator: (input) {
                    if (input.isEmpty) {
                      print(input);
                      return 'Provide a coment ';
                    }
                  },
                  onSaved: (input) => _coments = input,
                )

                // RaisedButton(onPressed: postComment(),
                // child: Text('done'),

                // )
              ]),
            ),
          );
        });
  }

  void _settingModalBottomSheetforOutput(context) {
    //  DocumentSnapshot document;
    // _settingModalBottomSheetforOutput(document);
    Firestore db = Firestore.instance;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          // print("eeeeeeeeeeeeee");

          print(document.documentID);
          return Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: _formKey,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 22.0.w,
                        top: 10.h,
                      ),
                      child: Text(
                        'Sample Output',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Color(0xff4740e8),
                          fontSize: ScreenUtil().setSp(18),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 28.0.w, top: 10.h),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xff4740e8),
                          size: ScreenUtil().setSp(28),
                        ),
                      ),
                    )
                  ],
                ),

                // _buildCommentList(),
                Text(document["Program_Output"]),
              ]),
            ),
          );
        });
  }

  void _settingModalBottomSheetforInput(context) {
    //  DocumentSnapshot document;
    // _settingModalBottomSheetforOutput(document);
    Firestore db = Firestore.instance;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          // print("eeeeeeeeeeeeee");

          print(document.documentID);
          return Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: _formKey,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 22.0.w,
                        top: 10.h,
                      ),
                      child: Text(
                        'Sample Input',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Color(0xff4740e8),
                          fontSize: ScreenUtil().setSp(18),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 28.0.w, top: 10.h),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xff4740e8),
                          size: ScreenUtil().setSp(28),
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Color(0xff4740e8),
                  thickness: 1,
                ),
                Expanded(
                    child:
                        // _buildCommentList(),
                        Text(document["Program_Input"])),
              ]),
            ),
          );
        });
  }
}

class Commment extends StatelessWidget {
  final String userName, comment, avatar;

  const Commment({Key key, this.userName, this.comment, this.avatar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("inside the comments");
    return Column(
      children: [
        Column(children: [
          ListTile(
            leading: CircularProfileAvatar(
              null,
              child: Image(
                image: NetworkImage(avatar),
              ),
              borderColor: Color(0xFF7277F1),
              borderWidth: ScreenUtil().setSp(1),
              radius: ScreenUtil().setSp(26),
            ),
            title: Row(
              children: [
                Text(
                  'Posted by  ',
                  style: GoogleFonts.poppins(
                      fontSize: ScreenUtil().setSp(13),
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  userName,
                  style: GoogleFonts.poppins(
                      fontSize: ScreenUtil().setSp(13),
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            subtitle: Align(
              alignment: Alignment.topLeft,
              child: Text(
                comment,
                style: GoogleFonts.poppins(
                    fontSize: ScreenUtil().setSp(13),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ]),
        Divider(
          color: Color(0xFF7277f1),
          thickness: 1,
        ),
      ],
    );
  }
}

class PopButton extends StatelessWidget {
  final Function onTap;
  final IconData iconn;
  final String title;

  const PopButton({Key key, this.onTap, this.iconn, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            iconn,
            color: Colors.white,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
