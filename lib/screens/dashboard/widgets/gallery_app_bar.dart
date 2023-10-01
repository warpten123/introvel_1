import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FromGalleryAppBar extends StatefulWidget {
  const FromGalleryAppBar({super.key});

  @override
  State<FromGalleryAppBar> createState() => _FromGalleryAppBarState();
}

class _FromGalleryAppBarState extends State<FromGalleryAppBar> {
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
            "PICK FROM GALLERY",
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
