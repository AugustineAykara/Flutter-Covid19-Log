import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  static DateTime dateTime = DateTime.now();
  static String formattedDate = DateFormat('d.MM.y hh:mm a').format(dateTime);
  // TextEditingController dateController =
  //     TextEditingController(text: formattedDate);

  TextEditingController locationController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController lattitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController personController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  List timeFormat = ['Hour', 'Minute'];
  String selectedTimeFormat;

  String empId;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        empId = (prefs.getString('empId') ?? '');
      });
    });
  }

  getDate() {
    dateTime = DateTime.now();
    formattedDate = DateFormat('d.MM.y hh:mm a').format(dateTime);
    // dateController = TextEditingController(text: formattedDate);
  }

  setData() {
    Firestore.instance
        .collection('employeeData')
        .document(empId)
        .collection('logDetails')
        .document(formattedDate)
        .setData({
      'Date & Time': formattedDate,
      'location': locationController.text,
      'landmark': landmarkController.text,
      'lattitude': lattitudeController.text,
      'longitude': longitudeController.text,
      'person': personController.text,
      'duration': durationController.text + " " + selectedTimeFormat
    });
    locationController.text = '';
    landmarkController.text = '';
    landmarkController.text = '';
    lattitudeController.text = '';
    longitudeController.text = '';
    personController.text = '';
    durationController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Log Details",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            // height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(left: 12, right: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Wrap(
                  runSpacing: 20,
                  children: <Widget>[
                    // Row(
                    //   children: <Widget>[
                    //     Flexible(
                    //       child: textFormField(
                    //           'Date and Time', dateController, false),
                    //     ),
                    //     refreshDate(),
                    //   ],
                    // ),
                    textFormField('Location', locationController, true,
                        TextInputType.text),
                    textFormField('Landmark', landmarkController, true,
                        TextInputType.text),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: textFormField('Lattitude', lattitudeController,
                              true, TextInputType.text),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: textFormField('Longitude', longitudeController,
                              true, TextInputType.text),
                        ),
                      ],
                    ),
                    textFormField(
                        'Person', personController, true, TextInputType.text),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(
                          child: textFormField('Duration', durationController,
                              true, TextInputType.number),
                        ),
                        Flexible(
                          child: dropDownMenu(),
                        ),
                      ],
                    ),

                    submitButton(),
                  ],
                )
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

  Widget textFormField(label, controller, active, type) {
    return TextFormField(
      enabled: active,
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 25.0),
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

  Widget dropDownMenu() {
    return DropdownButton(
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.deepOrange,
      ),
      iconEnabledColor: Colors.grey[600],
      iconSize: 32,
      underline: SizedBox(),
      hint: Text("Time Format"),
      value: selectedTimeFormat,
      items: timeFormat.map((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedTimeFormat = value;
        });
      },
    );
  }

  Widget submitButton() {
    return Center(
      child: RaisedButton(
        elevation: 8,
        textColor: Colors.white,
        color: Colors.deepOrange,
        padding: EdgeInsets.all(12.0),
        child: Text('SUBMIT',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2)),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.deepOrangeAccent)),
        onPressed: () {
          getDate();
          setData();
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Form Submission"),
                // titleTextStyle: TextStyle(color : Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 18),
                content: Text("Form submitted successfully"),
                // contentTextStyle: TextStyle(color : Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
                actions: [
                  FlatButton(
                    child: Text("Done"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
