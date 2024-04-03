import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../models/airtime_bundle_model.dart';
import '../../models/cable_model.dart';
import '../../models/electricity_model.dart';
import '../../models/register_model.dart';
import '../../screens/BottomNavigationScreens.dart';
import '../../models/airtime_model.dart';

class ApiProvider {
  final RegisterModel _registerModel = RegisterModel();
  final _username = Hive.box('username');

  // Future<Map<String, dynamic>> getAirtimeProviders() async {
  //   var url = 'http://3.138.63.43/api/vas/mobile-providers';
  //   var headers = {
  //     'content-Type': 'application/json',
  //     'Authorization': 'Bearer ${_username.get('usertoken')}'
  //   };
  //   var response = await http.get(Uri.parse(url), headers: headers);

  //   print(response.body);
  //   var jsonData = convert.jsonDecode(response.body) as Map<String, dynamic>;
  //   print(jsonData);
  //   print(jsonData['data'][0]['name']);
  //   print(_username.get('smile'));
  //   print(_username.get('9mobile'));
  //   print(_username.get('glo'));
  //   print(_username.get('airtel'));

  //   await _username.put('smile', jsonData['data'][0]['provider']);
  //   await _username.put('9mobile', jsonData['data'][2]['provider']);
  //   await _username.put('glo', jsonData['data'][3]['provider']);
  //   await _username.put('mtn', jsonData['data'][1]['provider']);
  //   await _username.put('airtel', jsonData['data'][4]['provider']);

  //   if (response.statusCode == 200) {
  //     return jsonData;
  //   } else {
  //     throw Exception('Failed to load Api Data');
  //   }
  // }

  // seperate

//   final queryParameters = {
//   'param1': 'one',
//   'param2': 'two',
// };
// final uri =
//     Uri.https('www.myurl.com', '/api/v1/test', queryParameters);
// final response = await http.get(uri, headers: {
//   HttpHeaders.authorizationHeader: 'Token $token',
//   HttpHeaders.contentTypeHeader: 'application/json',
// });

// seperate

// var endpointUrl = 'https://www.myurl.com/api/v1/user';
// Map<String, String> queryParams = {
//   'param1': '1',
//   'param2': '2'
// };

// var headers = {
//   HttpHeaders.authorizationHeader: 'Token $token',
//   HttpHeaders.contentTypeHeader: 'application/json',
// }

// String queryString = Uri.parse(queryParameters: queryParams).query;

// var requestUrl = endpointUrl + '?' + queryString; // result - https://www.myurl.com/api/v1/user?param1=1&param2=2
// var response = await http.get(requestUrl, headers: headers);

  Future<AirtimeProviderModel> getAirtimeProviders() async {
    var url = 'http://3.138.63.43/api/vas/mobile-providers';
    var headers = {
      'content-Type': 'application/json',
      'Authorization': 'Bearer ${_username.get('usertoken')}'
    };
    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);
    var jsonData = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print(jsonData);
    print(jsonData['data'][0]['name']);
    print(_username.get('smile'));
    print(_username.get('9mobile'));
    print(_username.get('glo'));
    print(_username.get('airtel'));

    await _username.put('smile', jsonData['data'][0]['provider']);
    await _username.put('9mobile', jsonData['data'][2]['provider']);
    await _username.put('glo', jsonData['data'][3]['provider']);
    await _username.put('mtn', jsonData['data'][1]['provider']);
    await _username.put('airtel', jsonData['data'][4]['provider']);

