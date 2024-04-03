import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../containers/airtime_screen_container/airtime_provider_number.dart';
import '../containers/airtime_screen_container/recharge_and_win_container.dart';
import '../containers/airtime_screen_container/topUp_container.dart';

class AirtimePurchaseScreen extends StatefulWidget {
  const AirtimePurchaseScreen({super.key});

  @override
  State<AirtimePurchaseScreen> createState() => _AirtimePurchaseScreenState();
}

class _AirtimePurchaseScreenState extends State<AirtimePurchaseScreen> {
  final _cardController = PageController(initialPage: 0);
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    startNavigationDelay();
  }

  @override
  void dispose() {
    _cardController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void startNavigationDelay() {
    _timer = Timer.periodic(Duration(seconds: 2), (_) {
      final nextPage = _cardController.page!.toInt() + 1;
      if (nextPage < 3) {
        _cardController.animateToPage(nextPage,
            duration: Duration(seconds: 3), curve: Curves.linear);
      } else {
        _cardController.animateToPage(0,
            duration: Duration(seconds: 1), curve: Curves.linear);
      }
      // _cardController.nextPage(
      //     duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Airtime',
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'History',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
          height: screenSize.height * 0.8,
          width: screenSize.width - 10,
          child: Column(children: [
            SizedBox(
              height: 110,
              // color: Colors.amber,
              child: PageView(
                controller: _cardController,
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    child: RechargeAndWinContainer(),
                  ),
                  GestureDetector(
                    child: RechargeAndWinContainer(),
                  ),
                  GestureDetector(
                    child: RechargeAndWinContainer(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // AirtimeProviderNumberContainer(),
            TopUpContainer(),
          ]),
        ),
        Positioned(
          top: screenSize.height * 0.075,
          left: screenSize.width * 0.45,
          child: Container(
            height: 20,
            width: 70,
            // color: Colors.amber,
            child: SmoothPageIndicator(
              controller: _cardController,
              count: 3,
              effect: WormEffect(
                dotColor: Theme.of(context).colorScheme.tertiary,
                activeDotColor: Colors.white,
                offset: 3,
                radius: 4,
                dotHeight: 4,
                dotWidth: 4,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
