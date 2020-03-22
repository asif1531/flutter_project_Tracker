import 'package:flutter/material.dart';
//import 'package:happlabs_bms_proj/mainscreen.dart';
import 'constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:file_picker/file_picker.dart';

class AddProject extends StatefulWidget {
  AddProjectWidget createState() => AddProjectWidget();
}

class AddProjectWidget extends State {
//  final _formKey = GlobalKey<FormState>();

  String _myProjSelection;

  String _myProjTierSelection;

  String _myDispoSelection;

  String _myBidTypeSelection;

  final String projTypeurl = "${ConstantVars.apiUrl}/projectstype/";

  final String projTierurl = "${ConstantVars.apiUrl}/projectstier/";

  final String projDispourl = "${ConstantVars.apiUrl}/projectsdisposition/";

  final String projBidTypeurl = "${ConstantVars.apiUrl}/projectsbid/";

  List Projtypedata = List();

  List ProjDispoData = List();

  List ProjTierData = List();

  List ProjBidTypedata = List();

  @override
  void initState() {
    super.initState();
    this.getSWData();
    this.getDispoData();
    this.getTierData();
    this.getBidData();
  }

  Future<String> getSWData() async {
    var res = await http.get(Uri.encodeFull(projTypeurl),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      Projtypedata = resBody['results'];
//      data.add(resBody);
    });

    print(resBody);

    return "Sucess";
  }

  //Tier Selection

  Future<String> getTierData() async {
    var res = await http.get(Uri.encodeFull(projTierurl),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      ProjTierData = resBody['results'];
//      data.add(resBody);
    });

    print(resBody);

    return "Sucess";
  }

//dispo

  Future<String> getDispoData() async {
    var res = await http.get(Uri.encodeFull(projDispourl),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      ProjDispoData = resBody['results'];
//      data.add(resBody);
    });

    print(resBody);

    return "Sucess";
  }

  //BidType

  Future<String> getBidData() async {
    var res = await http.get(Uri.encodeFull(projBidTypeurl),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      ProjBidTypedata = resBody['results'];
//      data.add(resBody);
    });

    print(resBody);

    return "Sucess";
  }

  // Getting value from TextField widget.
  final titleController = TextEditingController();
  //final platformController = TextEditingController();
  final linkController = TextEditingController();
  final budgetController = TextEditingController();
  final monthController = TextEditingController();
  // final tierController = TextEditingController();
  // final dispositionController = TextEditingController();
  //final bidTypeController = TextEditingController();
  final evidenceController = TextEditingController();
  final biddingNotesController = TextEditingController();
  final fileController = TextEditingController();
  // File file = await FilePicker.getFile();
//  final FileController = Image.file(url);

  // Boolean variable for CircularProgressIndicator.
  bool visible = false;

  Future webCall() async {
    // Showing CircularProgressIndicator using State.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String title = titleController.text;
    //String Platform = platformController.text;
    String link = linkController.text.toString();
    double budget = double.parse(budgetController.text);
    int month = int.tryParse(monthController.text) ?? 0;
    // String tier = tierController.text;
    // String Disposition = dispositionController.text;
    //String bidtype = bidTypeController.text;
    String evidence = evidenceController.text;
    String biddingNotes = biddingNotesController.text;

    // API URL
    var url = '${ConstantVars.apiUrl}/projects/';

    // Store all data with Param Name.
    var data = {
      'title': title,
      'Platform': '${ConstantVars.apiUrl}/projectstype/$_myProjSelection/',
      'link': link,
      'budget': budget,
      'month': month,
      'tier': '${ConstantVars.apiUrl}/projectstier/$_myProjTierSelection/',
      'Disposition':
          '${ConstantVars.apiUrl}/projectsdisposition/$_myDispoSelection/',
      'bidtype': '${ConstantVars.apiUrl}/projectsbid/$_myBidTypeSelection/',
      'Evidence': evidence,
      'BiddingNotes': biddingNotes,
      'file': '',
      'date': DateTime.now().toIso8601String(),
    };

    print(data.toString());

    // Starting Web Call with data.
    var response = await http.post(url,
        body: json.encode(data), headers: {'Content-Type': 'application/json'});

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }

    // Showing Alert Dialog with Response JSON.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message.toString()),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "HappLabs",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.blue,
        ),
        //drawer: MainDrawer(),
        body: Center(
          child: SingleChildScrollView(
              child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text('Fill All the Information in Form',
                          style: TextStyle(fontSize: 24, color: Colors.red)),
                    )),
                Container(
                    width: 350,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
//                            validator: (value) {
//                            if (value.isEmpty) {
//                              return 'Please enter some text';
//                            }
//                            return null;
//                          },

                      controller: titleController,
                      autocorrect: true,
                      decoration: InputDecoration(
                          labelText: 'Enter the title',
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0)),
                          ),
                          fillColor: Colors.red,
                          hintText: 'Enter Title Here'),
                    )),
                Container(
                  width: 350,
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: new DropdownButton(
                      isExpanded: true,
                      hint: Center(
                        child: Text(
                          "Select Platform",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      items: Projtypedata.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item['Platform']),
                          value: item['id'].toString(),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          _myProjSelection = newVal;
                        });
                      },
                      value: _myProjSelection,
                    ),
                  ),
