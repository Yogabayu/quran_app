class DetailSurahModel {
  bool? status;
  int? nomor;
  String? nama;
  String? namaLatin;
  int? jumlahAyat;
  String? tempatTurun;
  String? arti;
  String? deskripsi;
  String? audio;
  List<Ayat>? ayat;

  DetailSurahModel({
    this.status,
    this.nomor,
    this.nama,
    this.namaLatin,
    this.jumlahAyat,
    this.tempatTurun,
    this.arti,
    this.deskripsi,
    this.audio,
    this.ayat,
  });

  DetailSurahModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    nomor = json['nomor'];
    nama = json['nama'];
    namaLatin = json['nama_latin'];
    jumlahAyat = json['jumlah_ayat'];
    tempatTurun = json['tempat_turun'];
    arti = json['arti'];
    deskripsi = json['deskripsi'];
    audio = json['audio'];
    if (json['ayat'] != null) {
      ayat = <Ayat>[];
      json['ayat'].forEach((v) {
        ayat!.add(new Ayat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['nomor'] = this.nomor;
    data['nama'] = this.nama;
    data['nama_latin'] = this.namaLatin;
    data['jumlah_ayat'] = this.jumlahAyat;
    data['tempat_turun'] = this.tempatTurun;
    data['arti'] = this.arti;
    data['deskripsi'] = this.deskripsi;
    data['audio'] = this.audio;
    if (this.ayat != null) {
      data['ayat'] = this.ayat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ayat {
  int? id;
  int? surah;
  int? nomor;
  String? ar;
  String? tr;
  String? idn;

  Ayat({this.id, this.surah, this.nomor, this.ar, this.tr, this.idn});

  Ayat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    surah = json['surah'];
    nomor = json['nomor'];
    ar = json['ar'];
    tr = json['tr'];
    idn = json['idn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['surah'] = this.surah;
    data['nomor'] = this.nomor;
    data['ar'] = this.ar;
    data['tr'] = this.tr;
    data['idn'] = this.idn;
    return data;
  }
}
