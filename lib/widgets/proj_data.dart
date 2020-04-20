import 'dart:io';
import 'package:happlabs_bms_proj/add_project.dart';
import 'package:happlabs_bms_proj/jsonpage.dart';
// import 'package:happlabs_bms_proj/projdetails.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_utils/file_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:happlabs_bms_proj/constants.dart';
import 'package:http/http.dart' as http;

//import 'package:url_launcher/url_launcher.dart';
//import 'package:sidebar_animation/constants.dart';
////import 'package:sidebar_animation/constants.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';

class ProjectDataCard extends StatefulWidget {
  final dynamic projdata;
  final int prjId;
  final String prjTitle;
  final String prjPlatform;
  final String prjlink;
  final String prjbudget;
  final int month;
  final String tier;
  final String disposition;
  final String bidtype;
  final String evidence;
  final String biddingnotes;
  final String file;
  final String date;

  ProjectDataCard(
      {@required this.projdata,
      @required this.prjId,
      @required this.prjTitle,
      @required this.prjPlatform,
      @required this.prjlink,
      @required this.prjbudget,
      this.month,
      this.tier,
      this.disposition,
      this.bidtype,
      this.evidence,
      this.biddingnotes,
      this.file,
      this.date});

  @override
  _ProjectDataCardState createState() => _ProjectDataCardState();
}

class _ProjectDataCardState extends State<ProjectDataCard> {
  bool downloading = false;
  var progress = "";
  var path = "No Data";

//  Map data;
//  List userData;
//
//  Future getData() async {
//    http.Response response = await http.get("https://reqres.in/api/users?page=2");
//    data = json.decode(response.body);
//    setState(() {
//      userData = data["data"];
//    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    getData();
//  }

//  String _myProjSelection;
//  final String ProjTypeurl = "http://192.168.1.115:8000/api/projectstype/";
//  List Projtypedata = List();
//
//
//  @override
//  void initState() {
//    super.initState();
//    this.getSWData();
//    //this.getDispoData();
//  }
//  Future<String> getSWData() async {
//    var res = await http.get(Uri.encodeFull(ProjTypeurl),
//        headers: {"Accept": "application/json"});
//    var resBody = json.decode(res.body);
//
//    setState(() {
//      Projtypedata = resBody['results'];
////      data.add(resBody);
//    });
//
//    print(resBody);
//
//    return "Sucess";
//  }
//

//  _launchURL() async {
//    //const url = 'http:192.168.0.105:8000/media/';
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  Future<void> downloadFile(String url) async {
    PermissionStatus storagePermission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    print('First time:' + storagePermission.toString());
    // print(checkPermission1);
    if (storagePermission != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      storagePermission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      print('second time:' + storagePermission.toString());
    }
    if (storagePermission == PermissionStatus.granted) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/projectManagement/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }
      try {
        FileUtils.mkdir([dirloc]);
        Dio dio = new Dio();
        // final taskid = await FlutterDownloader.enqueue(
        //     url: url,
        //     savedDir: dirloc,
        //     showNotification: true,
        //     openFileFromNotification: true);

        // FlutterDownloader.registerCallback((taskid, status, progress) {
        //   print(
        //       'Download task ($taskid) is in status ($status) and process ($progress)');
        // });
        await dio.download(url, dirloc + url.split('/').last,
            onReceiveProgress: (receivedBytes, totalBytes) {
          setState(() {
            downloading = true;
            progress =
                ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
          });
        });
      } catch (e) {
        print(e);
      }

      setState(() {
        downloading = false;
        progress = "Download Completed.";
        final snackBar = SnackBar(content: Text('Download completed!'));
        Scaffold.of(context).showSnackBar(snackBar);
      });
    } else {
      setState(() {
        progress = "Permission Denied!";
      });
    }
  }

//    void deleteProj(String id) async {
//    final http.Response response = await http.delete(
//      'https://${ConstantVars.apiUrl}/api/projectscreate/15/$id',
//      headers: <String, String>{
//        'Accept:Application/json'
//        'Content-Type': 'application/json; charset=UTF-8',
//      },
//    );
//
//    if (response.statusCode == 200) {
//      print(response.body);
//  }

  bool visible = false;

  Future webCall() async {
    // Showing CircularProgressIndicator using State.
    setState(() {
      visible = true;
    });
  }

  deleteProj(int projectId) async {
    String myUrl = '${ConstantVars.apiUrl}/projectscreate/$projectId/';
    var resp = await http.delete(myUrl, headers: {
      'Accept': 'Application/json',
    });

    var message = resp.toString();

    if (resp.statusCode == 204) {
      message = 'Record deleted successfully';
      setState(() {
        visible = false;
      });
      // show deleted message and navigate to listing page
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message.toString()),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                if (resp.statusCode == 204) {
                  Navigator.pushReplacementNamed(context, JsonPage.id);
                }
//                else {
//                  Navigator.of(context).pop();
//                }
              },
            ),
          ],
        );
      },
    );
