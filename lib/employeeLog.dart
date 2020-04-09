import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: EmployeeLogDetails(),
    );
  }
}

class EmployeeLogDetails extends StatefulWidget {
  @override
  _EmployeeLogDetailsState createState() => _EmployeeLogDetailsState();
}

class _EmployeeLogDetailsState extends State<EmployeeLogDetails> {
  static DateTime now = DateTime.now();
  static String formattedDate = DateFormat('hh:mm EEE, M/d/y').format(now);
  TextEditingController dateController =
      TextEditingController(text: formattedDate);
  TextEditingController locationController = TextEditingController();

  getDate() {
    now = DateTime.now();
    formattedDate = DateFormat('hh:mm EEE, M/d/y').format(now);
    dateController = TextEditingController(text: formattedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.orange,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    dateTextField('Date and Time'),
                    refreshDate(),
                  ],
                ),
                SizedBox(height: 10),
                textFormField('Location', locationController),
                SizedBox(height: 10),
                textFormField('Landmark', locationController),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: textFormField('Lattitude', locationController),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: textFormField('Longitude', locationController),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                textFormField('Person', locationController),
                SizedBox(height: 10),
                textFormField('Duration', locationController),
                SizedBox(height: 20),
                submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget refreshDate() {
    return IconButton(
      icon: Icon(Icons.refresh),
      iconSize: 38,
      onPressed: () {
        setState(() {
          getDate();
        });
      },
    );
  }

  Widget dateTextField(label) {
    return Flexible(
      child: TextFormField(
        enabled: false,
        controller: dateController,
        decoration: InputDecoration(
          labelText: label,
          // contentPadding:
          //     new EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          labelStyle: TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
    );
  }

  Widget textFormField(label, controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        // contentPadding:
        //     new EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        labelStyle: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
    );
  }

  Widget submitButton() {
    return RaisedButton(
      elevation: 8,
      textColor: Colors.white,
      color: Colors.deepOrange,
      padding: EdgeInsets.all(10.0),
      child: Text('SUBMIT',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2)),
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.deepOrangeAccent)),
      onPressed: () {
        print("submit");
      },
    );
  }
}
