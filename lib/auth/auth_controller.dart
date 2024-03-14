import 'dart:convert';
import 'package:authenticity/utility/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final loginKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final emailAddress = TextEditingController();

  // Future<void> login() async {
  //   final dio = Dio();
  //   try {
  //     final data = UserData(
  //       email: emailAddress.text,
  //       password: password.text,
  //     );
  //     final apiUrl = "${Globals.APIURL}/login";
  //     final response = await dio
  //         .post(apiUrl, data: {"email": data.email, "password": data.password});
  //     debugPrint(response.toString());
  //     if (response.statusCode == 200) {
  //       var responseBody = response.data;
  //       var userId = responseBody['data']['uid'];
  //       GetStorage().write('userId', userId);
  //       debugPrint(responseBody.toString());
  //       setSnackBar("SUCCESS:", responseBody['message']);
  //       Get.off(() => const HomePageScreen());
  //     } else {
  //       setSnackBar("ERROR:", response.data['message']);
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     rethrow;
  //   }
  // }

  Future<void> login(String email, String password) async {
    String baseUrl = 'https://authentify-e7be.onrender.com/api/auth/';
    String endpoint = 'login';
    String apiUrl = '$baseUrl$endpoint';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    // Construct the request body
    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };

    try {
      http
          .post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      )
          .then((response) {
        // Parse the response JSON
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        // Check for success and handle the response accordingly
        if (response.statusCode == 200) {
          print('API request successful: ${responseBody['message']}');
        } else {
          print('API request failed: ${responseBody['message']}');
        }

        bottomSheet(
            //package added to dependencies and imported, but not running
            context, //Should I pass BuildContext to the login function
            Column(
              children: [
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(responseBody['message'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                const Gap(20),
                button(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => landingpage()),
                      );
                    },
                    text: "Okay!",
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.8)
              ],
            ));
      });
    } catch (e) {
      print('Error during API request: $e');
    }
  }

  Future<void> register(String username, String email, String password) async {
    String baseUrl = 'https://authentify-e7be.onrender.com/api/auth/';
    String endpoint = 'register';
    String apiUrl = '$baseUrl$endpoint';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    // Construct the request body
    Map<String, dynamic> requestBody = {
      'username': username,
      'email': email,
      'password': password,
      'cpassword': password,
    };

    try {
      http
          .post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      )
          .then((response) {
        // Parse the response JSON
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        // Check for success and handle the response accordingly
        if (response.statusCode == 200) {
          print('API request successful: ${responseBody['message']}');
        } else {
          print('API request failed: ${responseBody['message']}');
        }

        bottomSheet(
            //package added to dependencies and imported, but not running
            context, //Should I pass BuildContext to the login function
            Column(
              children: [
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(responseBody['message'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                const Gap(20),
                button(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => landingpage()),
                      );
                    },
                    text: "Okay!",
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.8)
              ],
            ));
      });
    } catch (e) {
      print('Error during API request: $e');
    }
  }
}
