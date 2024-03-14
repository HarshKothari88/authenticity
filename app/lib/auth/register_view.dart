import 'package:authenticity/auth/auth_controller.dart';
import 'package:authenticity/themes.dart';
import 'package:authenticity/utility/app_bar_widget.dart';
import 'package:authenticity/utility/custom_sizebox.dart';
import 'package:authenticity/utility/primary_button.dart';
import 'package:authenticity/utility/snackbar.dart';
import 'package:gap/gap.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:authenticity/auth/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<AuthController>(AuthController());
    final regSteps = 1;
    return Scaffold(
      appBar: authentifyAppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(20),
                  Text(
                    'Register',
                    style: Get.theme.kMedTitleTextStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 20, left: 20, right: 20),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Get.theme.curveBG,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Form(
                            key: controller.formKey,
                            child: Column(
                              children: [
                                textField(
                                    validator: (v) {
                                      if (v!.isEmpty) {
                                        return 'Please enter your username';
                                      }
                                    },
                                    controller: controller.userName,
                                    icon: Icons.person,
                                    label: 'Username'),
                                textField(
                                    validator: (v) {
                                      if (v!.isEmpty) {
                                        return 'Please enter your Email address';
                                      }
                                    },
                                    controller: controller.emailAddress,
                                    icon: Icons.email_outlined,
                                    label: 'Email Address'),
                                textField(
                                    validator: (v) {
                                      if (v!.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                    },
                                    controller: controller.password,
                                    obscureText: true,
                                    icon: Icons.key_rounded,
                                    label: 'Password'),
                                textField(
                                    validator: (v) {
                                      if (v!.isEmpty) {
                                        return 'Please confirm your password';
                                      }
                                    },
                                    controller: controller.confirmPassword,
                                    obscureText: true,
                                    icon: Icons.lock_rounded,
                                    label: 'Confirm Password'),
                                const Gap(20),
                                primaryButton(
                                    label: 'Register',
                                    icon: Icons.login_rounded,
                                    onTap: () {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        if (controller.password.text !=
                                            controller.confirmPassword.text) {
                                          setSnackBar("ERROR:",
                                              "Passwords do not match");
                                          debugPrint(
                                              "${controller.password.text} != ${controller.confirmPassword.text}");
                                        } else {
                                          controller.register();
                                        }
                                      }
                                    }),
                                const Gap(20),
                              ],
                            )),
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}
