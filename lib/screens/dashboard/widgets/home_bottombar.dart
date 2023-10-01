import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeBottomBar extends StatelessWidget {
  HomeBottomBar(this.path, {super.key});
  String? path;
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      items: [
        Icon(
          Icons.home,
          size: 30,
        ),
        Icon(
          Icons.favorite_outline,
          size: 30,
        ),
        Icon(
          Icons.add,
          size: 30,
        ),
        Icon(
          Icons.book,
          size: 30,
        ),
        path != null
            ? CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                // ignore: prefer_const_constructors
                backgroundImage: AssetImage(""),
              )
            : CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                // ignore: prefer_const_constructors
                backgroundImage: AssetImage("assets/placeholder.jpg"),
              ),
      ],
      backgroundColor: Colors.blue,
      buttonBackgroundColor: Colors.white,
    );
  }
}
