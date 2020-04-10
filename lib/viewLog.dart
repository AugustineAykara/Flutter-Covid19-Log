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
        title: Text(
          "Log Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          status(Icons.date_range, time),
          status(Icons.location_on, location),
          status(Icons.flag, landmark),
          Row(
            children: <Widget>[
              Flexible(
                child: status(Icons.border_horizontal, lattitude),
              ),
              Flexible(
                child: status(Icons.border_vertical, longitude),
              ),
            ],
          ),
          status(Icons.person_pin, person),
          status(Icons.timelapse, duration),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget status(icon, statusAns) {
    return Card(
      color: Colors.deepOrangeAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 6,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: InkWell(
          child: Icon(icon, color: Colors.white, size: 36),
        ),
        title: Text(
          statusAns.toString(),
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
