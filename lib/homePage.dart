import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'employeeDetails.dart';
import 'employeeLog.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        "/employeeDetails": (BuildContext context) => EmployeeLog(),
      },
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
            "Employee Details",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // actions: <Widget>[
        //   Center(
        //     child: Text(
        //       "My Profile",
        //       style:
        //           TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // IconButton(
        //   icon: Icon(Icons.account_circle),
        //   iconSize: 32,
        //   color: Colors.deepOrange,
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => EmployeeDetailPage(),
        //       ),
        //     );
        //   },
        // )
        // ],
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
                decoration: new BoxDecoration(
                  color: Colors.orange,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(300.0),
                    // topRight: const Radius.circular(0.0),
                  ),
                ),
                alignment: Alignment.bottomCenter,
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
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
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
            color: Colors.deepOrange,
            padding: EdgeInsets.all(10.0),
            child: Text('View Log',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.deepOrangeAccent)),
            onPressed: () {
              print("View log");
            },
          ),
          RaisedButton(
            elevation: 8,
            textColor: Colors.white,
            color: Colors.deepOrange,
            padding: EdgeInsets.all(10.0),
            child: Text('Enter Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.deepOrangeAccent)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmployeeLog(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
