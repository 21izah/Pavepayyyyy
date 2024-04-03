import 'package:flutter/material.dart';

import 'BottomNavigationScreens.dart';
import 'home_screen.dart';
import 'onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetoWelcomePage();
  }

  _navigatetoWelcomePage() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => OnboardingPage(),
        ),
        (route) => false);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: Image.asset(
            'lib/assets/pwave.jpg',
            // fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
