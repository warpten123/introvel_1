import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:introvel_1/models/picture_diary.dart';
import 'package:introvel_1/provider/user_provider.dart';
import 'package:introvel_1/screens/dashboard/welcome_screen.dart';
import 'package:introvel_1/screens/dashboard/widgets/home_bottombar.dart';
import 'package:introvel_1/screens/dashboard/widgets/view_album/albums_list.dart';
import 'package:introvel_1/screens/reusable_components/grid_card.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../sql/sql_helper.dart';
import 'image_details.dart';
import 'widgets/home_app_bar.dart';

class Dashboard extends StatefulWidget {
  Dashboard(this.user, {super.key});
  User user;
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var category = [
    'Best Places',
    'Most Visited',
    'Favourites',
    'New Added',
    'Restaurants',
    'Hotels',
  ];

  void getDiaries() async {
    List<Map<String, dynamic>> _profileImages = [];
    final data = await SQLHelper.getProfileDiariesUser(widget.user.id!);
    setState(() {
      _profileImages = data;
    });
    print("LENGTH: ${_profileImages.length}");
  }

  @override
  void initState() {
    super.initState();
    getDiaries();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.0),
          child: HomeAppBar(widget.user),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 200,
                        child: ListView.builder(
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {},
                                child: Container(
                                  width: 160,
                                  padding: EdgeInsets.all(20),
                                  margin: EdgeInsets.only(left: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/list${index + 1}.jpg"),
                                        fit: BoxFit.cover,
                                        opacity: 0.7),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.topRight,
                                        child: Icon(
                                          Icons.bookmark_border_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "City Name",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          for (int i = 0; i < 6; i++)
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Text(
                                category[i],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Your Snaps!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: SQLHelper.getProfileDiariesUser(widget.user.id!),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      // getDiaries();
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      // if (images.length == 0) {
                      //   return Center(
                      //       child: Container(child: Text("NO IMAGES YET")));
                      // }
                      final images = snapshot.data!;
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: images.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      final diary = Picture_Diary(
                                          description: images[index]
                                              ['description'],
                                          taken_at: images[index]['taken_at'],
                                          user_id: images[index]['user_id'],
                                          location: images[index]['location'],
                                          image: images[index]['image'],
                                          title: images[index]['title']);

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WelcomeScreen(diary)),
                                      ); //
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           const ImageDetails()),
                                      // );
                                    },
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: FileImage(
                                                File(images[index]['image'])),
                                            fit: BoxFit.cover,
                                            opacity: 0.8),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${images[index]['title']}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              final result = await SQLHelper
                                                  .storeDiaryInAlbum(
                                                      userProvider
                                                          .getStoredUserId(),
                                                      images[index]['id'],
                                                      1);

                                              print(result);
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           AlbumsList()),
                                              // ); //
                                            },
                                            icon: Icon(Icons.more_vert))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.amber,
                                          size: 20,
                                        ),
                                        Text(
                                          "${images[index]['location']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: HomeBottomBar(widget.user.path),
      ),
    );
  }
}
