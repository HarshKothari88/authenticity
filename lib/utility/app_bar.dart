import 'package:authenticity/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar authentifyAppBar() {
  return AppBar(
    title: Text(
      'Authentify',
      style: Get.theme.kTitleTextStyle,
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
