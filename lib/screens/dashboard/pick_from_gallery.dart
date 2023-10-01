import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:introvel_1/screens/dashboard/widgets/gallery_app_bar.dart';
import 'package:introvel_1/sql/sql_helper.dart';
import 'package:introvel_1/utilities/util.dart';

import '../../models/user.dart';

class FromGallery extends StatefulWidget {
  FromGallery(this.user, {super.key});
  User user;
  @override
  State<FromGallery> createState() => _FromGalleryState();
}

String baseName = "";

class _FromGalleryState extends State<FromGallery> {
  final descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? imagePath;
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    bool _isLoading;
    if (pickedFile != null) {
      // Use pickedFile.path to get the selected image's file path.

      setState(() {
        imagePath = pickedFile.path;
        _isLoading = false;
      });

      // Store the imagePath in your database.
      // await storeImagePathInDatabase(imagePath);
    }
  }

  static Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpeg', 'png', 'jpg']);
    if (result == null) return null;
    return File(result.paths.first!);
  }

  var file = null;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.0),
          child: FromGalleryAppBar(),
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    // pickImage();
                    file = await pickFile();
                    if (file == null) return;
                    setState(() {
                      imagePath = file!.path;
                      print("PATH $imagePath");
                    });
                  },
                  child: imagePath == null
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
                                image: FileImage(File(imagePath!)),
                                fit: BoxFit.cover,
                                opacity: 0.8),
                          ),
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
                      final result = await SQLHelper.storePictureDiary(
                          imagePath!,
                          descriptionController.text,
                          widget.user.id!);
                      if (result >= 1) {
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
