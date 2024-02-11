import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

ScaffoldFeatureController showSnackBarError(BuildContext context, String text) {
  // final snackBar = SnackBar(
  //   content: Text(text),
  //   duration: const Duration(seconds: 2), //default is 4s
  // );
  // Find the Scaffold in the widget tree and use it to show a SnackBar.
  final snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Aw snap!',
      message: text,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.failure,
    ),
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

ScaffoldFeatureController showSnackBarSuccess(
    BuildContext context, String text) {
  // final snackBar = SnackBar(
  //   content: Text(text),
  //   duration: const Duration(seconds: 2), //default is 4s
  // );
  // Find the Scaffold in the widget tree and use it to show a SnackBar.
  final snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Information!',
      message: text,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.success,
    ),
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<String> fetchPosition() async {
  Position? position;
  String? locationAddress;
  String? address;
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
      return "Error getting address";
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

  return address = locationAddress;
}

String convertDate(String date) {
  String year = "", month = "", day = "";
  List<String> dateTimeParts = date.split(' ');
  List<String> dateParts = dateTimeParts[0].split('-');
  year = dateParts[0];
  day = dateParts[2];
  switch (dateParts[1]) {
    case "01":
      month = "January";
      break;
    case "02":
      month = "February";
      break;
    case "03":
      month = "March";
      break;
    case "04":
      month = "April";
      break;
    case "05":
      month = "May";
      break;
    case "06":
      month = "June";
      break;
    case "07":
      month = "July";
      break;
    case "08":
      month = "August";
      break;
    case "09":
      month = "September";
      break;
    case "10":
      month = "October";
      break;
    case "11":
      month = "November";
      break;
    case "12":
      month = "December";
      break;
    default:
      month = "Invalid Month";
  }
  return month + " " + day + ", " + year + " @" + dateTimeParts[1];
}
