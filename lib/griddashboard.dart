import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happlabs_bms_proj/activitytrack.dart';
import 'package:happlabs_bms_proj/contactus.dart';
import 'package:happlabs_bms_proj/downloads.dart';
import 'package:happlabs_bms_proj/jsonpage.dart';
import 'csv_page.dart';

class GridDashboard extends StatelessWidget {
  List<Items> myList = [
    Items(
        //page: 'null',
        title: "Projects",
        subtitle: "Click to view Projects",
        event: "",
        img: "images/projects.jpg"),
    Items(
      title: "Downloads",
      subtitle: "Click to view Downloads",
      event: "",
      img: "images/downloads.png",
    ),
    Items(
      title: "Activity",
      subtitle: "Click ot show Activities",
      event: "",
      img: "images/activity.png",
    ),
    Items(
      title: "CSV",
      subtitle: "Click to view Project CSV",
      event: "",
      img: "images/csv.jpg",
    ),
    Items(
      title: "Mails",
      subtitle: "Click to view Mails",
      event: "",
      img: "images/mails.png",
    ),
    Items(
      title: "Contact us",
      subtitle: "",
      event: "",
      img: "images/contactus.jpeg",
    )
  ];

  void conditionalNavigation(BuildContext ctx, String title) {
    switch (title) {
      case 'Projects':
        // Navigator.pop(ctx);
        Navigator.of(ctx).push(
          MaterialPageRoute(builder: (ctx) => JsonPage()),
        );
        break;

      case 'Downloads':
        Navigator.of(ctx).push(
          MaterialPageRoute(builder: (ctx) => DownloadsPage()),
        );
        break;

      case 'Activity':
        Navigator.of(ctx).push(
          MaterialPageRoute(builder: (ctx) => ActivityTrack()),
        );
        break;
      case 'CSV':
        //Navigator.pop(ctx);
        Navigator.of(ctx).push(
          MaterialPageRoute(builder: (ctx) => CsvPage()),
        );
        break;
      case 'Mails':
        Navigator.of(ctx).push(
          MaterialPageRoute(builder: (ctx) => CsvPage()),
        );
        break;
      case 'Contact us':
        Navigator.of(ctx).push(
          MaterialPageRoute(builder: (ctx) => ContactUs()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var color = 0xff5e5656;
    //0xff453658;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return Card(
              color: Colors.transparent,
              elevation: 5,
              child: GestureDetector(
                onTap: () {
                  conditionalNavigation(context, data.title);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(color),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        data.img,
                        width: 42,
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        data.title,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        data.subtitle,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.white38,
                                fontSize: 10,
                                fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        data.event,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  MaterialPageRoute page;
  String title;
  String subtitle;
  String event;
  String img;

  Items({this.title, this.subtitle, this.event, this.page, this.img});
}
