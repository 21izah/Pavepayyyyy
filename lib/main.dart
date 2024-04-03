import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:hive_flutter/hive_flutter.dart";
import 'package:pave_day/providers/change_password_provider.dart';
import 'package:pave_day/providers/sign_up_provider.dart';
import 'package:provider/provider.dart';

import 'providers/airtime_provider.dart';
import 'providers/balance_obscure_provider.dart';
import 'providers/contactProvider.dart';
import 'providers/dataBundle_provider.dart';
import 'providers/electricity_provider.dart';
import 'providers/login_provider.dart';
import 'providers/navigation_service.dart';
import 'providers/purchase_dataBundle_provider.dart';
import 'providers/verifyMeter_provider.dart';
import 'screens/onboarding_page.dart';
import 'screens/onboarding_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('username');
  await Hive.openBox('mybox');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BalanceObscureProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignUpProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChangePasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AirtimeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ElectricityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VerifyMeterProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserNameProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PurchaseDataBundleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      navigatorKey: NavigatorKey.key,
      home: OnboardingScreen(),
    );
  }
}


// flutter build apk --split-per-abi
// flutter run --release

// https://pave.ng/api/register
