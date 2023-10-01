import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
