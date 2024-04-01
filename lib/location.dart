import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationState();
}

class _LocationState extends State<LocationWidget> {
  Position? position;
  String? locationAddress;
  String? address;
  fetchPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    double latitude;
    double longitude;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    Future<String> getAddress(double latitude, double longitude) async {
      try {
        List<Placemark> placemarks =
            await placemarkFromCoordinates(latitude, longitude);
        if (placemarks != null && placemarks.isNotEmpty) {
          Placemark placemark = placemarks[0];
          return "${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
        } else {
          return "Address not found";
        }
      } catch (e) {
        return "Somewhere around the world :)";
      }
    }

    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: "Location Service is disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "You denied the permission");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: "You denied the permission forever");
    }
    Position currentPosition = await Geolocator.getCurrentPosition();

    position = currentPosition;
    latitude = currentPosition.latitude;
    longitude = currentPosition.longitude;
    locationAddress = await getAddress(latitude, longitude);
    setState(() {
      address = locationAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TEST"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(position == null ? "LOCATION " : "${address}"),
            ElevatedButton(
                onPressed: () {
                  fetchPosition();
                },
                child: Text("Get Location"))
          ],
        ),
      ),
    );
  }
}
