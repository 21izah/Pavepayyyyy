import 'dart:io';

import 'package:flutter/material.dart';

import '../data/api_calls/jsonProvider.dart';

import 'package:get/get.dart';

import '../screens/BottomNavigationScreens.dart';
import '../screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SignUpProvider with ChangeNotifier {
  // final BuildContext context;
  // SignUPpage2Provider(this.context);

  // base Url if needed

  /// setters
  //track the loading state, it controls when data is to be called and when text is to change
  bool isLoading = false;

  // track the task Process
  bool isTaskComplete = false;

// track the error message, it determines what message to be shown
  String message = '';

  // getters

  // bool get _isLoading => _isLoading;
  // String get _notificationMessage => notificationMessage;

  // task functions

  Future LoginUser(
    email,
    password,
  ) async {
    void showSuccessMessage(String message) {
      Get.bottomSheet(
        Container(
          height: 400,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // SizedBox(
            //   height: 20,
            // ),
            Container(
              height: 200,
              width: double.maxFinite,
              child: Image.asset(
                'lib/assets/success.png',
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              message,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ]),
        ),
      );
      Future.delayed(Duration(seconds: 2), () {
        // Navigator.pop(context!);
        // PageNavigator(ctx: context).nextPageOnly(page: const SixthPage());
        Get.back();
        Get.off(() => BottomNavigationScreens());
      });
    }

    // API endPoint URL
    var url = Uri.parse('https://pave.ng/api/register');

// Request body
    var requestBody = {
      "email": email,
      "password": password,

      // "referral_code": referralcode
    };

    // Encode requestBody as JSON or convert to JSON format

    var body2 = convert.jsonEncode(requestBody);
    print(body2);

    var headers = {
      'content-Type': 'application/json',
      // 'Authorization': 'Bearer ${token}'
    };

    // making post Request

    var response = await http.post(
      url,
      body: body2,
      headers: headers,
    );

    // checking response status

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = convert.jsonDecode(response.body);

      print(responseData);
      print(Text('post request successful'));
      print('Request failed with status: ${response.statusCode}');
      showSuccessMessage('Success');
      // Get.off(() => BottomNavigationScreens());
    } else {
      print('Request failed with status: ${response.statusCode}');

      print('error');
    }
  }

  Future simulateSignUp({
    required String name,
    required String email,
    required String password,
    required String comfirmPassword,
    required String referralcode,
    BuildContext? context,
  }) async {
    // show circular progress indicator
    isLoading = true;
    notifyListeners();

    //
    void showErrorMessage(String message) {
      Get.bottomSheet(
        Container(
          height: 400,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 200,
              width: double.maxFinite,
              child: Image.asset(
                'lib/assets/warning.png',
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              message,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ]),
        ),
      );
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
      });
    }

    void showSuccessMessage(String message) {
      Get.bottomSheet(
        Container(
          height: 400,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // SizedBox(
            //   height: 20,
            // ),
            Container(
              height: 200,
              width: double.maxFinite,
              child: Image.asset(
                'lib/assets/success.png',
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              message,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ]),
        ),
      );
      Future.delayed(Duration(seconds: 2), () {
        // Navigator.pop(context!);
        // PageNavigator(ctx: context).nextPageOnly(page: const SixthPage());
        Get.back();
        Get.off(() => BottomNavigationScreens());
      });
    }

    try {
      if (password == comfirmPassword) {
        // post request for registration
        await ApiProvider().registerUser(
          name,
          email,
          password,
          comfirmPassword,
        );

        // Get.off(() => BottomNavigationScreens());
        isLoading = false;

        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        showErrorMessage("Password don't match");
        notifyListeners();
      }
    } on SocketException catch (e) {
      isLoading = false;
      notifyListeners();
      showErrorMessage(e.message);
      notifyListeners();
    }
  }
}
