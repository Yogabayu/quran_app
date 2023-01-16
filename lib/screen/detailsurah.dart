import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/model/detailsurahmodel.dart';
import 'package:quran_app/screen/allsurahsc.dart';
// import 'package:http/http.dart' as http;

import 'package:http/io_client.dart';
import 'dart:convert';

class Detailsurah extends StatefulWidget {
  final int no;
  final int total;
  final String name;
  final String arti;
  final String city;
  const Detailsurah({
    Key? key,
    required this.no,
    required this.total,
    required this.name,
    required this.arti,
    required this.city,
  }) : super(key: key);

  @override
  _DetailsurahState createState() => _DetailsurahState();
}

class _DetailsurahState extends State<Detailsurah> {
  late Future<DetailSurahModel> _futureDetail;

  Future<DetailSurahModel> fetchSurah() async {
    try {
      Future.delayed(Duration(seconds: 3));
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      final response = await http.get(
        Uri.parse(
          "https://quran-api.santrikoding.com/api/surah/${widget.no}",
        ),
      );
      // print(response.body);
      if (response.statusCode == 200) {
        DetailSurahModel resp =
            DetailSurahModel.fromJson(jsonDecode(response.body));
        return resp;
      } else {
        throw 'Gagal mengambil data, cek kembali inputan anda';
      }
    } on SocketException {
      throw 'Mohon Cek internet anda';
    } on TimeoutException {
      throw 'Waktu habis. Silahkan Reload halaman';
    }
  }

  @override
  void initState() {
    super.initState();
    _futureDetail = fetchSurah();
    print(_futureDetail);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(
          () => AllsurahSc(),
          transition: Transition.fade,
          duration: Duration(seconds: 1),
        );
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 219, 235, 240),
        body: Column(
          children: [
            SizedBox(
              height: width * 0.1,
            ),
            header(height, width, context, widget.name),
            SizedBox(
              height: width * 0.04,
            ),
            midBox(width, height, widget.no, widget.name, widget.arti,
                widget.city, widget.total),
            SizedBox(
              height: width * 0.04,
            ),
            Container(
              width: width * 0.9,
              height: height * 0.6,
              child: FutureBuilder(
                future: _futureDetail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.arti!);
                  }
                  if (snapshot.hasError) {
                    return Text("Error");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget midBox(width, height, no, name, arti, city, total) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color.fromARGB(255, 170, 221, 136),
          Color.fromARGB(255, 107, 170, 55),
        ],
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(width * 0.06),
      ),
    ),
    width: width * 0.7,
    height: height * 0.2,
    child: Stack(
      children: [
        Positioned(
          left: width * 0.27,
          child: Image.asset(
            'assets/frame.png',
            width: width * 0.13,
          ),
        ),
        if (no < 10)
          Positioned(
            left: width * 0.325,
            top: width * 0.04,
            child: Text(
              no.toString(),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        if (no >= 10 && no < 100)
          Positioned(
            left: width * 0.315,
            top: width * 0.04,
            child: Text(
              no.toString(),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        if (no >= 100)
          Positioned(
            left: width * 0.31,
            top: width * 0.045,
            child: Text(
              no.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.029),
            ),
          ),
        if (name.toString().length <= 7)
          Positioned(
            top: width * 0.12,
            left: width * 0.28,
            child: Column(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.04,
                  ),
                ),
                Text(
                  arti,
                  style: TextStyle(
                    color: Color.fromARGB(171, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.03,
                  ),
                ),
              ],
            ),
          ),
        if (name.toString().length > 7)
          Positioned(
            top: width * 0.12,
            left: width * 0.25,
            child: Column(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.04,
                  ),
                ),
                Text(
                  arti,
                  style: TextStyle(
                    color: Color.fromARGB(171, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.03,
                  ),
                ),
              ],
            ),
          ),
        Positioned(
          top: width * 0.3,
          left: width * 0.24,
          child: Text(
            "${city} - ${total} ayat",
            style: TextStyle(
              color: Color.fromARGB(171, 255, 255, 255),
              fontWeight: FontWeight.bold,
              fontSize: width * 0.03,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget header(height, width, context, name) {
  return Container(
    margin: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipOval(
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: width * 0.06,
              color: Color.fromRGBO(32, 105, 95, 1),
            ),
            onPressed: () {
              Get.offAll(
                () => AllsurahSc(),
                transition: Transition.fade,
                duration: Duration(seconds: 1),
              );
            },
          ),
        ),
        Text(
          name,
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
