import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:quran_app/model/booksHadistModel.dart';
import 'package:quran_app/model/detailHadistModel.dart';

class HadistController extends GetxController {
  Future<BooksHadist> getBooks() async {
    try {
      Future.delayed(Duration(seconds: 3));
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      final response = await http.get(
        Uri.parse(
          "https://api.hadith.gading.dev/books",
        ),
      );
      if (response.statusCode == 200) {
        BooksHadist resp = BooksHadist.fromJson(jsonDecode(response.body));
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

  Future<DetailHadist> detailBooks(id, first, second) async {
    try {
      Future.delayed(Duration(seconds: 3));
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      final response = await http.get(
        Uri.parse(
          "https://api.hadith.gading.dev/books/${id}?range=${first}-${second}",
        ),
      );
      if (response.statusCode == 200) {
        DetailHadist resp = DetailHadist.fromJson(jsonDecode(response.body));
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
