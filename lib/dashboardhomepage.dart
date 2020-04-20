//import 'package:flutter/material.dart';
//import 'package:sidebar_animation/JsonPage.dart';
//import '../bloc.navigation_bloc/navigation_bloc.dart';
//
//class HomePage extends StatelessWidget with NavigationStates {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'list view',
//      theme: ThemeData(
//        primaryColor: Colors.green,
//      ),
//      home: JsonPage(),
//    );
//  }
//}

import 'package:flutter/material.dart';
import 'package:happlabs_bms_proj/mainscreen.dart';

import 'griddashboard.dart';
import 'package:google_fonts/google_fonts.dart';

class GridHomePage extends StatefulWidget {

  static String id = 'dashboard_page';
  @override
  _GridHomePageState createState() => _GridHomePageState();
}

class _GridHomePageState extends State<GridHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff5e5656),
        title: Text('Happlabs BMS'),
      ),
      drawer: MainDrawer(),
      backgroundColor: Color(0xff5e5656),
      //Color(0xff392850),

      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "HappLabs",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Lists",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Color(0xffa29aac),
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                IconButton(
                  alignment: Alignment.topCenter,
                  icon: Image.asset(
                    "images/logo.png",
                    width: 24,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GridDashboard()
        ],
      ),
      //drawer: MainDrawer(),
    );
  }
}
