import 'package:flutter/material.dart';
import 'package:happlabs_bms_proj/add_project.dart';
//import 'package:happlabs_bms_proj/mainscreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'widgets/project_card.dart';

//import 'package:sidebar_animation/pages/myaccountspage.dart';

class JsonPage extends StatefulWidget {
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
    final response = await http.get('${ConstantVars.apiUrl}/projects');
    final decodedResponse = json.decode(response.body);
    widget.projects = decodedResponse['results'];
    widget.orgProjects = decodedResponse['results'];
    setState(() {});
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
      backgroundColor: Colors.cyan[50],
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title: new Text(
          'projects',
          textAlign: TextAlign.center,
        ),
      ),
      //drawer: MainDrawer(),
      body: Container(
        child: Column(
          children: <Widget>[
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
