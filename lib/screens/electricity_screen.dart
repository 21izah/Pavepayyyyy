import 'package:flutter/material.dart';
import '../containers/electricity_screen_container/electricity_provider.dart';
import '../containers/electricity_screen_container/meter_number_cntainer.dart';

class ElectricityScreen extends StatefulWidget {
  const ElectricityScreen({super.key});

  @override
  State<ElectricityScreen> createState() => _ElectricityScreenState();
}

class _ElectricityScreenState extends State<ElectricityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TV',
          style: TextStyle(fontSize: 15),
        ),
        // actions: [
        //   GestureDetector(
        //     onTap: () {},
        //     child: Padding(
        //       padding: const EdgeInsets.all(10.0),
        //       child: Text(
        //         'History',
        //         style: TextStyle(
        //           color: Colors.blue,
        //         ),
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: Column(children: [
        MeterNumberContainer(),
      ]),
    );
  }
}
