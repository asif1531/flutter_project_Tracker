import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_utils/file_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

//import 'package:url_launcher/url_launcher.dart';
//import 'package:sidebar_animation/constants.dart';
////import 'package:sidebar_animation/constants.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';

class ProjectDataCard extends StatefulWidget {
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
      {@required this.prjTitle,
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
//    const url = 'http:192.168.0.105:8000/media/';
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }
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

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                        color: Colors.purple[100],
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
                    child: Text(
                      'Link :${widget.prjlink}', textAlign: TextAlign.center,
                      //.toString(),
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
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
                      'Bidtype :${widget.bidtype}', textAlign: TextAlign.center,
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
    );
  }
}
