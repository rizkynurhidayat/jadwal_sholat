import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class ControllerKu extends GetxController {
  var jam = 0.obs;
  var menit = 0.obs;
  var detik = 0.obs;
  var pukul = "".obs;

  var isStop = false.obs;
  var isAdzan = false.obs;

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
  late dynamic data;

  void incremet() {
    detik.value = detik.value + 1;
  }

  String moon() {
    if (detik.value == 2) {
      return listmoon[0];
    } else if (detik.value == 4) {
      return listmoon[1];
    } else if (detik.value == 6) {
      return listmoon[2];
    } else if (detik.value == 8) {
      return listmoon[3];
    } else if (detik.value == 10) {
      return listmoon[4];
    }

    return listmoon[5];
  }

  List<Color> color() {
    if (detik.value == 2) {
      return gradient['moon1']!;
    } else if (detik.value == 4) {
      return gradient['moon2']!;
    } else if (detik.value == 6) {
      return gradient['sun1']!;
    } else if (detik.value == 8) {
      return gradient['sun2']!;
    } else if (detik.value == 10) {
      return gradient['sun3']!;
    }
    return gradient['sun4']!;
  }

  String lottie() {
    if (detik.value == 2) {
      return listlottie[1];
    } else if (detik.value == 4) {
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

  void adzan(String waktu) {
    const s = 4;
    final p = DateFormat.Hm().parse(waktu);
    if (p.hour == s) {
      isAdzan.value == true;
    }
  }

  Color adzn(DateTime waktu) {
    int s = 12;
    if (waktu.hour == s) {
      return Colors.white.withOpacity(0.3);
    }
    return Colors.transparent;
  }

  void waktu() {
    const oneSec = Duration(seconds: 1);

    Timer.periodic(oneSec, (Timer t) {
      if (isStop.isTrue) {
        t.cancel();
      }

      final now = DateTime.now();
      pukul.value = DateFormat.Hms().format(now);
      // jam.value = now.hour;
      // menit.value = now.minute;
      // detik.value = now.second;
    });
  }
}

class Kota extends GetConnect {
  Future<Response> getAllKota() {
    return get(
      "https://api.myquran.com/v1/sholat/kota/cari/tegal",
    );
  }

  Future<Response> getjadwal() {
    const id = "1426";
    final date = DateTime.now();
    final tahun = date.year;
    final bulan = date.month;
    final tanggal = date.day;
    return get(
        "https://api.myquran.com/v1/sholat/jadwal/$id/$tahun/$bulan/$tanggal");
  }
}
