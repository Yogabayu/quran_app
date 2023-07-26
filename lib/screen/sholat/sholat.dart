import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:quran_app/controller/sholatController.dart';
import 'package:quran_app/model/scheduleModel.dart';
import 'package:quran_app/screen/dashboard.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Sholat extends StatefulWidget {
  const Sholat({Key? key}) : super(key: key);

  @override
  _SholatState createState() => _SholatState();
}

class _SholatState extends State<Sholat> {
  List<dynamic> filteredList = <dynamic>[];
  final SholatController _sholatController = Get.put(SholatController());
  late Future<List<dynamic>> futureCitis;
  late Future<Schedule_model> scheduleCitis;
  List<dynamic> citiesData = [];
  Schedule_model? scheduleData;
  String? idSelectedCity;
  DateTime selectedDate = DateTime.now();
  late int year = selectedDate.year, month = selectedDate.month;
  bool isSuccess = false;

  @override
  void initState() {
    super.initState();
    futureCitis = _sholatController.fetchCity();
    futureCitis.then((cities) {
      setState(() {
        citiesData = cities;
        filteredList = cities;
      });
    });
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
              margin: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.15,
                    child: Text(
                      "Lokasi",
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(33, 139, 95, 1),
                      ),
                    ),
                  ),
                  Text(
                    ": ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(32, 105, 95, 1),
                      fontSize: width * 0.04,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.6,
                    child: DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        showSelectedItems: true,
                      ),
                      items: filteredList
                          .map((city) => city['lokasi'].toString())
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          idSelectedCity = citiesData.firstWhere(
                              (city) => city['lokasi'] == value)['id'];
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            spacer(height),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.15,
                    child: Text(
                      "Bulan",
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(33, 139, 95, 1),
                      ),
                    ),
                  ),
                  Text(
                    ": ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(32, 105, 95, 1),
                      fontSize: width * 0.04,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.6,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(width * 0.025),
                        ),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          showMonthPicker(
                            context: context,
                            initialDate: DateTime.now(),
                          ).then((date) {
                            if (date != null) {
                              setState(() {
                                selectedDate = date;
                                year = selectedDate.year;
                                month = selectedDate.month;
                              });
                            }
                          });
                        },
                        child: Text(
                          '$month - $year',
                          style: TextStyle(
                            color: Color.fromRGBO(32, 105, 95, 1),
                            fontSize: width * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            spacer(height),
            ElevatedButton(
              onPressed: () async {
                scheduleCitis = _sholatController.fetchSchedule(
                    idSelectedCity, year, month);
                scheduleData = await scheduleCitis;
                setState(() {
                  isSuccess = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width * 0.02),
                ),
              ),
              child: Text(
                'Cek jadwal',
                style: TextStyle(
                  color: Color.fromRGBO(32, 105, 95, 1),
                  fontSize: width * 0.04,
                ),
              ),
            ),
            isSuccess
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                        height: height * 0.53,
                        child: ListView.builder(
                          itemCount: scheduleData!.data!.jadwal!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: height * 0.15,
                              margin: EdgeInsets.only(bottom: width * 0.04),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    scheduleData!.data!.jadwal![index].tanggal!,
                                    style: TextStyle(
                                      color: Color.fromRGBO(32, 105, 95, 1),
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: width * 0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      colData(
                                          width,
                                          'imsak',
                                          scheduleData!
                                              .data!.jadwal![index].imsak!),
                                      colData(
                                          width,
                                          'subuh',
                                          scheduleData!
                                              .data!.jadwal![index].subuh!),
                                      colData(
                                          width,
                                          'terbit',
                                          scheduleData!
                                              .data!.jadwal![index].terbit!),
                                      colData(
                                          width,
                                          'dhuha',
                                          scheduleData!
                                              .data!.jadwal![index].dhuha!),
                                    ],
                                  ),
                                  SizedBox(
                                    height: width * 0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      colData(
                                          width,
                                          'dzuhur',
                                          scheduleData!
                                              .data!.jadwal![index].dzuhur!),
                                      colData(
                                          width,
                                          'ashar',
                                          scheduleData!
                                              .data!.jadwal![index].ashar!),
                                      colData(
                                          width,
                                          'maghrib',
                                          scheduleData!
                                              .data!.jadwal![index].maghrib!),
                                      colData(
                                          width,
                                          'isya',
                                          scheduleData!
                                              .data!.jadwal![index].isya!),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Text(" "),
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

Widget rowData(title, data, width, height) {
  return Row(
    children: [
      SizedBox(
        width: width * 0.1,
        child: Text(
          title,
          style: TextStyle(
            fontSize: height * 0.025,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
      SizedBox(
        width: 10,
        child: Text(" : "),
      ),
      SizedBox(
        child: Text(
          data,
          style: TextStyle(
            fontSize: height * 0.025,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    ],
  );
}

Widget colData(width, judul, data) {
  return Column(
    children: [
      Text(
        judul,
        style: TextStyle(
          color: Color.fromRGBO(32, 105, 95, 1),
          fontSize: width * 0.035,
          fontWeight: FontWeight.w700,
        ),
      ),
      Text(
        data,
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 1),
          fontSize: width * 0.035,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}
