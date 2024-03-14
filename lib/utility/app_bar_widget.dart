import 'dart:ui';

import 'package:authenticity/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

AppBar authentifyAppBar({bool center = false}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/authentify_logo.svg',
          height: 20,
        ),
        const Gap(10),
        Text(
          'Authentify',
          style: TextStyle(
              color: Get.theme.colorPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
      ],
    ),
    centerTitle: center,
    automaticallyImplyLeading: false,
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
