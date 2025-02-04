import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'employeeLog.dart';
import 'listLog.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name = '';
  String empId = '';
  String mobileNumber = '';

  @override
  void initState() {
    super.initState();
    print("inside init homepage");
    loadData();
  }

  loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      print("inside loadDAta homepage");
      name = (preferences.getString('name') ?? '');
      empId = (preferences.getString('empId') ?? '');
      mobileNumber = (preferences.getString('mobileNumber') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Employee Card",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  helloTextStyle(
                      "Welcome", 48.0, FontWeight.bold, Colors.black),
                  helloTextStyle(name, 32.0, FontWeight.bold, Colors.grey[700]),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(325.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    employeeDetails("Emp_ID : " + empId),
                    SizedBox(height: 8),
                    employeeDetails("Mob No : " + mobileNumber),
                    SizedBox(height: 20),
                    rowButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget helloTextStyle(text, size, weight, color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
  }

  Widget employeeDetails(text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget rowButton() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
            elevation: 8,
            textColor: Colors.white,
            color: Colors.orange,
            padding: EdgeInsets.all(10.0),
            child: Text('View Log',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.orangeAccent)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListLogDetails(empId: empId),
                ),
              );
            },
          ),
          RaisedButton(
            elevation: 8,
            textColor: Colors.white,
            color: Colors.orange,
            padding: EdgeInsets.all(10.0),
            child: Text('Enter Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.orangeAccent)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmployeeLogDetails(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
