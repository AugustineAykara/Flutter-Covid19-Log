import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'employeeDetails.dart';
import 'homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String name = '';
  // String empId = '';
  // String mobileNumber = '';
  bool initialScreen;

  @override
  void initState() {
    print("inside main init");
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        name = (prefs.getString('name') ?? '');
      });
      if (name == '') {
        initialScreen = true;
      } else {
        initialScreen = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialScreen ? "employeeDetails" : "homePage",
      routes: <String, WidgetBuilder>{
        "employeeDetails": (BuildContext context) => EmployeeDetails(),
        "homePage": (BuildContext context) => HomePage(),
      },
    );
  }
}