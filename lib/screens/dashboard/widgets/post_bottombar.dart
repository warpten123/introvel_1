import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PostBottomBar extends StatefulWidget {
  const PostBottomBar({super.key});

  @override
  State<PostBottomBar> createState() => _PostBottomBarState();
}

class _PostBottomBarState extends State<PostBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
          color: Color(0xFFEDF2F6),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "City Name, Country",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        Text(
                          "4.5",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1),
                            child: Image.asset(
                              "assets/list5.jpg",
                              fit: BoxFit.cover,
                              width: 120,
                              height: 90,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1),
                            child: Image.asset(
                              "assets/simala.jpg",
                              fit: BoxFit.cover,
                              width: 120,
                              height: 90,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1),
                            child: Image.asset(
                              "assets/list1.jpg",
                              fit: BoxFit.cover,
                              width: 120,
                              height: 90,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
