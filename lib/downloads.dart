////import 'package:flutter/material.dart';
////import 'package:permission_handler/permission_handler.dart';
////import 'package:path_provider/path_provider.dart';
////import 'dart:async';
////import 'package:platform/platform.dart';
//////import 'package:file_utils/file_utils.dart';
//import 'dart:io';
//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:permission_handler/permission_handler.dart';
//import 'dart:async';
//
//class DownloadsPage extends StatefulWidget {
//
//
//
//  @override
//  _DownloadsPageState createState() => _DownloadsPageState();
//}
//
//class _DownloadsPageState extends State<DownloadsPage> {
//  Future<void> downloadedFile() async {
//    PermissionStatus storagePermission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
//
//    if (storagePermission == PermissionStatus.granted) {
//      String dirloc = "";
//      if (Platform.isAndroid) {
//        dirloc = "/sdcard/download/projectManagement/";
//
//      } else {
//        dirloc = (await getApplicationDocumentsDirectory()).path;
//      }
//    }
//}
//
//
//  @override
//  Widget build(BuildContext context) {
//      return Scaffold(
//        appBar: AppBar(
//          title: Text("Downloads"),
//        ),
//        body:  new ListView.builder
//          (
//            itemCount: dirloc.length,
//            itemBuilder: (BuildContext ctxt, int index) {
//              return new Text(dirloc[index]);
//            }
//        )
//      );
//    }
//  }
//
