// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

extension ThemeExtension on ThemeData {
  Color get colorPrimary => brightness == Brightness.dark
      ? Color(0xD994B1F4)
      : Color.fromARGB(255, 1, 121, 173);
  Color get colorPrimaryDark => brightness == Brightness.dark
      ? const Color(0xff1F55D7)
      : const Color(0xff1F55D7);
  Color get colorSecondary => brightness == Brightness.dark
      ? const Color(0xD5A8E5F1)
      : const Color(0xff03DB40);
  Color get colorSecondaryDark => brightness == Brightness.dark
      ? const Color(0xff46E0FE)
      : Color.fromARGB(255, 2, 84, 25);
  Color get textColor => brightness == Brightness.dark
      ? const Color.fromARGB(255, 0, 29, 98)
      : Color.fromARGB(255, 0, 5, 16);
  Color get colorAccent => brightness == Brightness.dark
      ? const Color(0xffFFBE55)
      : const Color(0xffFFBE55);
  Color get green => brightness == Brightness.dark
      ? const Color(0xff04EF47)
      : const Color(0xff04EF47);
  Color get adColor => brightness == Brightness.dark
      ? const Color(0xff000000)
      : const Color(0xffffffff);
  Color get dayNight => brightness == Brightness.dark
      ? const Color(0xffffffff)
      : const Color(0xff000000);
  Color get btnTextCol => brightness == Brightness.dark
      ? const Color(0xe8e9e9e9)
      : const Color(0xff494646);
  Color get menu_opener_color => brightness == Brightness.dark
      ? const Color(0xe2232323)
      : const Color(0xe3e3e3e3);
  Color get sheetColor => brightness == Brightness.dark
      ? const Color(0xff232323)
      : const Color(0xf0ffffff);
  Color get curveBG => brightness == Brightness.dark
      ? const Color(0x8D4A4A48)
      : Color.fromARGB(180, 237, 237, 237);
  Color get barrierColor => brightness == Brightness.dark
      ? const Color(0xA4353534)
      : const Color(0xA4353534);
  Color get mainGStartCol => const Color(0xff66DA40);
  Color get mainGEndCol => const Color(0xff0F9FCF);

  Color get materialColor2 => const Color(0xff9BF6FF);
  Color get materialColorDark2 => const Color(0xff006670);
  Color get materialColor3 => const Color(0xffA0C4FF);
  Color get materialColorDark3 => const Color(0xff013180);
  Color get materialColor4 => const Color(0xffbdb2ff);
  Color get materialColorDark4 => const Color(0xff42368a);
  Color get materialColor5 => const Color(0xffFFC6FF);
  Color get materialColorDark5 => const Color(0xff800180);
  Color get materialColor6 => const Color(0xffFFADAD);
  Color get materialColorDark6 => const Color(0xff873232);
  Color get materialColor7 => const Color(0xffFFD6A5);
  Color get materialColorDark7 => const Color(0xff785123);
  Color get materialColor8 => const Color(0xfff6f8ba);
  Color get materialColorDark8 => const Color(0xff8E9200);
  Color get materialColor9 => const Color(0xfff694c1);
  Color get materialColorDark9 => const Color(0xff8c0342);

  TextStyle get kTitleTextStyle => GoogleFonts.poppins(
      fontWeight: FontWeight.w700, color: btnTextCol, fontSize: 25);
  TextStyle get kSubTitleTextStyle => GoogleFonts.poppins(
      fontSize: 17, color: btnTextCol, fontWeight: FontWeight.w700);
  TextStyle get kMedTitleTextStyle => GoogleFonts.poppins(
      fontSize: 22, color: btnTextCol, fontWeight: FontWeight.w700);
  TextStyle get kSmallTextStyle =>
      GoogleFonts.poppins(fontWeight: FontWeight.w700, color: btnTextCol);
  TextStyle get kVerySmallTextStyle => GoogleFonts.poppins(
      fontWeight: FontWeight.w700, color: btnTextCol, fontSize: 12);
  TextStyle get kBigTextStyle => GoogleFonts.poppins(
      fontWeight: FontWeight.w800, color: btnTextCol, fontSize: 35);
}

class Themes {
  static final light = ThemeData.light().copyWith(
    // backgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xf2161616),
            statusBarIconBrightness: Brightness.light)),
    scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
    // textTheme: TextTheme(headline1: GoogleFonts.quicksand(fontSize: 18,fontWeight: FontWeight.w800,color: Theme.of(context).btnTextCol),headline2: GoogleFonts.quicksand(fontSize: 16,fontWeight: FontWeight.w600),headline3: GoogleFonts.quicksand(fontSize: 14,fontWeight: FontWeight.w600))
  );
  static final dark = ThemeData.dark().copyWith(
    // backgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xf2161616),
            statusBarIconBrightness: Brightness.light)),
    scaffoldBackgroundColor: const Color(0xff161616),
  );
}
