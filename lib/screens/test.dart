import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:introvel_1/sql/sql_helper.dart';
import 'package:path_provider/path_provider.dart';

class TEST extends StatefulWidget {
  const TEST({super.key});

  @override
  State<TEST> createState() => _LoginState();
}

String? imagePath;

class _LoginState extends State<TEST> {
  List<Map<String, dynamic>> _profileImages = [];
  final ImagePicker _picker = ImagePicker();
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

  void getProfileImages() async {
    final data = await SQLHelper.getProfileImages();
    setState(() {
      _profileImages = data;
    });
    print("LENGTH: ${_profileImages.length}");
  }

  Future<void> _addProfile(String path) async {
    await SQLHelper.storeProfileImage(path);
    getProfileImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    pickImage();
                  },
                  child: Text("Pick")),
              ElevatedButton(
                  onPressed: () {
                    if (imagePath != null) {
                      _addProfile(imagePath!);
                    }
                  },
                  child: Text("Store to DB")),
              ElevatedButton(
                  onPressed: () {
                    getProfileImages();
                  },
                  child: Text("DisplayShit")),
              Container(
                width: 100,
                child: FutureBuilder(
                  future: SQLHelper.getProfileImages(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final images = snapshot.data!;
                    return ListView.builder(
                        itemCount: images.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Image.file(
                            File(images[index]['profile_image']),
                            fit: BoxFit
                                .cover, // You can adjust the fit as needed.
                          );
                        });
                  },
                ),
              ),
              // FutureBuilder<List<Map<String, dynamic>>>(
              //   future: SQLHelper.getProfileImages(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       // While waiting for data, you can display a loading indicator.
              //       return CircularProgressIndicator();
              //     } else if (snapshot.hasError) {
              //       // If there's an error, display an error message.
              //       return Text('Error: ${snapshot.error}');
              //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              //       // If there are no images, display a message.
              //       return Text('No images to display');
              //     } else {
              //       // If data is available, build the list of Image widgets.
              //       _profileImages = snapshot.data!;
              //       return SingleChildScrollView(
              //         scrollDirection: Axis.vertical,
              //         child: ListView.builder(
              //           itemCount: _profileImages.length,
              //           itemBuilder: (context, index) {
              //             return Image.file(
              //               File(_profileImages[index]['profile_image']),
              //               fit: BoxFit
              //                   .cover, // You can adjust the fit as needed.
              //             );
              //           },
              //         ),
              //       );
              //     }
              //   },
              // )

              // Container(
              //   height: 100,
              //   width: 100,
              //   child: imagePath == null
              //       ? Text("No Image")
              //       : Image.file(File(imagePath!)),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
