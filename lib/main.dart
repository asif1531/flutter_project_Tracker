import 'package:flutter/material.dart';
import 'package:happlabs_bms_proj/dashboardhomepage.dart';
import 'onboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey.shade100,
          primaryColor: Colors.black),
      // home: OnboardingPage(),
      // replace home with above code to enable onboard and login flow
      home: GridHomePage(),
    );
  }
}
