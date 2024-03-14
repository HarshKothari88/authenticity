import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar authentifyAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: SvgPicture.asset("assets/authetify_logo.svg"),
    centerTitle: true,
    flexibleSpace: ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: Colors.transparent,
        ),
      ),
    ),
  );
}
