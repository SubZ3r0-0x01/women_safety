// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final VoidCallback onPressed;
  final double fontSize;

  // Constructor for CustomAppbar
  CustomAppbar({
    super.key,
    required this.text,
    required this.onPressed,
    this.fontSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: onPressed,
      ),
      title: Text(
        text,
        style: GoogleFonts.urbanist(
          textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
