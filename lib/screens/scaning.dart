import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'confirm_trans.dart';
import '../main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final _scaffold = GlobalKey<ScaffoldState>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  int _counter = 0;
  List<String> tracking = [];

  var trackingTextFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: true,
        home: Scaffold(
          key: _scaffold,
          appBar: new AppBar(
            title: const Text('Counter Scan'),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
                flex: 4,
              ),
              Container(
                  margin: EdgeInsets.only(top: 7.0, bottom: 7.0),
                  child: Text(
                    ("Tracking : $qrText"),
                    style: TextStyle(fontSize: 18.0),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 7.0, bottom: 7.0),
                  child: new Text(("จำนวน : $_counter"),
                      style: TextStyle(fontSize: 18.0))),
              Container(
                  margin: EdgeInsets.only(top: 7.0, bottom: 7.0),
                  child: confirmButton(context))
            ],
          ),
        ));
  }

  Widget confirmButton(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      child: Text(
        'Confirm',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        new TextField(
          controller: trackingTextFieldController,
        );
        print('save complete');

        var route = new MaterialPageRoute(
            builder: (BuildContext context) => Confirm(value: tracking));
        Navigator.of(context).push(route);
      },
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    final channel = controller.channel;
    controller.init(qrKey);
    channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case "onRecognizeQR":
          dynamic arguments = call.arguments;
          setState(() {
            
            //print(screg.pattern);
            qrText = arguments.toString();
          });

          Pattern pattern = r'(^[T|t][D|d][Z|z]+[0-9]{8}$)';
          RegExp regex = new RegExp(pattern);
          if (!regex.hasMatch(qrText)) {
            print('validate RegExp');
          }
          if (!tracking.contains(this.qrText)) {
            tracking.add(this.qrText);
            setState(() {
              _counter++;
            });
          } else {
            print('+++++++++++++++++++++++');
            print('Duplicated No.');
            print('+++++++++++++++++++++++');
            Fluttertoast.showToast(
                msg: "รบกวนตวจสอบ เลขซ้ำ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.red[200],
                textColor: Colors.white,
                fontSize: 16.0);
          }
      }
    });
  }

  // void validateTracking(String qrText) {
  //   Pattern pattern = r'(^[T|t][D|d][Z|z]+[0-9]{8}$)';
  //   RegExp regex = new RegExp(pattern);
  //   if (!regex.hasMatch(qrText)) {
  //     print('validate re');
  //   }
  // }
}
