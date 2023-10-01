import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ImageDetailsAppBar extends StatefulWidget {
  const ImageDetailsAppBar({super.key});

  @override
  State<ImageDetailsAppBar> createState() => _ImageDetailsAppBarState();
}

class _ImageDetailsAppBarState extends State<ImageDetailsAppBar> {
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
                    BoxShadow(color: Colors.white, blurRadius: 6),
                  ],
                  borderRadius: BorderRadius.circular(15)),
              child: Icon(
                Icons.arrow_back,
                size: 28,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 6),
                ],
              ),
              child: Icon(
                Icons.favorite,
                color: Colors.redAccent,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