//
                ),
                Container(
                    width: 350,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: linkController,
                      autocorrect: true,
                      decoration: InputDecoration(
                          labelText: 'Reference Link',
                          border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0))),
                          hintText: 'Link Here'),
                    )),
                Container(
                    width: 350,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: budgetController,
                      autocorrect: true,
                      decoration: InputDecoration(
                          labelText: 'Specify Your Budget',
                          border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0))),
                          hintText: ' Your Budget '),
                    )),
                Container(
                    width: 350,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: monthController,
                      autocorrect: true,
                      decoration: InputDecoration(
                          labelText: 'No of Months',
                          border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0))),
                          hintText: 'Specify Months Here!'),
                    )),
                Container(
                  width: 350,
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: new DropdownButton(
                      isExpanded: true,
                      hint: Center(
                        child: Text(
                          "Select Tier",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      items: ProjTierData.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item['tier']),
                          value: item['id'].toString(),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          _myProjTierSelection = newVal;
                        });
                      },
                      value: _myProjTierSelection,
                    ),
                  ),
//                        TextField(
//                          controller: tierController,
//                          autocorrect: true,
//                          decoration: InputDecoration(hintText: 'Select Tier Here'),
//                        )
                ),
                Container(
                  width: 350,
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: new DropdownButton(
                      isExpanded: true,
                      hint: Center(
                        child: Text(
                          "Select dispo",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ),
                      items: ProjDispoData.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item['Disposition']),
                          value: item['id'].toString(),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          _myDispoSelection = newVal;
                        });
                      },
                      value: _myDispoSelection,
                    ),
                  ),

//                    TextField(
//                      controller: dispositionController,
//                      autocorrect: true,
//                      decoration:
//                          InputDecoration(hintText: 'Select Disposition Here'),
//                    )
                ),
                Container(
                  width: 350,
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: new DropdownButton(
                      isExpanded: true,
                      hint: Center(
                        child: Text(
                          "Select BidType",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ),
                      items: ProjBidTypedata.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item['bidtype']),
                          value: item['id'].toString(),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          _myBidTypeSelection = newVal;
                        });
                      },
                      value: _myBidTypeSelection,
                    ),
                  ),

//                        TextField(
//                          controller: bidTypeController,
//                          autocorrect: true,
//                          decoration:
//                          InputDecoration(hintText: 'Select Bidtype Here'),
//                        )
                ),
                Container(
                    width: 350,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: evidenceController,
                      autocorrect: true,
                      decoration: InputDecoration(
                          labelText: 'Evidence',
                          border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0))),
                          hintText: 'Evidence'),
                    )),
                Container(
                    width: 350,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: biddingNotesController,
                      autocorrect: true,
                      decoration: InputDecoration(
                          labelText: 'Enter Bid Notes',
                          border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0))),
                          hintText: 'Enter Bid Notes'),
                    )),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: webCall,
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Text('Click Here To Submit Data The Details'),
                ),
                Visibility(
                    visible: visible,
                    child: Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: CircularProgressIndicator())),
              ],
            ),
          )),
        ));
  }
}