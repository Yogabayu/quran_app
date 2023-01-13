import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:quran_app/model/allSurahModel.dart';
// import 'package:http/http.dart' as http;

class AllSurahController extends GetxController {
  Future<AllSurahModel> getData() async {
    try {
      Future.delayed(Duration(seconds: 3));
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      final response = await http.get(
        Uri.parse(
          "https://quran-api.santrikoding.com/api/surah/",
        ),
      );
      // print(response.body);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        AllSurahModel resp =
            AllSurahModel.fromJson(json as Map<String, dynamic>);
        return resp;
        // return AllSurahModel.fromJson(jsonDecode(response.body));
      } else {
        // print(response.statusCode);
        throw 'Gagal mengambil data, cek kembali inputan anda';
      }
    } on SocketException {
      throw 'Mohon Cek internet anda';
    } on TimeoutException {
      throw 'Waktu habis. Silahkan Reload halaman';
    }
  }
}
