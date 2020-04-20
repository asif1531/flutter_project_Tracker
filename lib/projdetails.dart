import 'package:flutter/material.dart';
import 'widgets/proj_data.dart';
//import 'package:sidebar_animation/pages/myaccountspage.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Map<String, dynamic> projData;

  ProjectDetailsPage({@required this.projData});

  @override
  Widget build(BuildContext context) {
    print(projData.toString());
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
        projdata: projData,
        prjId: projData['id'],
        prjTitle: projData['title'],
        prjPlatform: projData['Platform']['Platform'],
        prjlink: projData['link'],
        prjbudget: projData['budget'].toString(),
        month: projData['month'],
        tier: projData['tier']['tier'],
        disposition: projData['Disposition']['Disposition'],
        bidtype: projData['bidtype']['bidtype'],
        evidence: projData['Evidence'],
        biddingnotes: projData['BiddingNotes'],
        file: projData['file'].toString(),
        date: projData['date'],
      )),
    );
  }
}
