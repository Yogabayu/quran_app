import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:quran_app/model/allSurahModel.dart';
import 'package:http/http.dart' as http;

class AllSurahController extends GetxController {
  Future<List<AllSurahModel>> fetchSurah() async {
    try {
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
}
