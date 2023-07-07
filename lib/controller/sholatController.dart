import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:quran_app/model/scheduleModel.dart';
// import 'package:quran_app/model/cityModel.dart';

class SholatController extends GetxController {
  Future<List<dynamic>> fetchCity() async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      var response = await http
          .get(Uri.parse("https://api.myquran.com/v1/sholat/kota/semua"));
      // return CityModel.fromJson(json.decode(response.body));
      List<dynamic> cityData = json.decode(response.body);
      // print(cityData);

      return cityData;
    } on SocketException {
      throw 'Mohon Cek internet anda';
    } on TimeoutException {
      throw 'Waktu habis. Silahkan Reload halaman';
    }
  }

  Future<Schedule_model> fetchSchedule(idCity, tahun, bulan) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      var response = await http.get(Uri.parse(
          "https://api.myquran.com/v1/sholat/jadwal/$idCity/$tahun/$bulan"));
      return Schedule_model.fromJson(json.decode(response.body));
    } on SocketException {
      throw 'Mohon Cek internet anda';
    } on TimeoutException {
      throw 'Waktu habis. Silahkan Reload halaman';
    }
  }
}
