import 'package:flutter/material.dart';
import 'scaning.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sun Authen',
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
    return Scaffold(
        key: _scaffold,
        body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0),
                child: Row(
                  children: <Widget>[
                    new Expanded(
                      child: signUpButton(context),
                    ),
                    
                    //new Expanded(child: Container(child: testText(),)
                  ],
                ),
              )
            ],
          ),
        ));
  }



  Widget signUpButton(BuildContext context) {
    return RaisedButton(
      color: Colors.orange,
      child: Text(
        'SignUp',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('your click SignIn');
        var myRounte = new MaterialPageRoute(
            builder: (BuildContext context) => QRViewExample());
        Navigator.of(context).push(myRounte);
      },
    );
  }
} //_HomePageState