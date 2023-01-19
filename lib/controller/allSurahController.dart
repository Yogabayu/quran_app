import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:quran_app/model/allSurahModel.dart';
import 'package:quran_app/model/detailsurahmodel.dart';

class AllSurahController extends GetxController {
  Future<List<AllSurahModel>> fetchSurah() async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      var response = await http
          .get(Uri.parse("https://quran-api.santrikoding.com/api/surah/"));
      return (json.decode(response.body) as List)
          .map((e) => AllSurahModel.fromJson(e))
          .toList();
    } on SocketException {
      throw 'Mohon Cek internet anda';
    } on TimeoutException {
      throw 'Waktu habis. Silahkan Reload halaman';
    }
  }

  Future<DetailSurahModel> fetchDetailSurah(no) async {
    try {
      Future.delayed(Duration(seconds: 3));
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      final response = await http.get(
        Uri.parse(
          "https://quran-api.santrikoding.com/api/surah/${no}",
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
}
