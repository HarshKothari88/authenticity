import 'dart:convert';
import 'package:authenticity/chat/chat_view.dart';
import 'package:authenticity/utility/bottom_sheet.dart';
import 'package:authenticity/utility/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:authenticity/utility/variables.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final loginKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final emailAddress = TextEditingController();

  final userName = TextEditingController();

  final dio = Dio();

  Future<void> login() async {
    try {
      final data = {
        'email': emailAddress.text,
        'password': password.text,
      };
      final apiUrl = "${Variables.baseUrl}/auth/login";
      final response = await dio.post(apiUrl, data: data);
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        var responseBody = response.data;
        // var userId = responseBody['dataRefObject'];
        // await GetStorage().write('userId', userId);
        await GetStorage().write('token', responseBody['token']);
        debugPrint(responseBody.toString());
        setSnackBar("SUCCESS:", responseBody['message']);
        Get.off(() => const ChatView());
      } else {
        setSnackBar("ERROR:", response.data['message']);
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> register() async {
    String baseUrl = "${Variables.baseUrl}/auth/register";
    final response = await dio.post(baseUrl, data: {
      'username': userName.text,
      'email': emailAddress.text,
      'password': password.text,
    });

    if (response.statusCode == 201) {
      var responseBody = response.data;
      setSnackBar("SUCCESS:", responseBody['message']);
      await GetStorage().write('token', responseBody['token']);
      Get.off(() => const ChatView());
    } else {
      setSnackBar("ERROR:", response.data['message']);
    }

    debugPrint(response.toString());
  }
}
