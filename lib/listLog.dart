import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        title: Text("Log Details"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: employeeSnapshot,
        builder:
           (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)  {
          if (!snapshot.hasData)
            return Center(child: Text("Loading..."));
          else {
            return ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return ListTile(
                  leading: Icon(Icons.access_time, color: Colors.deepOrange,),
                  title: Text(document['Date & Time']),
                  onTap: (){
                    print("detailed view");
                  },
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
