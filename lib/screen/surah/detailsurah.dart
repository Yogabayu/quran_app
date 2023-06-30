import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_app/controller/allSurahController.dart';
import 'package:quran_app/model/detailsurahmodel.dart';
import 'package:quran_app/screen/surah/allsurahsc.dart';
import 'package:quran_app/screen/components/bookmarkbtn.dart';
import 'package:quran_app/screen/components/playbutton.dart';
import 'package:quran_app/screen/dashboard.dart';
import 'package:share_plus/share_plus.dart';

class Detailsurah extends StatefulWidget {
  final String? name, arti, city, noAyat;
  final int? no, total;
  const Detailsurah({
    Key? key,
    this.no,
    this.total,
    this.name,
    this.arti,
    this.city,
    this.noAyat,
  }) : super(key: key);

  @override
  _DetailsurahState createState() => _DetailsurahState();
}

class _DetailsurahState extends State<Detailsurah> {
  final storage = GetStorage();
  final AllSurahController _allSUrahC = Get.put(AllSurahController());
  late Future<DetailSurahModel> _futureDetail;

  @override
  void initState() {
    super.initState();
    _futureDetail = _allSUrahC.fetchDetailSurah(widget.no);
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
        body: FutureBuilder(
          future: _futureDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  SizedBox(
                    height: width * 0.1,
                  ),
                  header(height, width, context, snapshot.data!.namaLatin),
                  SizedBox(
                    height: width * 0.04,
                  ),
                  midBox(
                    width,
                    height,
                    snapshot.data!.nomor,
                    snapshot.data!.namaLatin,
                    snapshot.data!.arti,
                    snapshot.data!.tempatTurun,
                    snapshot.data!.jumlahAyat,
                    snapshot.data!.audio,
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    width: width * 0.5,
                    height: height * 0.08,
                    child: Image.asset("assets/bismillah2.png"),
                  ),
                  SizedBox(
                    height: width * 0.04,
                  ),
                  ayat(
                      storage,
                      context,
                      width,
                      height,
                      snapshot.data!.jumlahAyat,
                      snapshot.data!.nomor,
                      snapshot.data!.ayat,
                      snapshot.data!.namaLatin,
                      widget.noAyat),
                ],
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Container(
                  width: width,
                  height: width * 0.5,
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          '${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        margin: EdgeInsets.all(20),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container(
              width: width,
              height: width * 0.5,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget ayat(storage, context, width, height, lenght, noSurah, List<Ayat>? ayat,
    nameSurah, noAyat) {
  return Container(
    width: width * 0.9,
    height: height * 0.5,
    child: ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: lenght,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
            bottom: width * 0.02,
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 169, 186, 197),
                    borderRadius:
                        BorderRadius.all(Radius.circular(width * 0.4))),
                height: width * 0.1,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      padding: EdgeInsets.all(width * 0.01),
                      margin: EdgeInsets.only(left: width * 0.05),
                      child: Text(
                        "${ayat![index].nomor}",
                      ),
                    ),
                    SizedBox(
                      width: width * 0.5,
                    ),
                    if (noAyat.toString() == ayat[index].nomor.toString())
                      Bookmarkbtn(
                          nameSurah: nameSurah,
                          noSurah: noSurah,
                          noayat: ayat[index].nomor,
                          isSave: true),
                    if (noAyat.toString() != ayat[index].nomor.toString())
                      Bookmarkbtn(
                          nameSurah: nameSurah,
                          noSurah: noSurah,
                          noayat: ayat[index].nomor,
                          isSave: false),
                    IconButton(
                      onPressed: () {
                        Share.share(
                            'Alhamdulilah, Saya sedang membaca myQuran Surah ${nameSurah} sampai Ayat ${ayat[index].nomor}');
                      },
                      icon: Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: width * 0.04),
                width: width * 0.8,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "${ayat[index].ar}",
                    style:
                        TextStyle(fontSize: 20, overflow: TextOverflow.visible),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: width * 0.04),
                width: width * 0.8,
                child: Text("${ayat[index].idn}"),
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget midBox(width, height, no, name, arti, city, total, url) {
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
          top: width * 0.2,
          left: width * 0.28,
          child: PlayButton(url: url, id: "11"),
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
      ],
    ),
  );
}
