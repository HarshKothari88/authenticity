import 'package:authenticity/themes.dart';
import 'package:authenticity/utility/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CompletedView extends StatelessWidget {
  const CompletedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authentifyAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Congratulations!',
                style: Get.theme.kTitleTextStyle,
              ),
              const SizedBox(height: 20),
              Lottie.asset(
                "assets/images/success.json",
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'You have completed the KYC process successfully!\n\nWe will notify you once your account is verified.',
                    style: Get.theme.kSubTitleTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
