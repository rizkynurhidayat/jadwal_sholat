import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ControllerKu extends GetxController {
  TextEditingController namakota = TextEditingController(text: "tegal");
  ScrollController scroll = ScrollController();

  var menit = 0.obs;
  var detik = 0.obs;
  var pukul = "".obs;

  var isStop = false.obs;
  var isAdzan = false.obs;
  var idKota = "1426".obs;
  var namaKota = "Kab. Tegal".obs;
  var remain = "00 menit".obs;
  var dataLokasi = <String>[].obs;
  Map<String, dynamic> jadwalsholat = {};
  final u = [
    'imsak',
    'subuh',
    'terbit',
    'dhuha',
    'dzuhur',
    'ashar',
    'maghrib',
    'isya'
  ];
  // final i = <DateTime>[];

  List<int> jamsholat = [];

  List<String> listmoon = [
    'moon1.png',
    'moon2.png',
    'sun1.png',
    'sun2.png',
    'sun3.png',
    'sun4.png',
  ];
  List<String> listlottie = [
    'awan.json',
    'bintang.json',
    'bintang_jatuh.json',
    'cloud.json',
  ];

  Map<String, List<Color>> gradient = const {
    'moon1': [Color(0xFF3B4371), Color(0xFFF3904F)],
    'moon2': [Color(0xFF000428), Color(0xFF004E92)],
    'sun1': [Color(0xFF721B84), Color(0xFFFF8F49)],
    'sun2': [Color(0xFF005AA7), Color(0xFFFFFDE4)],
    'sun3': [Color(0xFF56CCF2), Color(0xFF2F80ED)],
    'sun4': [Color(0xFFFF8F49), Color(0xFFD76D77)],
  };

  String moon() {
    if (menit.value >= 1020 && menit.value < 1260) {
      return listmoon[0];
    } else if (menit.value >= 1260 || menit.value <= 240) {
      return listmoon[1];
    } else if (menit.value >= 240 && menit.value < 360) {
      return listmoon[2];
    } else if (menit.value >= 360 && menit.value < 600) {
      return listmoon[3];
    } else if (menit.value >= 600 && menit.value < 960) {
      return listmoon[4];
    } else if (menit.value >= 960 && menit.value < 1020) {
      return listmoon[5];
    }
    return listmoon[5];
  }

  List<Color> color() {
    if (menit.value >= 1020 && menit.value < 1260) {
      return gradient['moon1']!;
    } else if (menit.value >= 1260 || menit.value <= 240) {
      return gradient['moon2']!;
    } else if (menit.value >= 240 && menit.value < 360) {
      return gradient['sun1']!;
    } else if (menit.value >= 360 && menit.value < 600) {
      return gradient['sun2']!;
    } else if (menit.value >= 600 && menit.value < 960) {
      return gradient['sun3']!;
    } else if (menit.value >= 960 && menit.value < 1020) {
      return gradient['sun4']!;
    }
    return gradient['sun4']!;
    // return gradient['sun4']!;
  }

  String lottie() {
    if (menit.value >= 1020 && menit.value < 1260) {
      return listlottie[1];
    } else if (menit.value >= 1260 || menit.value <= 240) {
      return listlottie[2];
    }
    return listlottie[3];
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    isStop.value = true;
  }

  List<bool> cek() {
    final sek = menit.value;
    final b = [
      (sek >= jamsholat[0] && sek < jamsholat[1]),
      (sek >= jamsholat[1] && sek < jamsholat[2]),
      (sek >= jamsholat[2] && sek < jamsholat[3]),
      (sek >= jamsholat[3] && sek < jamsholat[4]),
      (sek >= jamsholat[4] && sek < jamsholat[5]),
      (sek >= jamsholat[5] && sek < jamsholat[6]),
      (sek >= jamsholat[6] && sek < jamsholat[7]),
      (sek >= jamsholat[7] || sek < jamsholat[0]),
    ];
    return b;
  }

  void remaining() {
    final sek = menit.value;
    if (sek <= jamsholat[0]) {
      remain.value =
          "${jamsholat[0] - sek} menit lagi menuju ${toBeginningOfSentenceCase(u[0])}";
    } else if (sek <= jamsholat[1] && sek > jamsholat[0]) {
      remain.value =
          "${jamsholat[1] - sek} menit lagi menuju ${toBeginningOfSentenceCase(u[1])}";
    } else if (sek <= jamsholat[2] && sek > jamsholat[1]) {
      remain.value =
          "${jamsholat[2] - sek} menit lagi menuju ${toBeginningOfSentenceCase(u[2])}";
    } else if (sek <= jamsholat[3] && sek > jamsholat[2]) {
      remain.value =
          "${jamsholat[3] - sek} menit lagi menuju ${toBeginningOfSentenceCase(u[3])}";
    } else if (sek <= jamsholat[4] && sek > jamsholat[3]) {
      remain.value =
          "${jamsholat[4] - sek} menit lagi menuju ${toBeginningOfSentenceCase(u[4])}";
    } else if (sek <= jamsholat[5] && sek > jamsholat[4]) {
      remain.value =
          "${jamsholat[5] - sek} menit lagi menuju ${toBeginningOfSentenceCase(u[5])}";
    } else if (sek <= jamsholat[6] && sek > jamsholat[5]) {
      remain.value =
          "${jamsholat[6] - sek} menit lagi menuju ${toBeginningOfSentenceCase(u[6])}";
    } else if (sek <= jamsholat[7] && sek > jamsholat[6]) {
      remain.value =
          "${jamsholat[7] - sek} menit lagi menuju ${toBeginningOfSentenceCase(u[7])}";
    } else if (sek > jamsholat[7]) {
      remain.value =
          "${(1440 - sek) + jamsholat[0]} menit lagi menuju ${toBeginningOfSentenceCase(u[0])}";
    }
  }

  // void updateJadwalSholat() {
  //   for (var element in u) {
  //     i.add(DateFormat.Hm().parse(jadwalsholat[element]));
  //   }
  //   for (var element in i) {
  //     jamsholat.add((element.hour * 60) + element.minute);
  //   }
  // }

  void waktu() {
    const oneSec = Duration(seconds: 1);

    Timer.periodic(oneSec, (Timer t) {
      // if (isStop.isTrue) {
      //   t.cancel();
      // }
      final now = DateTime.now();
      pukul.value = DateFormat.Hms().format(now);

      menit.value = (now.hour * 60) + now.minute;
      remaining();
      // detik.value = now.second;
    });
  }
}

class Kota extends GetConnect {
  Future<Response> getAllKota() {
    return get(
      "https://api.myquran.com/v1/sholat/kota/semua",
    );
  }

  Future<Response> getjadwal({required String id}) {
    final date = DateTime.now();
    final tahun = date.year;
    final bulan = date.month;
    final tanggal = date.day;
    return get(
        "https://api.myquran.com/v1/sholat/jadwal/$id/$tahun/$bulan/$tanggal");
  }
}
