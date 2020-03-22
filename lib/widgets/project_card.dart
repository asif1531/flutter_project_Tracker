import 'package:flutter/material.dart';
import 'package:happlabs_bms_proj/projdetails.dart';
class ProjectCard extends StatelessWidget {
  final Map<String, dynamic> projData;

  ProjectCard({
    @required this.projData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProjectDetailsPage(projData: projData)),
          );
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.purple[100],
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(
                        projData['title'],
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: Text(
                    projData['BiddingNotes'],
                    //.toString(),
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
//                Divider(
//                  thickness: 2,
//                ),
                Align(
                  child: Text(
                    'Dead Line : ${projData['date']}',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                  //alignment: Alignment.bottomRight,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
