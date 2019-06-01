import 'dart:async' as prefix0;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import '../main.dart';
import 'package:http/http.dart' as http;
import 'report.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'scaning.dart';
import 'package:path/path.dart';

class Confirm extends StatefulWidget {
  final List value;
  //final List tracking;
  Confirm({Key key, this.value}) : super(key: key);
  @override
  _ConfirmState createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
//var test = value;
  final formKey = GlobalKey<FormState>();
  final licensePlateTextFieldController = TextEditingController();
  final usernameTextFieldController = TextEditingController();
  final couriernameTextFieldController = TextEditingController();
  String data;
  String licenseString = '';
  String usernameString = '';
  String couriernameString = '';
  List<String> trans = [];
//  List<String> trans2 = [];
//  List<String> trans3 = [];

  //get tracking => tracking;ั
  //List<Offset> _points = <Offset>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ยืนยันขนส่ง'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 20.0),
              child: licensePlateTextField(),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0, left: 90.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.all(10.0),
                    child: new Image.asset(
                      "images/dhl.png",
                      height: 90.0,
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.all(10.0),
                    child: new Image.asset(
                      "images/alpha.png",
                      height: 90.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0, left: 90.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new GestureDetector(
                    onTap: () {
                      print("Container clicked");
                    },
                    child: new Container(
                      margin: EdgeInsets.all(10.0),
                      child: new Image.asset(
                        "images/kerry.jpg",
                        height: 90.0,
                      ),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.all(10.0),
                    child: new Image.asset(
                      "images/flash.png",
                      height: 90.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 7.0),
              child: usernameTextField(),
            ),
            Container(
              margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 7.0),
              child: couriernameTextField(),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: 30.0, bottom: 7.0, right: 50.0, left: 50.0),
                child: saveButton(context))
          ],
        ),
      ),
    );
  }

  void uploadToServer() {
    print('You Click Upload');
    // formKey.currentState.reset();
    print(formKey.currentState.validate());
    formKey.currentState.save();
    print(
        'Licence = $licenseString, Name = $usernameString, Couriername = $couriernameString');
    //sendtoserver();
  }

  Widget licensePlateTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'ทะเบียนรถ:',
      ),
      controller: licensePlateTextFieldController,
      validator: (String value) {
        if (value.length == 0) {
          return 'license Plate ?';
        } else {
          licenseString = value;
        }
      },
//      onSaved: (String license) {
//        licenseString = license;
//        print('=============licen=============');
//      },
    );
  }

  Widget usernameTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'ผู้ส่งของ:'),
      controller: usernameTextFieldController,
      validator: (String value) {
        if (value.length == 0) {
          return 'username ?';
        } else {
          usernameString = value;
        }
      },
//      onSaved: (String username) {
//        usernameString = username;
//        print('=============username==========');
//      },
    );
  }

  Widget couriernameTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'ผู้รับของ:'),
      controller: couriernameTextFieldController,
      validator: (String value) {
        if (value.length == 0) {
          return 'couriername';
        } else {
          couriernameString = value;
        }
      },
//      onSaved: (String couriername) {
//        couriernameString = couriername;
//        print('=============couriername=============');
//      },
    );
  }

  Widget saveButton(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      child: Text(
        'Save',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        this.usernameString = licensePlateTextFieldController.text.toString();
        this.licenseString = usernameTextFieldController.text.toString();
        this.couriernameString = couriernameTextFieldController.text.toString();
        this.trans.add(this.usernameString);
        this.trans.add(this.licenseString);
        this.trans.add(this.couriernameString);
        this.trans.add("${widget.value}");
        print(this.trans);
        sendtoserver(this.trans);
        _localFile;
        writeContent();
        setState(() {
        });
        
        //trans.clear();
        //print('save complete');
        licensePlateTextFieldController.clear();
        usernameTextFieldController.clear();
        couriernameTextFieldController.clear();
        var route = new MaterialPageRoute(
            builder: (BuildContext context) => Report(value: trans));
        Navigator.of(context).push(route);
      },
    );
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  print(directory.path);
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  if (await Directory(dirname(path)).exists()) {
    
  } else {
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (e) {
      print(e);
    }
  }
  return File('$path/counter.txt');
}

Future<String> readContent() async {
  try {
    final file = await _localFile;
    // Read the file
    String contents = await file.readAsString();
    // Returning the contents of the file
    return contents;
  } catch (e) {
    // If encountering an error, return
    return 'Error!';
  }
}

Future<File> writeContent() async {
  final file = await _localFile;
  // Write the file
  print("writeContent");
  print(file.path);

  return file.writeAsString('Hello Folk');
}

Future sendtoserver(data) async {
  print('============');
  print(data);
  print('rrrr');
  print('============');
  data = json.encode(data);
  // String licenseString, usernameString, couriernameString
  var url = 'https://www.sunteen.co.th/appmobile/api/counter.php';
  var response = await http.post(url, body: {'isAdd': 'true', 'data': data});
//    var result = json.decode(response.body);
  print('============');
  print('============');
  print('Response status: ${response.statusCode}');
  print('============');
  print('============');
  print('============');
  print('============');
  print('Response body: ${response.body}');
  print('============');
  print('============');
}
