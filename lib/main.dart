import 'package:flutter/material.dart';
import 'package:happlabs_bms_proj/dashboardhomepage.dart';
import 'package:happlabs_bms_proj/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboard.dart';
import 'dashboardhomepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String email = prefs.getString('email') ?? null;
  bool isFirstTimeUser = prefs.getBool('isFirstTime') ?? true;
  print(email);
  print(isFirstTimeUser);
  runApp(
    MyApp(
      currentUserEmail: email,
      isFirstTimeUser: isFirstTimeUser,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String currentUserEmail;
  final bool isFirstTimeUser;
  MyApp({@required this.currentUserEmail, @required this.isFirstTimeUser});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey.shade100,
            primaryColor: Colors.black),
        home: isFirstTimeUser
            ? OnboardingPage()
            : currentUserEmail != null ? GridHomePage() : LoginPage()
        // replace home with above code to enable onboard and login flow
        // home: GridHomePage(),
        );
  }
}
