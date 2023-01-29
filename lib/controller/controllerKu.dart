import 'package:get/get.dart';

class ControllerKu extends GetxController {
  var data = [].obs;
}

class Kota extends GetConnect {
  Future<Response> getAllKota() {
    return get(
      "https://api.myquran.com/v1/sholat/kota/cari/tegal",
    );
  }

  Future<Response> getjadwal(String id, int tahun, int bulan, int tanggal) =>
      get("https://api.myquran.com/v1/sholat/jadwal/$id/$tahun/$bulan/$tanggal");
}
