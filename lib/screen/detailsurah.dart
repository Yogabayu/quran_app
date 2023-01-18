import 'dart:async';
import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_app/model/detailsurahmodel.dart';
import 'package:quran_app/screen/allsurahsc.dart';
// import 'package:http/http.dart' as http;

import 'package:http/io_client.dart';
import 'dart:convert';

import 'package:quran_app/screen/dashboard.dart';
import 'package:share_plus/share_plus.dart';

class Detailsurah extends StatefulWidget {
  final int? no;
  final int? total;
  final String? name;
  final String? arti;
  final String? city;
  const Detailsurah({
    Key? key,
    this.no,
    this.total,
    this.name,
    this.arti,
    this.city,
  }) : super(key: key);

  @override
  _DetailsurahState createState() => _DetailsurahState();
}

class _DetailsurahState extends State<Detailsurah> {
  final storage = GetStorage();
  late Future<DetailSurahModel> _futureDetail;
  bool _isPlaying = false;
  bool _isPaused = false;
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

  void play() async {
    setState(() {
      _isPlaying = true;
    });
  }

  void pause() async {
    setState(() {
      _isPlaying = false;
    });
  }

  void resume() async {
    setState(() {
      _isPlaying = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _futureDetail = fetchSurah();
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
                      snapshot.data!.jumlahAyat),
                  Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    width: width * 0.5,
                    height: height * 0.08,
                    child: Image.asset("assets/bismillah2.png"),
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    width: width * 0.5,
                    height: height * 0.08,
                    child: Row(
                      children: [
                        Text("Putar Audio: "),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: (_isPlaying)
                              ? Icon(
                                  Icons.pause,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                          onPressed: () => _isPlaying
                              ? pause()
                              : _isPaused
                                  ? resume()
                                  : play(),
                        )
                      ],
                    ),
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
                      snapshot.data!.namaLatin),
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
    nameSurah) {
  return Container(
    width: width * 0.9,
    height: height * 0.5,
    child: ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: lenght,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 169, 186, 197),
                  borderRadius: BorderRadius.all(Radius.circular(width * 0.4))),
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
                    width: width * 0.4,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      try {
                        storage.write('name', nameSurah);
                        storage.write('id', noSurah);
                        storage.write('noayat', "${ayat[index].nomor}");
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Sukses menyimpan"),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${e}"),
                          ),
                        );
                      }
                    },
                    icon: Icon(
                      Icons.bookmark_add,
                      color: Colors.white,
                    ),
                  ),
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
              height: width * 0.35,
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
              height: width * 0.1,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [Text("${ayat[index].idn}")],
              ),
            ),
          ],
        );
      },
    ),
  );
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

// class PlayButton extends StatefulWidget {
//   final String id;
//   final String url;

//   const PlayButton({Key? key, required this.url, required this.id})
//       : super(key: key);

//   @override
//   _PlayButtonState createState() => _PlayButtonState();
// }

// class _PlayButtonState extends State<PlayButton> {
//   bool _isPlaying = false;
//   bool _isPaused = false;

//   void play() async {
//     setState(() {
//       _isPlaying = true;
//       print(widget.url);
//     });
//   }

//   void pause() async {
//     setState(() {
//       _isPlaying = false;
//       print(widget.url);
//     });
//   }

//   void resume() async {
//     setState(() {
//       _isPlaying = true;
//       print(widget.url);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       padding: EdgeInsets.zero,
//       icon: (_isPlaying)
//           ? Icon(
//               Icons.pause,
//               color: Colors.white,
//             )
//           : Icon(
//               Icons.play_arrow,
//               color: Colors.white,
//             ),
//       onPressed: () => _isPlaying
//           ? pause()
//           : _isPaused
//               ? resume()
//               : play(),
//     );
//   }
// }
