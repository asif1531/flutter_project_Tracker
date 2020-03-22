import 'package:flutter/material.dart';
import 'widgets/proj_data.dart';
//import 'package:sidebar_animation/pages/myaccountspage.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Map<String, dynamic> projData;

  ProjectDetailsPage({@required this.projData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: new AppBar(
        title: new Text(
          'projects',
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
          child: ProjectDataCard(
            prjTitle: projData['title'],
            prjPlatform: projData['Platform'],
            prjlink: projData['link'],
            prjbudget: projData['budget'],
            month: projData['month'],
            tier: projData['tier'],
            disposition: projData['Disposition'],
            bidtype: projData['bidtype'],
            evidence: projData['Evidence'],
            biddingnotes: projData['BiddingNotes'],
            file: projData['file'],
            date: projData['date'],
          )),
    );
  }
}
