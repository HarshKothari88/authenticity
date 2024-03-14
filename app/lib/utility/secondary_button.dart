import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:authenticity/themes.dart';

Widget secondaryButton(
    {required String label,
    required IconData icon,
    required VoidCallback onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
    child: TextButton.icon(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(15),
        fixedSize: Size.fromWidth(Get.size.width),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Get.theme.colorSecondary,
      ),
      icon: Icon(
        icon,
        // color: Colors.white,
      ),
      label: Text(
        label,
        style: GoogleFonts.quicksand(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    ),
  );
}
