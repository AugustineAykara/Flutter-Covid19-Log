import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'viewLog.dart';

class ListLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: ListLogDetails(),
    );
  }
}

class ListLogDetails extends StatefulWidget {
  final String empId;
  ListLogDetails({Key key, this.empId}) : super(key: key);
  @override
  _ListLogDetailsState createState() => _ListLogDetailsState();
}

class _ListLogDetailsState extends State<ListLogDetails> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> employeeSnapshot = Firestore.instance
        .collection('employeeData')
        .document('${widget.empId}')
        .collection('logDetails')
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
      body: StreamBuilder<QuerySnapshot>(
        stream: employeeSnapshot,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: Text("Loading..."));
          else {
            return ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Card(
                  margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.deepOrangeAccent,
                  elevation: 5,
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                    leading:
                        Icon(Icons.date_range, size: 28, color: Colors.white),
                    title: Text(
                      document['Date & Time'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios,
                        size: 28, color: Colors.white),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewLogDetails(
                              date: document['Date & Time'],
                              empId: widget.empId),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
