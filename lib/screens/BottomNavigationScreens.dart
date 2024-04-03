import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:unicons/unicons.dart';

import 'customer_help_screen.dart';
import 'finance.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'transaction_screen.dart';

class BottomNavigationScreens extends StatefulWidget {
  const BottomNavigationScreens({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreens> createState() =>
      _BottomNavigationScreensState();
}

class _BottomNavigationScreensState extends State<BottomNavigationScreens> {
  final pages = [
    const HomeScreen(),
    const TransactionScreen(),
    CustomerHelpScreen(),
    FinanceScreen(),
    ProfilePage(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: pages[selectedIndex],
      extendBody: true,
      bottomNavigationBar: GNav(
          selectedIndex: selectedIndex,
          onTabChange: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          mainAxisAlignment: MainAxisAlignment.center,
          tabActiveBorder: Border.all(color: Colors.white),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          // backgroundColor: Colors.blue,
          activeColor: Theme.of(context).colorScheme.background,
          haptic: true,
          backgroundColor: Colors.white,
          tabBorder: Border.symmetric(),
          tabBorderRadius: 10,
          tabBackgroundColor: Colors.blue,
          color: Theme.of(context).colorScheme.background,
          gap: 5,
          tabMargin: EdgeInsets.fromLTRB(5, 5, 5, 20),
          tabs: [
            GButton(
              icon: UniconsLine.home,
              text: 'Home',
              textColor: Theme.of(context).colorScheme.background,
              iconColor: Theme.of(context).colorScheme.tertiary,
            ),
            GButton(
              icon: UniconsLine.transaction,
              text: 'Transactions',
              textColor: Theme.of(context).colorScheme.background,
              iconColor: Theme.of(context).colorScheme.tertiary,
            ),
            GButton(
              icon: UniconsLine.wallet,
              text: 'Support',
              textColor: Theme.of(context).colorScheme.background,
              iconColor: Theme.of(context).colorScheme.tertiary,
            ),
            GButton(
              icon: UniconsLine.laptop,
              text: 'Finance',
              textColor: Theme.of(context).colorScheme.background,
              iconColor: Theme.of(context).colorScheme.tertiary,
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
              textColor: Theme.of(context).colorScheme.background,
              iconColor: Theme.of(context).colorScheme.tertiary,
            ),
          ]),
    );
  }
}
