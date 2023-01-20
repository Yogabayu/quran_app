import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/controller/hadistController.dart';
import 'package:quran_app/model/detailHadistModel.dart';
import 'package:quran_app/screen/dashboard.dart';
import 'package:quran_app/screen/hadist/hadist.dart';
import 'package:share_plus/share_plus.dart';

class Detailhadist extends StatefulWidget {
  final String id;
  final String first;
  final String second;
  const Detailhadist({
    Key? key,
    required this.id,
    required this.first,
    required this.second,
  }) : super(key: key);

  @override
  _DetailhadistState createState() => _DetailhadistState();
}

class _DetailhadistState extends State<Detailhadist> {
  List<Hadiths> filteredList = <Hadiths>[];
  List<Hadiths> gettedList = <Hadiths>[];
  late Data detailListHadist;
  final HadistController _controller = Get.put(HadistController());
  late Future<DetailHadist> futureDetail;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureDetail =
        _controller.detailBooks(widget.id, widget.first, widget.second);
    futureDetail.then((value) {
      detailListHadist = value.data!;
      value.data!.hadiths!.forEach((element) {
        setState(() {
          filteredList.add(element);
          gettedList.add(element);
        });
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(
          () => Hadist(),
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
            header(height, width, context),
            spacer(height),
            Container(
              width: width * 0.86,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(width * 0.07)),
              ),
              child: TextField(
                onChanged: (value) async {
                  var text = value.toString().toLowerCase();
                  filteredList.clear();
                  gettedList.forEach(
                    (element) {
                      if (element.id!.contains(text)) {
                        setState(() {
                          filteredList.add(element);
                        });
                      }
                    },
                  );
                  print(filteredList.length);
                },
                controller: _searchController,
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
                  hintText: 'Cari Topik',
                ),
              ),
            ),
            spacer(height),
            filteredList.isEmpty || filteredList.length == 0
                ? Container(
                    margin: EdgeInsets.only(top: width * 0.2),
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: width * 0.9,
                    height: height * 0.7,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 169, 186, 197),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(width * 0.4))),
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
                                      filteredList[index].number.toString(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.6,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Share.share(
                                          'Alhamdulilah, Saya sedang membaca Hadist dari ${detailListHadist.name} dari myQuran App by Yoga Dev');
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
                              height: width * 0.6,
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                children: [
                                  Text(
                                    filteredList[index].arab.toString(),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: width * 0.04),
                              width: width * 0.8,
                              height: width * 0.3,
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                children: [
                                  Text(
                                    filteredList[index].id.toString(),
                                    style: TextStyle(
                                        fontSize: width * 0.03,
                                        overflow: TextOverflow.clip),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
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
