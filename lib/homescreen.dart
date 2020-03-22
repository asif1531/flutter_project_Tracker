import 'package:flutter/material.dart';
import 'package:happlabs_bms_proj/dashboardhomepage.dart';

import 'package:happlabs_bms_proj/mainscreen.dart';
import 'mainscreen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HappLabs"),
        backgroundColor: Color(0xff5e5656)
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "HappLabs",
              style: TextStyle(fontSize: 22.0),
            ),
            RaisedButton(
              child: Text('gooo'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GridHomePage()),
                  );
                },

            )
          ],
        ),
      ),
    );
  }
}

