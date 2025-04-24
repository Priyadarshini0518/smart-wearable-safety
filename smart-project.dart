import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationPage(),
    );
  }
}

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String location = "Press the button to get location";

  Future<void> _getLocation() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        location = "Latitude: ${pos.latitude}, Longitude: ${pos.longitude}";
      });

      // You can send pos.latitude and pos.longitude to a server here
    } else {
      setState(() {
        location = "Location permission denied";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Women's Safety App")),
        body: Center(child: Text(location)),
        floatingActionButton: FloatingActionButton(
            onPressed: _getLocation,
            child: Icon(Icons.location_on),
        ),
    );
  }
}