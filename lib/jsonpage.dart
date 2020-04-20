import 'package:csv/csv.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:happlabs_bms_proj/add_project.dart';
//import 'package:happlabs_bms_proj/mainscreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'widgets/project_card.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_utils/file_utils.dart';
import 'package:path_provider/path_provider.dart';

//import 'package:sidebar_animation/pages/myaccountspage.dart';

class JsonPage extends StatefulWidget {
  static String id = 'json_page';

  bool showSearchBar = false;
  List<dynamic> projects = [];
  List<dynamic> orgProjects = [];
  @override
  _JsonPage createState() => _JsonPage();
}

class _JsonPage extends State<JsonPage> {
  final searchTxtController = TextEditingController();

  void onSearchTextChanged(String searchTxt) async {
    print(searchTxt);
    if (searchTxt.isEmpty) {
      widget.projects = widget.orgProjects;
    } else {
      widget.projects = widget.orgProjects
          .where((project) => project['title']
              .toString()
              .toLowerCase()
              .contains(searchTxt.toLowerCase()))
          .toList();
    }
    setState(() {});
    print(widget.projects);
  }
  // Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  //   print('--- Parse json from: $assetsPath');
  //   return rootBundle
  //       .loadString(assetsPath)
  //       .then((jsonStr) => json.decode(jsonStr));
  // }

  // void readJason() {
  //   parseJsonFromAssets('assets/users_mock.json').then((jsonData) {
  //     widget.projects = jsonData['projects'];
  //     widget.orgProjects = jsonData['projects'];
  //     setState(() {});
  //   });
  // }
  void getProjectList() async {
    final response = await http.get('${ConstantVars.apiUrl}/projectslist');
    final decodedResponse = json.decode(response.body);
    widget.projects = decodedResponse['results'];
    widget.orgProjects = decodedResponse['results'];
    this.createCsv();
    setState(() {});
  }

  // created all projects details csv
  createCsv() async {
    List<List<dynamic>> projDetails = [];
    List<String> csvHeader = [
      'Title',
      'Platform',
      'Link',
      'Budget',
      'Months',
      'Tier',
      'Disposition',
      'Bid Type',
      'Evidence',
      'Bidding Notes'
    ];
    projDetails.add(csvHeader);

    widget.orgProjects.forEach((proj) {
      projDetails.add([
        proj['title'],
        proj['Platform']['Platform'],
        proj['link'],
        proj['budget'],
        proj['month'],
        proj['tier']['tier'],
        proj['Disposition']['Disposition'],
        proj['bidtype']['bidtype'],
        proj['Evidence'],
        proj['BiddingNotes']
      ]);
    });
    String csv = const ListToCsvConverter().convert(projDetails);
    PermissionStatus storagePermission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    print('First time:' + storagePermission.toString());
    if (storagePermission != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      storagePermission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      print('second time:' + storagePermission.toString());
    }
    if (storagePermission == PermissionStatus.granted) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/projDetails/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }
      try {
        FileUtils.mkdir([dirloc]);
        File csvFile = await File('$dirloc/project_details.csv');
        await csvFile.writeAsString(csv);
      } catch (e) {
        print(e);
      }

      print('CSV generated');
      // setState(() {
      //   downloading = false;
      //   progress = "Download Completed.";
      //   final snackBar = SnackBar(content: Text('Download completed!'));
      //   Scaffold.of(context).showSnackBar(snackBar);
      // });
    } else {
      print('CSV generation failed');
      // setState(() {
      //   progress = "Permission Denied!";
      // });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print('Called ng OnInit');
    super.initState();
    // readJason();
    getProjectList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5e5656),
      //backgroundColor: Colors.cyan[50],
      appBar: new AppBar(
        backgroundColor: Color(0xff5e5656),
        //backgroundColor: Colors.blue,
        title: new Text(
          'projects',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                widget.showSearchBar = !widget.showSearchBar;
              });
            },
          )
        ],
      ),
      //drawer: MainDrawer(),
      body: Container(
        child: Column(
          children: <Widget>[
            if (widget.showSearchBar)
              new Container(
                color: Theme.of(context).primaryColor,
                child: new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Card(
                    child: new ListTile(
                      leading: new Icon(Icons.search),
                      title: new TextField(
                        controller: searchTxtController,
                        decoration: new InputDecoration(
                            hintText: 'Search', border: InputBorder.none),
                        onChanged: onSearchTextChanged,
                      ),
                      trailing: new IconButton(
                        icon: new Icon(Icons.cancel),
                        onPressed: () {
                          searchTxtController.clear();
                          onSearchTextChanged('');
                        },
                      ),
                    ),
                  ),
                ),
              ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  itemCount: widget.projects.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProjectCard(
                      projData: widget.projects[index],
                    );
                    // return ListTile(
                    //     title: Text(widget.projects[index]['name']),
                    //     subtitle: Text(widget.projects[index]['desc']),
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProject()),
          );
        },
        child: Icon(
          Icons.add,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
      ),
    );
  }
}
