import 'package:flutter/material.dart';

class Grid_Card extends StatefulWidget {
  Grid_Card({Key? key}) : super(key: key);

  @override
  _Grid_CardtState createState() => _Grid_CardtState();
}

class _Grid_CardtState extends State<Grid_Card> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GridView.builder(
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: AssetImage("assets/list${index + 1}.jpg"),
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
          },
        ),
      ),
    );
  }
}
