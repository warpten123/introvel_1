import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:camera/camera.dart';

class CameraAppBar extends StatefulWidget {
  const CameraAppBar({super.key});

  @override
  State<CameraAppBar> createState() => _CameraAppBarState();
}

class _CameraAppBarState extends State<CameraAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15)),
              child: Icon(
                Icons.arrow_back,
                size: 28,
              ),
            ),
          ),
          Text(
            "PICK FROM CAMERA",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
