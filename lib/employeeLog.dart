import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

class EmployeeLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
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
  Position currentPosition;
  String location;
  String landmark;
  String selectedTimeFormat;
  String empId;
  List timeFormat = ['Hour', 'Minute'];

  static DateTime dateTime = DateTime.now();
  static String formattedDate = DateFormat('d.MM.y hh:mm a').format(dateTime);
  Geolocator geolocator = Geolocator();
  // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  // TextEditingController dateController =
  //     TextEditingController(text: formattedDate);

  TextEditingController locationController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController personController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        empId = (prefs.getString('empId') ?? '');
      });
    });
    getCurrentLocation();
  }

  getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        latitudeController =
            TextEditingController(text: currentPosition.latitude.toString());
        longitudeController =
            TextEditingController(text: currentPosition.longitude.toString());
      });
      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        location =
            "${place.name}, ${place.thoroughfare},${place.subLocality}, ${place.locality}";
            print("${place.name}, ${place.thoroughfare},${place.subLocality}, ${place.locality}");
        locationController = TextEditingController(text: location);
      });
    } catch (e) {
      print(e);
    }
  }

  getDate() {
    dateTime = DateTime.now();
    formattedDate = DateFormat('d.MM.y hh:mm a').format(dateTime);
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
      'latitude': latitudeController.text,
      'longitude': longitudeController.text,
      'person': personController.text,
      'duration': durationController.text + " " + selectedTimeFormat
    });
    locationController.text = '';
    landmarkController.text = '';
    landmarkController.text = '';
    latitudeController.text = '';
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
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(8, 12, 8, 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Wrap(
                  runSpacing: 20,
                  children: <Widget>[
                    textFormField('Location', locationController, false,
                        TextInputType.text),
                    textFormField('Landmark', landmarkController, true,
                        TextInputType.text),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: textFormField('Latitude', latitudeController,
                              false, TextInputType.number),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: textFormField('Longitude', longitudeController,
                              false, TextInputType.number),
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
      hint: Text("Format"),
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
