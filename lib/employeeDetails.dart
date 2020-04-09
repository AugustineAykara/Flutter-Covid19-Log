import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homePage.dart';

class EmployeeDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EmployeeDetails(),
    );
  }
}

class EmployeeDetails extends StatefulWidget {
  @override
  _EmployeeDetailsState createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController empIDController = TextEditingController();

  // String name = '';
  // String empId = '';
  // String mobileNumber = '';

  // @override
  // void initState() {
  //   super.initState();
  //   print("inside init employeepage");
  //   loadData();
  // }

  // loadData() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     print("inside loadDAta employeepage");
  //     name = (preferences.getString('name') ?? '');
  //     empId = (preferences.getString('empId') ?? '');
  //     mobileNumber = (preferences.getString('mobileNumber') ?? '');
  //     nameController.text = name;
  //     empIDController.text = empId;
  //     mobileNoController.text = mobileNumber;
  //   });
  // }

  saveData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      print("inside saveDAta employeepage");
      preferences.setString('name', nameController.text);
      preferences.setString('empId', empIDController.text);
      preferences.setString('mobileNumber', mobileNoController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Employee Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Enter your name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: empIDController,
                  decoration: InputDecoration(
                    labelText: 'Enter your employee ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: mobileNoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter your mobile number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                RaisedButton(
                  elevation: 8,
                  textColor: Colors.white,
                  color: Colors.deepOrange,
                  padding: EdgeInsets.all(10.0),
                  child: Text('REGISTER',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2)),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.deepOrangeAccent)),
                  onPressed: () {
                    saveData();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
