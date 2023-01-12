import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/screen/dashboard.dart';

class Allsurah extends StatefulWidget {
  const Allsurah({Key? key}) : super(key: key);

  @override
  _AllsurahState createState() => _AllsurahState();
}

class _AllsurahState extends State<Allsurah> {
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
        backgroundColor: Color.fromARGB(255, 219, 235, 240),
        body: Column(
          children: [
            SizedBox(
              height: width * 0.1,
            ),
            header(height, width, context),
            spacer(height),
            Container(
              width: width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(width * 0.07)),
              ),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.white),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: 'Cari Surah',
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.car_rental),
              title: Text('Car'),
              trailing: Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}

Widget spacer(height) {
  return SizedBox(
    height: height * 0.04,
  );
}

Widget header(height, width, context) {
  return Container(
    margin: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipOval(
          child: Icon(
            Icons.home_outlined,
            size: width * 0.08,
            color: Color.fromRGBO(32, 105, 95, 1),
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