//    else {
//      // show error message
//    }
    print(resp.statusCode.toString());
  }

//  _makeDeleteRequest() async {
//
//    // post 1
//    String url = 'https://jsonplaceholder.typicode.com/posts/1';
//
//    // make DELETE request
//    Response response = await delete(url);
//
//    // check the status code for the result
//    int statusCode = response.statusCode;
//
//  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        setState(() {
          Navigator.of(context).pop();
        });
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        setState(() {
          deleteProj(widget.prjId);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("$ProjectDataCard.prjTitle"),
      content: Text("Would you like to Delete this project?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {},
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade300,
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Text(
                            widget.prjTitle,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 70,
                      child:
//                    ListView.builder(
//                      itemCount: 0,
//                        itemBuilder: (BuildContext context, int index){
//                          return new Card(
//                            child: new Text(Projtypedata[index]["Platform"]),
//                          );
//                    })
                          Text(
                        //'Platform: ${widget.prjPlatform}'
                        'Platform :${widget.prjPlatform}',
                        textAlign: TextAlign.left,
                        //.toString(),
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      child: InkWell(
                        onTap: () {
                          customLaunch(widget.prjlink);
                        },
                        child: Text(
                          'Link :${widget.prjlink}',

                          textAlign: TextAlign.center,
                          //.toString(),
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      child: Text(
                        'Budget :${widget.prjbudget}',
                        textAlign: TextAlign.center,
                        //.toString(),
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      child: Text(
                        'Months : ${widget.month}', textAlign: TextAlign.left,
                        //.toString(),
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      child: Text(
                        'Tier :${widget.tier}', textAlign: TextAlign.center,
                        //.toString(),
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      child: Text(
                        'Disposition :${widget.disposition}',
                        textAlign: TextAlign.center,
                        //.toString(),
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      child: Text(
                        'Bidtype :${widget.bidtype}',
                        textAlign: TextAlign.center,
                        //.toString(),
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      child: Text(
                        'Evidence :${widget.evidence}',
                        //.toString(),
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      // height: 70,
                      child: Text(
                        'Bidding Notes :${widget.biddingnotes}',
                        //.toString(),
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      margin: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: downloading
                          ? Container(
                              height: 120.0,
                              width: 200.0,
                              child: Card(
                                color: Colors.black,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircularProgressIndicator(),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      'Downloading File: $progress',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              height: 100,
                              child: InkWell(
                                  child: Center(
                                    child: new Text(
                                      'File :${widget.file}',

                                      //.toString(),
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  onTap: () => {
                                        downloadFile(widget.file),
                                      }
                                  //_launchURL(),
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
                        'Dead Line : ${widget.date}',
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                      //alignment: Alignment.bottomRight,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
//        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//        floatingActionButton: Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.end,
//            children: <Widget>[
//              FloatingActionButton(
//                onPressed: () {},
//                child: Icon(Icons.edit),
//              ),
//              SizedBox(width: 20,),
//              FloatingActionButton(
//                backgroundColor: Colors.red,
//                onPressed: () {},
//                child: Icon(Icons.delete),
//              ),
//            ],
//          ),
//        )

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          RaisedButton(
            padding: EdgeInsets.all(15),
            shape: CircleBorder(),
            color: Colors.blueAccent.shade100,
            elevation: 4,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => AddProject(
                    projData: widget.projdata,
                  ),
                ),
              );
            },
            child: Icon(Icons.edit),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            padding: EdgeInsets.all(15),
            shape: CircleBorder(),
            color: Colors.red.shade100,
            elevation: 4,
            onPressed: () {
              showAlertDialog(context);
//              setState(() {
//                deleteProj(widget.prjId);
//              });
            },
            child: Icon(Icons.delete),
          ),
          Visibility(
              visible: visible,
              child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: CircularProgressIndicator())),
        ],
      ),
    );
  }
}
