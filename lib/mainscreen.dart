import 'package:flutter/material.dart';
import 'package:happlabs_bms_proj/calender.dart';
import 'package:happlabs_bms_proj/dashboardhomepage.dart';
import 'package:happlabs_bms_proj/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:happlabs_bms_proj/homescreen.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            color: Color(0xff5e5656),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                            "images/logo.png",
                          ),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Text(
                    'Happlabs BMS',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GridHomePage()),
              );
            },
            child: ListTile(
              leading: Icon(Icons.dashboard),
              title: Text(
                'DashBoard',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarPage()),
              );
            },
            child: ListTile(
              leading: Icon(Icons.mail),
              title: Text(
                'Mails',
                style: TextStyle(fontSize: 20.0),
              ),
              onTap: null,
            ),
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 20.0),
            ),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('email');
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => LoginPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
