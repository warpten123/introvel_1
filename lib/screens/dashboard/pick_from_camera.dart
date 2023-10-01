import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:introvel_1/screens/dashboard/user-dashboard.dart';
import 'package:introvel_1/screens/dashboard/widgets/camera_app_bar.dart';

import '../../models/user.dart';
import '../../sql/sql_helper.dart';
import '../../utilities/util.dart';

class FromCamera extends StatefulWidget {
  FromCamera(this.path, this.location, this.user, {super.key});
  String? path;
  String? location;
  User user;
  @override
  State<FromCamera> createState() => _FromCameraState();
}

class _FromCameraState extends State<FromCamera> {
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.0),
          child: CameraAppBar(),
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.path == null
                    ? Container(
                        height: 250,
                        width: 350,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/camera_placeholder.png"),
                              fit: BoxFit.cover,
                              opacity: 0.8),
                        ),
                      )
                    : Container(
                        height: 250,
                        width: 350,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: FileImage(File(widget.path!)),
                              fit: BoxFit.cover,
                              opacity: 0.8),
                        ),
                      ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 100,
                  width: 400,
                  child: TextFormField(
                    maxLines: 8,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Text';
                      }
                      return null;
                    },
                    controller: descriptionController,
                    decoration: const InputDecoration(
                        labelText: 'Description',
                        prefixIcon: Icon(Icons.document_scanner),
                        border: OutlineInputBorder(),
                        fillColor: Colors.green),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.black12,
                      ),
                    ),
                    onPressed: () async {
                      // String position = await fetchPosition();
                      final result = await SQLHelper.storePictureDiary(
                          widget.path!,
                          descriptionController.text,
                          widget.user.id!,
                          widget.location!);
                      if (result >= 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Dashboard(widget.user)),
                        );
                        showSnackBarSuccess(
                            context, "Picture Diary Added Successfully!");
                      } else {
                        showSnackBarError(
                            context, "Error in adding your diary!");
                      }
                    },
                    child: Text(
                      "Upload Picture!",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
