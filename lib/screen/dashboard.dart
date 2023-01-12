import 'package:flutter/material.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'dart:ui';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(203, 228, 235, 1),
      body: Column(
        children: [
          SizedBox(
            height: width * 0.1,
          ),
          header(),
          image(height, width),
          spacer(height),
          Text("data"),
        ],
      ),
    );
  }
}

Widget spacer(height) {
  return SizedBox(
    height: height * 0.02,
  );
}

Widget header() {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'myQuran',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(33, 139, 95, 1),
          ),
        ),
      ],
    ),
  );
}

Widget image(height, width) {
  return Center(
    child: DropShadowImage(
      image: Image.asset(
        'assets/quran.png',
        height: height * 0.2,
        width: width * 0.35,
      ),
    ),
  );
}
