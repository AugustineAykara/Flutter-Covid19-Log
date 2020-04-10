import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: ViewLogDetails(),
    );
  }
}

class ViewLogDetails extends StatefulWidget {
  final String date;
  final String empId;
  ViewLogDetails({Key key, this.date, this.empId}) : super(key: key);
  @override
  _ViewLogDetailsState createState() => _ViewLogDetailsState();
}

class _ViewLogDetailsState extends State<ViewLogDetails> {
  String time, location, landmark, lattitude, longitude, person, duration;
  var documentData;
  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> logSnapshot = Firestore.instance
        .collection('employeeData')
        .document('${widget.empId}')
        .collection('logDetails')
        .document('${widget.date}')
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text("Log Details"),
      ),
      body: StreamBuilder(
        stream: logSnapshot,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData)
            return new Center(child: Text("Loading..."));
          else {
            return logDetails(snapshot);
          }
        },
      ),
    );
  }

  Widget logDetails(snapsot) {
    documentData = snapsot.data.data;
    time = documentData['Date & Time'];
    location = documentData['location'];
    landmark = documentData['landmark'];
    lattitude = documentData['lattitude'];
    longitude = documentData['longitude'];
    person = documentData['person'];
    duration = documentData['duration'];
    
    return Scaffold(
      body: Center(
        child: Text(time + " " + location + " " + landmark + " " + lattitude + " " + longitude + " " + person + " " + duration),
      ),
    );
  }
}
