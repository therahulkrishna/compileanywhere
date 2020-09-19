import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TransparentAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TransparentAppBar(
      {Key key, this.title, this.actionIcon, this.actionOnPressed})
      : super(key: key);
  @required
  final String title;
  final Function actionOnPressed;
  final IconData actionIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      centerTitle: true,
      toolbarHeight: 56.h,
      title: Text(
        title,
        // overflow: TextOverflow.visible,
         overflow: TextOverflow.visible,
        style: GoogleFonts.poppins(
          fontSize: ScreenUtil().setSp(24),
          fontWeight: FontWeight.w600,
        ),
      
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: IconButton(
            icon: Icon(
              actionIcon,
            ),
            onPressed: actionOnPressed,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}