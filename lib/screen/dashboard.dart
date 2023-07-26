import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_app/screen/hadist/hadist.dart';
import 'package:quran_app/screen/sholat/sholat.dart';
import 'package:quran_app/screen/surah/allsurahsc.dart';
import 'package:quran_app/screen/surah/detailsurah.dart';

import 'pusatdata/pusatdata.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    final String? nameSurah = storage.read('name');
    final idSurah = storage.read('id');
    final String? noAyat = storage.read('noayat').toString();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 219, 235, 240),
      body: Column(
        children: [
          SizedBox(
            height: width * 0.1,
          ),
          header(height, width, context),
          image(height, width, context),
          spacer(height),
          idSurah != null
              ? clipSurah(idSurah, nameSurah, noAyat, width, height, context)
              : clipSurah(idSurah, "Belum Ada", 0, width, height, context),
          spacer(height),
          Container(
            width: width * 0.8,
            height: height * 0.5,
            child: Stack(
              children: [
                leftUp(width, height, context),
                rightUp(width, height, context),
                leftBottom(width, height, context),
                rightBottom(width, height, context),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget rightBottom(width, height, context) {
  return Positioned(
    bottom: 0,
    right: width * 0.005,
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 136, 180, 221),
            Color.fromARGB(255, 55, 109, 170),
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(width * 0.07)),
      ),
      width: width * 0.35,
      height: height * 0.27,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: width * 0.02, top: width * 0.03),
            child: Image.asset(
              'assets/tajwid.png',
              height: height * 0.05,
              width: width * 0.2,
            ),
          ),
          SizedBox(
            height: width * 0.15,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.05),
            child: Text(
              "Hadist",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.04),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.03),
            child: TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () {
                Get.offAll(() => Hadist(), transition: Transition.fade);
              },
              child: Text(
                "Baca >",
                style: TextStyle(
                  color: Color.fromARGB(255, 201, 241, 56),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget leftBottom(width, height, context) {
  return Positioned(
    bottom: 0,
    left: width * 0.005,
    child: Container(
      padding: EdgeInsets.only(top: width * 0.04),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 136, 180, 221),
            Color.fromARGB(255, 55, 109, 170),
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(width * 0.07)),
      ),
      width: width * 0.35,
      height: height * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: width * 0.03),
            child: Icon(
              Icons.donut_large_sharp,
              color: Colors.amber,
              size: width * 0.1,
            ),
          ),
          SizedBox(
            height: width * 0.05,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.05),
            child: Text(
              "Pusat Data",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.04),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.03),
            child: TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () {
                Get.offAll(() => Pusatdata(), transition: Transition.fade);
              },
              child: Text(
                "Baca >",
                style: TextStyle(
                  color: Color.fromARGB(255, 201, 241, 56),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget rightUp(width, height, context) {
  return Positioned(
    right: width * 0.005,
    child: Container(
      padding: EdgeInsets.only(top: width * 0.04),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 136, 180, 221),
            Color.fromARGB(255, 55, 109, 170),
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(width * 0.07)),
      ),
      width: width * 0.35,
      height: height * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/bulanbintang.png',
            height: height * 0.06,
            width: width * 0.2,
          ),
          SizedBox(
            height: width * 0.05,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.05),
            child: Text(
              "Jadwal Sholat",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.04),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.03),
            child: TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () {
                Get.offAll(() => Sholat());
              },
              child: Text(
                "Baca >",
                style: TextStyle(
                  color: Color.fromARGB(255, 201, 241, 56),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget leftUp(width, height, context) {
  return Positioned(
    left: width * 0.005,
    child: Container(
      padding: EdgeInsets.only(top: width * 0.04),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 136, 180, 221),
            Color.fromARGB(255, 55, 109, 170),
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(width * 0.07)),
      ),
      width: width * 0.35,
      height: height * 0.27,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/surah.png',
            height: height * 0.08,
            width: width * 0.2,
          ),
          SizedBox(
            height: width * 0.15,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.05),
            child: Text(
              "Surah",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.04),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.03),
            child: TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () {
                Get.offAll(() => AllsurahSc());
              },
              child: Text(
                "Baca >",
                style: TextStyle(
                  color: Color.fromARGB(255, 201, 241, 56),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget clipSurah(id, name, noAyat, width, height, context) {
  return Container(
    margin: EdgeInsets.all(0),
    width: width * 0.8,
    height: height * 0.18,
    padding: EdgeInsets.all(width * 0.043),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color.fromARGB(255, 170, 221, 136),
          Color.fromARGB(255, 107, 170, 55),
        ],
      ),
      borderRadius: BorderRadius.all(Radius.circular(width * 0.07)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bacaan Terakhir",
              style: TextStyle(color: Color.fromARGB(160, 255, 255, 255)),
            ),
            Text(
              name,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.05),
            ),
            Text(
              "Ayat : " + noAyat.toString(),
              style: TextStyle(color: Colors.white),
            ),
            if (name != "Belum Ada")
              TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () {
                  Get.offAll(
                    () => Detailsurah(
                      no: id,
                      noAyat: noAyat,
                    ),
                    transition: Transition.fade,
                    duration: Duration(seconds: 1),
                  );
                },
                child: Text(
                  "Lanjutkan >",
                  style: TextStyle(
                    color: Color.fromARGB(255, 201, 241, 56),
                  ),
                ),
              ),
          ],
        ),
        Image.asset(
          'assets/surah.png',
          height: height * 0.2,
          width: width * 0.35,
        ),
      ],
    ),
  );
}

Widget spacer(height) {
  return SizedBox(
    height: height * 0.01,
  );
}

Widget header(height, width, context) {
  return Container(
    margin: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ClipOval(
        //   child: Icon(
        //     Icons.menu,
        //   ),
        // ),
        Text(
          'myQuran',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(33, 139, 95, 1),
          ),
        ),
        // ClipOval(
        //   child: Icon(
        //     Icons.person,
        //   ),
        // ),
      ],
    ),
  );
}

Widget image(height, width, context) {
  return Center(
    child: Image.asset(
      'assets/quran.png',
      height: height * 0.2,
      width: width * 0.35,
    ),
  );
}
