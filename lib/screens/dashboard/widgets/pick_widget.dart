import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:introvel_1/screens/dashboard/pick_from_gallery.dart';

import '../../../models/user.dart';

class PickSourceImage extends StatelessWidget {
  PickSourceImage(this.user, {super.key});
  User user;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Center(
              child: Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 10)),
                  ],
                ),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          color: Colors.blue,
                          child: Card(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 50,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          color: Colors.blue,
                          child: Card(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FromGallery(user)),
                                );
                              },
                              child: Icon(
                                Icons.photo_album,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
