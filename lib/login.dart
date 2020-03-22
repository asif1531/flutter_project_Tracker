import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:happlabs_bms_proj/dashboardhomepage.dart';
//import 'package:happlabs_bms_proj/dashboardhomepage.dart';
import 'dart:convert';

import 'package:happlabs_bms_proj/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:happlabs_bms_proj/mainscreen.dart';
//import 'sidebar/sidebar_layout.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;
  List<dynamic> users = [];

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  TextStyle style = TextStyle(fontFamily: 'pacifico', fontSize: 20.0);

  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    print('--- Parse json from: $assetsPath');
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => json.decode(jsonStr));
  }

  void validateLogin() {
    print(emailFieldController.text);
    print(passwordFieldController.text);
    readJson();
  }

  void readJson() {
    parseJsonFromAssets('assets/users_mock.json').then((jsonData) async {
      // print(jsonData);
      widget.users = jsonData['users'];
      Map foundUser = {};
      foundUser = widget.users.firstWhere(
          (user) =>
              user["email"] == emailFieldController.text.trim() &&
              user["password"] == passwordFieldController.text,
          orElse: () => print('Invalid User'));
      if (foundUser != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', foundUser['email']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GridHomePage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      controller: emailFieldController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      controller: passwordFieldController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final forgotField = FlatButton(
      onPressed: () {},
      child: Text(
        "forgot pass",
        style: new TextStyle(
            backgroundColor: Colors.white70,
            fontFamily: 'pacifico',
            fontWeight: FontWeight.bold,
            height: 2,
            fontSize: 30,
            color: Colors.blue,
            decoration: TextDecoration.underline),
      ),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          validateLogin();
          // readJson();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => SideBarLayout()),
          // );
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Colors.white70,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 185.0,
                      child: Image.asset(
                        'images/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(
                      height: 35.0,
                    ),
                    loginButon,
                    SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(height: 45.0),
                    forgotField,
                    SizedBox(height: 25.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
