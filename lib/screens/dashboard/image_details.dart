import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:introvel_1/screens/dashboard/widgets/image_details_appbar.dart';
import 'package:introvel_1/screens/dashboard/widgets/post_bottombar.dart';

class ImageDetails extends StatefulWidget {
  const ImageDetails({super.key});

  @override
  State<ImageDetails> createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/list4.jpg'),
              fit: BoxFit.cover, //CHANGE THIS
              opacity: 0.7)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: ImageDetailsAppBar(),
        ),
        bottomNavigationBar: PostBottomBar(),
      ),
    );
  }
}
