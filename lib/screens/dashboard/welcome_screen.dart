import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:introvel_1/models/picture_diary.dart';
import 'package:introvel_1/screens/dashboard/user-dashboard.dart';
import 'package:introvel_1/utilities/util.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen(this.diary, {super.key});
  Picture_Diary diary;
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(File(widget.diary.image)),
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 65, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ignore: prefer_const_constructors
                  Text(
                    "${widget.diary.title}",
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                  SizedBox(
                    height: 2,
                  ),

                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "${widget.diary.description}",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 22,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Snapped at: ${convertDate(widget.diary.taken_at)}",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const Dashboard()),
                      // );
                    },
                    child: Ink(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black54,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
