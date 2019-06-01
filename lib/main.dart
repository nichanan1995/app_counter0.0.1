import 'package:flutter/material.dart';
import './screens/scaning.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sun App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();

  String emailString, passwordString, nameString, truePassword, idString;

  @override
  Widget build(BuildContext context) {


var spacecrafts = ["1","2","3","4","5"];
    var listItem = new ListView.builder(
      itemCount: spacecrafts.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: new Card(
            elevation: 5.0,
            child: new Container(
              alignment: Alignment.centerLeft,
              margin: new EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: new Text(spacecrafts[index]),
            ),
          ),
          onTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                child: new CupertinoAlertDialog(
                  title: new Column(
                    children: <Widget>[
                      new Text("ListView"),
                      new Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  content: new Text( spacecrafts[index]),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: new Text("OK"))
                  ],
                ));
          },
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
      ),
        body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0),
                child: Row(
                  children: <Widget>[

                    //new Expanded(child: Container(child: testText(),)
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: () {
          print('Clicked');
        print('your click SignIn');

        var myRounte = new MaterialPageRoute(
            builder: (BuildContext context) => QRViewExample());
        Navigator.of(context).push(myRounte);
        },
      ),
        );
        
  }
} //_HomePageStat