    if (response.statusCode == 200) {
      return AirtimeProviderModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load Api Data');
    }
  }

  Future<CableProviderModel> getCableProviders() async {
    var url = 'http://3.138.63.43/api/vas/cable-providers';
    var headers = {
      'content-Type': 'application/json',
      'Authorization': 'Bearer ${_username.get('usertoken')}'
    };
    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);
    var jsonData = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print(jsonData);

    await _username.put('gotv', jsonData['data'][0]['provider']);
    await _username.put('startimes', jsonData['data'][1]['provider']);
    await _username.put('dstv', jsonData['data'][2]['provider']);

    if (response.statusCode == 200) {
      return CableProviderModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load Api Data');
    }
  }

  Future<AirtimeBundleModel> getBundleProviders(provider) async {
    // Define the base endpoint (URL)
    final String endpoint = "http://3.138.63.43/api/vas/bundle-plans";
    final Map<String, dynamic> queryParams = {
      'provider': provider,
    };

    // Create a Uri object with the endpoint and query parameters
    final Uri uri = Uri.parse(endpoint).replace(queryParameters: queryParams);

    var headers = {
      'content-Type': 'application/json',
      'Authorization': 'Bearer ${_username.get('usertoken')}'
    };
    // var response = await http.get(Uri.parse(url), headers: headers);
    var response = await http.get(uri, headers: headers);

    // print(response.body);
    var jsonData = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print(jsonData['data']);
    for (var plan in jsonData['data']) {
//     print("Name: ${plan["name"]}");

      final dataPlan = plan["name"];
      print(" my network plan is ${dataPlan}");
    }

    List<dynamic> names = jsonData['data'].map((plan) => plan["name"]).toList();

    print(names);
    // print(jsonData['data']['name']);

    if (response.statusCode == 200) {
      return AirtimeBundleModel.fromJson(jsonData);
    } else {
      // Check to know if a device has an internet connection
      //     final hasInternet = await InternetConnectivity().hasInternetConnection;
      // if (hasInternet) {
      //   //You are connected to the internet
      // } else {
      //   //"No internet connection
      // }

      // Listen to internet connection changes via stream

      //     final subscription =
      //     InternetConnectivity().observeInternetConnection.listen((bool hasInternetAccess) {
      //       if(!hasInternetAccess){
      //         showToast('No Internet Connection');
      //       }
      //     });

      //  await Future.delayed(const Duration(seconds: 10 ));
      //  subscription.cancel();
      throw Exception('Failed to load Api Data');
    }
  }

  Future<ElecticityModel> getElectricityProviders() async {
    // Define the base endpoint (URL)
    final String endpoint = "http://3.138.63.43/api/vas/electricity-providers";
    // final Map<String, dynamic> queryParams = {
    //   'provider': provider,
    // };

    // Create a Uri object with the endpoint and query parameters
    final Uri uri = Uri.parse(endpoint);

    var headers = {
      'content-Type': 'application/json',
      'Authorization': 'Bearer ${_username.get('usertoken')}'
    };
    // var response = await http.get(Uri.parse(url), headers: headers);
    var response = await http.get(uri, headers: headers);

    print(response.body);
    var jsonData = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print(jsonData);
    _username.put("abuja electric postpaid", jsonData['data'][0]['provider']);
    _username.put("abuja electric prepaid", jsonData['data'][1]['provider']);
    _username.put("eko electric postpaid", jsonData['data'][2]['provider']);
    _username.put("eko electric prepaid", jsonData['data'][3]['provider']);
    _username.put("enugu electric postpaid", jsonData['data'][4]['provider']);
    _username.put("enugu electric prepaid", jsonData['data'][5]['provider']);
    _username.put("ibadan electric postpaid", jsonData['data'][6]['provider']);
    _username.put("ibadan electric prepaid", jsonData['data'][7]['provider']);
    _username.put("ikeja electric postpaid", jsonData['data'][8]['provider']);
    _username.put("ikeja electric prepaid", jsonData['data'][9]['provider']);
    _username.put("jos electric postpaid", jsonData['data'][10]['provider']);
    _username.put("jos electric prepaid", jsonData['data'][11]['provider']);
    _username.put("kaduna electric prepaid", jsonData['data'][12]['provider']);
    _username.put("kedco electric postpaid", jsonData['data'][13]['provider']);
    _username.put("kedco electric prepaid", jsonData['data'][14]['provider']);
    _username.put(
        "portharcourt electric postpaid", jsonData['data'][15]['provider']);
    _username.put(
        "portharcourt electric prepaid", jsonData['data'][16]['provider']);

    if (response.statusCode == 200) {
      return ElecticityModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load Api Data');
    }
  }

  Future registerUser(
    name,
    email,
    password,
    comfirmPassword,
  ) async {
    // error widget
    Future showErrorMessage(String message) async {
      Get.bottomSheet(
        Container(
          height: 400,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
      });
    }

    Future showSnackErrorMessage(String message) async {
      Get.snackbar(
        '',
        '',
        titleText: Center(
            child: Text(
          '\n${message}',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        backgroundColor: Colors.red.shade400,
        // colorText: Colors.white,
        // // borderColor: Colors.amber,

        // borderRadius: 10,
        // boxShadows: [
        //   BoxShadow(
        //     color: Colors.blue,
        //     offset: Offset(10, 10),
        //   )
        // ],
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

    void showSnackSuccessMessage(String message) {
      Get.snackbar(
        '',
        message,
        // titleText: Text(message),
        backgroundColor: Colors.green,
      );
      Future.delayed(Duration(seconds: 2), () {
        // Navigator.pop(context!);
        // PageNavigator(ctx: context).nextPageOnly(page: const SixthPage());
        Get.back();
        Get.off(() => BottomNavigationScreens());
      });
    }

    // API endPoint URL
    var url = Uri.parse('http://3.138.63.43/api/register');
    // http://3.138.63.43

// Request body
    var requestBody = {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": comfirmPassword,
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

    var responseData = convert.jsonDecode(response.body);
    print(responseData['Data']);

    // checking response status

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = convert.jsonDecode(response.body);

      print(responseData);
      _username.put('name', responseData['data']['name']);
      // _username.put('email', _registerModel.data!.email);
      _username.put('id', responseData['data']['id']);
      print(_username.get('email'));
      print(_username.get('name'));

      print(Text('post request successful${responseData['message']}'));
      print('Request failed with status: ${response.statusCode}');
      showSnackSuccessMessage('${responseData['message']}');
    } else {
      var responseData = convert.jsonDecode(response.body);
      print('Request failed with status: ${response.statusCode}');
      showSnackErrorMessage('${responseData['message']}');
      print('error${responseData['message']}');
    }
  }

  // login User

  Future LoginUser(
    email,
    password,
  ) async {
    Future showSnackErrorMessage(String message) async {
      Get.snackbar(
        '',
        '',
        titleText: Center(
            child: Text(
          '\n${message}',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        backgroundColor: Colors.red.shade400,
      );
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
      });
    }

    void showSnackSuccessMessage(String message) {
      Get.snackbar(
        '',
        '',
        titleText: Center(
            child: Text(
          '\n${message}',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        backgroundColor: Colors.green,
      );
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
        Get.off(() => BottomNavigationScreens());
      });
    }

    // API endPoint URL
    var url = Uri.parse('http://3.138.63.43/api/login');

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

      // print(responseData);
      print(responseData['data']['access_token']);

      print(responseData['data']['user']['name']);
      print(responseData['data']['user']['email']);

      await _username.put('usertoken', responseData['data']['access_token']);
      await _username.put('name', responseData['data']['user']['name']);
      print(_username.get('usertoken'));
      print(_username.get('name'));

      print(Text('post request successful${responseData['message']}'));
      print('Request failed with status: ${response.statusCode}');
      showSnackSuccessMessage('${responseData['message']}');
    } else {
      print('Request failed with status: ${response.statusCode}');
      var responseData = convert.jsonDecode(response.body);
      showSnackErrorMessage('${responseData['message']}');
      print('error');
    }
  }

  // forgotPassword

  Future ChangePassword(
    old_password,
    password,
    password_confirmation,
  ) async {
    Future showSnackErrorMessage(String message) async {
      Get.snackbar(
        '',
        '',
        titleText: Center(
            child: Text(
          '\n${message}',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        backgroundColor: Colors.red.shade400,
      );
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
      });
    }

    void showSnackSuccessMessage(String message) {
      Get.snackbar(
        '',
        '',
        titleText: Center(
            child: Text(
          '\n${message}',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        backgroundColor: Colors.green,
      );
      Future.delayed(Duration(seconds: 2), () {
        // Navigator.pop(context!);
        // PageNavigator(ctx: context).nextPageOnly(page: const SixthPage());
        Get.back();
        Get.off(() => BottomNavigationScreens());
      });
    }

    // API endPoint URL
    var url = Uri.parse('http://3.138.63.43/api/change-password');

// Request body
    var requestBody = {
      "old_password": old_password,
      "password": password,
      "password_confirmation": password_confirmation
    };

    // Encode requestBody as JSON or convert to JSON format

    var body2 = convert.jsonEncode(requestBody);
    print(body2);

    var headers = {
      'content-Type': 'application/json',
      // 'Authorization': 'bearer ${token}',
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

      // print(responseData);
      // print(Text('post request successful'));
      // print('Request failed with status: ${response.statusCode}');
      showSnackSuccessMessage('${responseData['message']}');
    } else {
      // print('Request failed with status: ${response.statusCode}');
      var responseData = convert.jsonDecode(response.body);
      showSnackErrorMessage('${responseData['message']}');
      // print('error');
    }
  }

  Future PurchaseAirtime(
    amount,
    phone_no,
    provider,
  ) async {
    Future showSnackErrorMessage(String message) async {
      Get.snackbar(
        '',
        '',
        titleText: Center(
            child: Text(
          '\n${message}',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        backgroundColor: Colors.red.shade400,
        // colorText: Colors.white,
        // // borderColor: Colors.amber,

        // borderRadius: 10,
        // boxShadows: [
        //   BoxShadow(
        //     color: Colors.blue,
        //     offset: Offset(10, 10),
        //   )
        // ],
      );
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
      });
    }

    void showSnackSuccessMessage(String message) {
      Get.snackbar(
        '',
        '',
        titleText: Center(
            child: Text(
          '\n${message}',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        backgroundColor: Colors.green,
      );
      Future.delayed(Duration(seconds: 2), () {
        // Navigator.pop(context!);
        // PageNavigator(ctx: context).nextPageOnly(page: const SixthPage());
        Get.back();
        Get.off(() => BottomNavigationScreens());
      });
    }

    // API endPoint URL
    var url = Uri.parse('http://3.138.63.43/api/vas/purchase-airtime');

// Request body
    var requestBody = {
      "amount": amount,
      "phone_no": phone_no,
      "provider": provider
    };

    // Encode requestBody as JSON or convert to JSON format

    var body2 = convert.jsonEncode(requestBody);
    print(body2);

    var headers = {
      'content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_username.get('usertoken')}'
    };

    // making post Request

    var response = await http.post(
      url,
      body: body2,
      headers: headers,
    );
    print(response.body);
    // checking response status

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = convert.jsonDecode(response.body);

      print(responseData);
      print(Text('post request successful'));
      print('Request failed with status: ${response.statusCode}');
      showSnackSuccessMessage('${responseData['message']}');
    } else {
      print('Request failed with status: ${response.statusCode}');
      var responseData = convert.jsonDecode(response.body);
      showSnackErrorMessage('${responseData['message']}');
      // print('error');
    }
  }

  Future PurchaseElectricity(
    provider,
    meter_number,
    amount,
  ) async {
    Future showSnackErrorMessage(String message) async {
      Get.snackbar(
        '',
        '',
        titleText: Center(
            child: Text(
          '\n${message}',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        backgroundColor: Colors.red.shade400,
        // colorText: Colors.white,
        // // borderColor: Colors.amber,

        // borderRadius: 10,
        // boxShadows: [
        //   BoxShadow(
        //     color: Colors.blue,
        //     offset: Offset(10, 10),
        //   )
        // ],
      );
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
      });
    }

    void showSnackSuccessMessage(String message) {
      Get.snackbar(
        '',
        '',
        titleText: Center(
            child: Text(
          '\n${message}',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        backgroundColor: Colors.green,
      );
      Future.delayed(Duration(seconds: 2), () {
        // Navigator.pop(context!);
        // PageNavigator(ctx: context).nextPageOnly(page: const SixthPage());
        Get.back();
        Get.off(() => BottomNavigationScreens());
      });
    }

    // API endPoint URL
    var url = Uri.parse('http://3.138.63.43/api/vas/purchase-electricity');

// Request body
    var requestBody = {
      "provider": provider,
      "meter_number": meter_number,
      'amount': amount,
    };

    // Encode requestBody as JSON or convert to JSON format

    var body2 = convert.jsonEncode(requestBody);
    print(body2);

    var headers = {
      'content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_username.get('usertoken')}'
    };

    // making post Request

    var response = await http.post(
      url,
      body: body2,
      headers: headers,
    );
    print(response.body);
    // checking response status

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = convert.jsonDecode(response.body);

      print(responseData);
      print(Text('post request successful'));
      print('Request failed with status: ${response.statusCode}');
      showSnackSuccessMessage('${responseData['message']}');
    } else {
      print('Request failed with status: ${response.statusCode}');
      var responseData = convert.jsonDecode(response.body);
      showSnackErrorMessage('${responseData['message']}');
      // print('error');
    }
  }

  Future PurchaseDataBundle(amount, phone_no, provider, plan) async {
    Future showSnackErrorMessage(String message) async {
      Get.snackbar(
        '',
        '',
        titleText: Center(
            child: Text(
          '\n${message}',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        backgroundColor: Colors.red.shade400,
        // colorText: Colors.white,
        // // borderColor: Colors.amber,

        // borderRadius: 10,
        // boxShadows: [
        //   BoxShadow(
        //     color: Colors.blue,
        //     offset: Offset(10, 10),
        //   )
        // ],
      );
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
      });
    }

    void showSnackSuccessMessage(String message) {
      Get.snackbar(
        '',
        '',
        titleText: Center(
            child: Text(
          '\n${message}',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        backgroundColor: Colors.green,
      );
      Future.delayed(Duration(seconds: 2), () {
        // Navigator.pop(context!);
        // PageNavigator(ctx: context).nextPageOnly(page: const SixthPage());
        Get.back();
        Get.off(() => BottomNavigationScreens());
      });
    }

    // API endPoint URL
    var url = Uri.parse('http://3.138.63.43/api/vas/purchase-data');

// Request body
    var requestBody = {
      "amount": amount,
      "phone_no": phone_no,
      "provider": provider,
      "plan": plan,
    };

    // Encode requestBody as JSON or convert to JSON format

    var body2 = convert.jsonEncode(requestBody);
    print(body2);

    var headers = {
      'content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_username.get('usertoken')}'
    };

    // making post Request

    var response = await http.post(
      url,
      body: body2,
      headers: headers,
    );
    print(response.body);
    // checking response status

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = convert.jsonDecode(response.body);

      print(responseData);
      print(Text('post request successful'));
      print('Request failed with status: ${response.statusCode}');
      showSnackSuccessMessage('${responseData['message']}');
    } else {
      print('Request failed with status: ${response.statusCode}');
      var responseData = convert.jsonDecode(response.body);
      showSnackErrorMessage('${responseData['message']}');
      // print('error');
    }
  }

  Future VerifyMeter(
    provider,
    meter_number,
  ) async {
    // API endPoint URL
    var url = Uri.parse("http://3.138.63.43/api/vas/verify-meter");

// Request body
    var requestBody = {
      "provider": provider,
      "meter_number": meter_number,
    };

    // Encode requestBody as JSON or convert to JSON format

    var body2 = convert.jsonEncode(requestBody);
    print(body2);

    var headers = {
      'content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_username.get('usertoken')}'
    };

    // making post Request

    var response = await http.post(
      url,
      body: body2,
      headers: headers,
    );
    print(response.body);
    // checking response status

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = convert.jsonDecode(response.body);

      print(responseData);
      print(Text('post request successful'));
      print('Request failed with status: ${response.statusCode}');
      await _username.put('meterName', responseData['data']['name']);
      print(_username.get('meterName'));
    } else {
      print('Request failed with status: ${response.statusCode}');
      var responseData = convert.jsonDecode(response.body);

      // print('error');
    }
  }
}
