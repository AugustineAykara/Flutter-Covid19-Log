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
  @override
  _ListLogDetailsState createState() => _ListLogDetailsState();
}

class _ListLogDetailsState extends State<ListLogDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log Details"),
      ),
    );
  }
}