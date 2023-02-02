import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class ControllerKu extends GetxController {
  TextEditingController namakota = TextEditingController(text: "tegal");
  ScrollController scroll = ScrollController();
  var jam = 0.obs;
  var menit = 0.obs;
  var detik = 0.obs;
  var pukul = "".obs;

  var isStop = false.obs;
  var isAdzan = false.obs;
  var idKota = "1426".obs;
  var namaKota = "Kab. Tegal".obs;

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
    if (menit.value >= 1020) {
      return listmoon[0];
    } else if (menit.value >= 1260) {
      return listmoon[1];
    } else if (menit.value >= 240) {
      return listmoon[2];
    } else if (menit.value >= 360) {
      return listmoon[3];
    } else if (menit.value >= 600) {
      return listmoon[4];
    } else if (menit.value >= 960) {
      return listmoon[5];
    }
    return listmoon[5];
  }

  List<Color> color() {
    if (menit.value >= 1020) {
      return gradient['moon1']!;
    } else if (menit.value >= 1260) {
      return gradient['moon2']!;
    } else if (menit.value >= 240) {
      return gradient['sun1']!;
    } else if (menit.value >= 360) {
      return gradient['sun2']!;
    } else if (menit.value >= 600) {
      return gradient['sun3']!;
    } else if (menit.value >= 960) {
      return gradient['sun4']!;
    }
    return gradient['sun4']!;
    // return gradient['sun4']!;
  }

  String lottie() {
    if (menit.value >= 1020) {
      return listlottie[1];
    } else if (menit.value >= 1260) {
      return listlottie[2];
    }
    return listlottie[0];
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    isStop.value = true;
  }

  List<bool> cek(List<int> j) {
    final sek = menit.value;
    final b = [
      (sek >= j[0] && sek < j[1]),
      (sek >= j[1] && sek < j[2]),
      (sek >= j[2] && sek < j[3]),
      (sek >= j[3] && sek < j[4]),
      (sek >= j[4] && sek < j[5]),
      (sek >= j[5] && sek < j[6]),
      (sek >= j[6] && sek < j[7]),
      (sek >= j[7] || sek < j[0]),
    ];
    return b;
  }

  void waktu() {
    const oneSec = Duration(seconds: 1);

    Timer.periodic(oneSec, (Timer t) {
      if (isStop.isTrue) {
        t.cancel();
      }

      final now = DateTime.now();
      pukul.value = DateFormat.Hms().format(now);

      menit.value = (now.hour * 60) + now.minute;
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

  Future<Response> getjadwal() {
    final c = Get.put(ControllerKu());
    final id = c.idKota.value;
    final date = DateTime.now();
    final tahun = date.year;
    final bulan = date.month;
    final tanggal = date.day;
    return get(
        "https://api.myquran.com/v1/sholat/jadwal/$id/$tahun/$bulan/$tanggal");
  }
}
