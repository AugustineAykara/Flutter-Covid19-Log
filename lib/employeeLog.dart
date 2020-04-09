import 'package:flutter/material.dart';


class EmployeeLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EmployeeLogDetails(),
      // routes: <String, WidgetBuilder>{
        // "/employeeDetails": (BuildContext context) => EmployeeDetails(),
      // },
    );
  }
}

class EmployeeLogDetails extends StatefulWidget {
  @override
  _EmployeeLogDetailsState createState() => _EmployeeLogDetailsState();
}

class _EmployeeLogDetailsState extends State<EmployeeLogDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
    );
  }
}