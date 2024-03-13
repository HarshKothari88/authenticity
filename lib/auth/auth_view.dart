import 'package:authenticity/themes.dart';
import 'package:authenticity/utility/app_bar.dart';
import 'package:authenticity/utility/primary_button.dart';
import 'package:authenticity/utility/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authentifyAppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Gap(50),
            SvgPicture.asset(
              'assets/images/obj.svg',
              height: 300,
            ),
            Text(
              "Let's get started!",
              style: Get.theme.kTitleTextStyle,
            ),
            const Gap(30),
            primaryButton(
                label: 'Login to your account',
                icon: Icons.login_rounded,
                
                onTap: () => {}),
            secondaryButton(
                label: 'Sign up',
                icon: Icons.create,
                onTap: () => {}),
          ],
        ),
      )),
    );
  }
}
