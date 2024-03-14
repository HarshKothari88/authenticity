import 'package:authenticity/auth/auth_view.dart';
import 'package:authenticity/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>();
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return Scaffold(
      body: SafeArea(
          child: IntroductionScreen(
              key: introKey,
              // globalBackgroundColor: Colors.grey[900],
              dotsDecorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(20.0, 10.0),
                activeColor: Get.theme.colorPrimary,
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
              ),
              allowImplicitScrolling: true,
              //autoScrollDuration: 3000,
              showNextButton: false,
              done: Text("Done",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Get.theme.colorPrimary,
                  )),
              onDone: () {
                Get.off(() => const AuthView());
              },
              // onDone: () => Get.to(() => const UserAuthPage()),
              globalHeader: Align(
                alignment: Alignment.topLeft,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, left: 16),
                    child: Text("Authentify",
                        style: Get.theme.kTitleTextStyle
                            .copyWith(color: Get.theme.colorPrimary)),
                  ),
                ),
              ),
              pages: [
            PageViewModel(
              title: "Authentify",
              body: "Revolutionizing Online KYC Verification",
              image: SvgPicture.asset("assets/images/authentify_logo.svg"),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "AI Detetction",
              body:
                  "Utilizes advanced AI technology for accurate facial and biometric analysis, ensuring precise identity verification.",
              image: Lottie.asset('assets/images/ai_detection.json',
                  animate: true, width: 200, repeat: true),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Biometrics Authentication",
              body:
                  "Provides secure user verification through fingerprint scanning and voice recognition, enhancing security against identity fraud.",
              image: Lottie.asset('assets/images/biometric_authentication.json',
                  width: 200),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Multi-Language Support",
              body:
                  "Offers seamless communication in multiple languages including English, Hindi, Spanish, Mandarin, and Arabic.",
              image:
                  Lottie.asset('assets/images/multilanguage.json', width: 200),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Secure-Data Storage",
              body:
                  "Prioritizes user data security with advanced encryption and secure server infrastructure.",
              image: Lottie.asset('assets/images/secure_data_storage.json',
                  width: 200),
              decoration: pageDecoration,
            ),
          ])),
    );
  }
}
