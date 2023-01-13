import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:quran_app/controller/allSurahController.dart';
import 'package:quran_app/model/allSurahModel.dart';
import 'package:quran_app/screen/dashboard.dart';
// import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllsurahSc extends StatefulWidget {
  const AllsurahSc({Key? key}) : super(key: key);

  @override
  _AllsurahScState createState() => _AllsurahScState();
}

class _AllsurahScState extends State<AllsurahSc> {
  Future<List<AllSurahModel>> fetchUsers() async {
    var response = await http
        .get(Uri.parse("https://quran-api.santrikoding.com/api/surah/"));
    return (json.decode(response.body) as List)
        .map((e) => AllSurahModel.fromJson(e))
        .toList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    TextEditingController _searchController = TextEditingController();

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
            search(width, height, _searchController, context),
            FutureBuilder<List<AllSurahModel>>(
              future: fetchUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<AllSurahModel> surah =
                      snapshot.data as List<AllSurahModel>;
                  return Container(
                    width: width * 0.86,
                    height: height * 0.75,
                    child: ListView.builder(
                      itemCount: surah.length,
                      itemBuilder: (context, index) {
                        return listSurah(
                            width,
                            height,
                            surah[index].namaLatin,
                            surah[index].tempatTurun,
                            surah[index].jumlahAyat,
                            surah[index].nama,
                            index + 1);
                      },
                    ),
                  );
                }
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Text('error');
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget listSurah(width, height, name, loc, total, arab, index) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Stack(
      children: [
        Image.asset(
          'assets/frame.png',
          width: width * 0.2,
        ),
        if (index < 10)
          Positioned(
            left: width * 0.09,
            top: width * 0.046,
            child: Text(
              "$index",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.clip),
            ),
          ),
        if (index >= 10 && index < 100)
          Positioned(
            left: width * 0.082,
            top: width * 0.046,
            child: Text(
              "$index",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.clip),
            ),
          ),
        if (index >= 100)
          Positioned(
            left: width * 0.07,
            top: width * 0.046,
            child: Text(
              "$index",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.clip),
            ),
          )
      ],
    ),
    title: Text(
      name,
      style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      "$loc - $total Ayat",
      style: TextStyle(
        fontSize: width * 0.03,
        color: Color.fromARGB(120, 3, 3, 3),
      ),
    ),
    trailing: Text(
      arab,
      style: TextStyle(
        color: Color.fromARGB(255, 31, 104, 34),
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget search(width, height, controller, context) {
  return Container(
    width: width * 0.86,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(width * 0.07)),
    ),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
  );
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
