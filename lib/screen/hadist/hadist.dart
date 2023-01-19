import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/screen/dashboard.dart';

class Hadist extends StatefulWidget {
  const Hadist({Key? key}) : super(key: key);

  @override
  _HadistState createState() => _HadistState();
}

class _HadistState extends State<Hadist> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(
          () => Dashboard(),
          transition: Transition.fade,
          duration: Duration(seconds: 1),
        );
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color.fromARGB(255, 219, 235, 240),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: width * 0.1,
              ),
              header(height, width, context),
            ],
          )),
    );
  }
}

Widget header(height, width, context) {
  return Container(
    margin: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipOval(
          child: IconButton(
            icon: Icon(
              Icons.home_outlined,
              size: width * 0.08,
              color: Color.fromRGBO(32, 105, 95, 1),
            ),
            onPressed: () {
              Get.offAll(
                () => Dashboard(),
                transition: Transition.fade,
                duration: Duration(seconds: 1),
              );
            },
          ),
        ),
        Text(
          'myQuran',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(33, 139, 95, 1),
          ),
        ),
        SizedBox(
          width: width * 0.08,
        )
      ],
    ),
  );
}
