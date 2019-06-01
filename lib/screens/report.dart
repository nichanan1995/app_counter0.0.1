import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'confirm_trans.dart';
import '../main.dart';

class Report extends StatefulWidget {
  final List value;
  Report({Key key, this.value}) : super(key: key);
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สรุปรายการ'),
      ),
      body: new Text("${widget.value}"),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {
          print('Clicked');
        print('your click SignIn');
        var myRounte = new MaterialPageRoute(
            builder: (BuildContext context) => HomePage());
        Navigator.of(context).push(myRounte);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
  
}
