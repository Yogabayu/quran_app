import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quran_app/screen/dashboard.dart';
import 'package:url_launcher/url_launcher.dart';

class Pusatdata extends StatefulWidget {
  const Pusatdata({Key? key}) : super(key: key);

  @override
  _PusatdataState createState() => _PusatdataState();
}

class _PusatdataState extends State<Pusatdata> {
  Future<void> alaunchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

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
            spacer(height),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: width * 0.06, vertical: width * 0.02),
              width: width,
              height: height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Pusat Data",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.06,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: width * 0.07,
                  ),
                  Text(
                    "Data Al-Quran",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.04,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      "Pada bagian surah-surah (tulisan dan audio) Al-Quran data diambil dari API yang dimiliki oleh santrikoding.com dan aplikasi ini hanya berposisi sebagai 'penyampai/penyaji' jika ada yang salah silahkan beri masukkan ke developer",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.034,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: width * 0.07,
                  ),
                  Text(
                    "Data Hadist",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.04,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      "Pada bagian hadist (daftar ahli hadist dan daftar hadist) data diambil dari API yang dimiliki oleh tafsirq.com dan aplikasi ini hanya berposisi sebagai 'penyampai/penyaji' jika ada yang salah silahkan beri masukkan ke developer",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.034,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: width * 0.07,
                  ),
                  Text(
                    "Data Jadwal Sholat",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.04,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      "Pada bagian Jadwal Sholat (daftar wilayah dan detail jadwal) data diambil dari API yang dimiliki oleh Kemenag bimaislam via myQuran.com dan aplikasi ini hanya berposisi sebagai 'penyampai/penyaji' jika ada yang salah silahkan beri masukkan ke developer",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.034,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: width * 0.07,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.black,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            final Uri _url =
                                Uri.parse('https://github.com/Yogabayu');
                            alaunchUrl(_url);
                          },
                          icon: Icon(FontAwesomeIcons.github, size: 20),
                          label: Text(
                            'Github',
                            style: TextStyle(fontSize: 14),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            final Uri _url = Uri.parse(
                                'https://www.instagram.com/yogabayu.ap/');
                            alaunchUrl(_url);
                          },
                          icon: Icon(FontAwesomeIcons.instagram, size: 20),
                          label: Text(
                            'Instagram',
                            style: TextStyle(fontSize: 14),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 219, 235, 240),
      borderRadius: BorderRadius.all(Radius.circular(width * 0.025)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3), // Offset of the shadow
        ),
      ],
    ),
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
