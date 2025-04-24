import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SOSPage(),
    );
  }
}

class SOSPage extends StatelessWidget {
  Future<void> sendSOSAlert(BuildContext context) async {
    var permission = await Permission.location.request();
    if (!permission.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location permission denied")),
      );
      return;
    }

    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    DatabaseReference ref = FirebaseDatabase.instance.ref("alerts").push();
    await ref.set({
      "status": "SOS Triggered",
      "latitude": pos.latitude,
      "longitude": pos.longitude,
      "timestamp": DateTime.now().toIso8601String(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("SOS alert sent successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Women Safety App")),
        body: Center(
            child: ElevatedButton(
              onPressed: () => sendSOSAlert(context),
              child: Text("Send SOS Alert"),
            ),
          ),
        );
    }