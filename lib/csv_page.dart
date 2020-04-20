//import 'package:flutter/material.dart';
//import 'package:permission_handler/permission_handler.dart';
//import 'package:path_provider/path_provider.dart';
//import 'dart:async';
//import 'package:platform/platform.dart';
////import 'package:file_utils/file_utils.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:file_utils/file_utils.dart';
import 'package:open_file/open_file.dart';

class CsvPage extends StatefulWidget {
  @override
  _CsvPageState createState() => _CsvPageState();
}

class _CsvPageState extends State<CsvPage> {
  List<dynamic> files = [];
  String _openResult = 'Unknown';
  Future<void> downloadedFile() async {
    PermissionStatus storagePermission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (storagePermission == PermissionStatus.granted) {
      String dirloc = '';
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/projDetails/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }
      setState(() {
        files = Directory(dirloc).listSync();
        print(files.toString());
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    downloadedFile();
  }

  openTappedFile(filePath) async {
    print(filePath);
    final result = await OpenFile.open(filePath);
    print(result.message);

    setState(() {
      _openResult = "type=${result.type}  message=${result.message}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Downloads"),
      ),
      body: new ListView.builder(
          itemCount: files.length,
          itemBuilder: (BuildContext ctx, int index) {
            return new ListTile(
              onTap: () {
                openTappedFile(files[index]
                    .toString()
                    .split(':')
                    .last
                    .trim()
                    .replaceAll('\'', ""));
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 30),
              title:
                  Text(files[index].toString().split(':').last.split('/').last),
              trailing: Icon(Icons.open_in_new),
            );
          }),
    );
  }
}
