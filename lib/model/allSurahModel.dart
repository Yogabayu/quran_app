class AllSurahModel {
  int? nomor;
  String? nama;
  String? namaLatin;
  int? jumlahAyat;
  String? tempatTurun;
  String? arti;
  String? deskripsi;
  String? audio;

  AllSurahModel(
      {this.nomor,
      this.nama,
      this.namaLatin,
      this.jumlahAyat,
      this.tempatTurun,
      this.arti,
      this.deskripsi,
      this.audio});

  AllSurahModel.fromJson(Map<String, dynamic> json) {
    nomor = json['nomor'];
    nama = json['nama'];
    namaLatin = json['nama_latin'];
    jumlahAyat = json['jumlah_ayat'];
    tempatTurun = json['tempat_turun'];
    arti = json['arti'];
    deskripsi = json['deskripsi'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomor'] = this.nomor;
    data['nama'] = this.nama;
    data['nama_latin'] = this.namaLatin;
    data['jumlah_ayat'] = this.jumlahAyat;
    data['tempat_turun'] = this.tempatTurun;
    data['arti'] = this.arti;
    data['deskripsi'] = this.deskripsi;
    data['audio'] = this.audio;
    return data;
  }
}
