import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../controller/controllerKu.dart';

class JadwalSholatPage extends GetView<ControllerKu> {
  JadwalSholatPage({super.key, required this.kota, required this.id});

  String kota;
  String id;
  @override
  Widget build(BuildContext context) {
    final con = Get.put(Kota());
    final now = DateTime.now();
    final tahun = now.year;
    final bulan = now.month;

    final tanggal = now.day;

    print("$id $tahun $bulan $tanggal ");
    return Scaffold(
      appBar: AppBar(
        title: Text("jadwal sholat $kota"),
      ),
      body: SafeArea(
          child: FutureBuilder<Response>(
        future: con.getjadwal(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.body!;
            final jadwalsholat = data['data']['jadwal'];
            print(data['data']);
            return Center(
              child: Card(
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Column(
                    children: [
                      Text(jadwalsholat['tanggal']),
                      Text("imsak : ${jadwalsholat['imsak']}"),
                      Text("Subuh : ${jadwalsholat['subuh']}"),
                      Text("Dzuhur : ${jadwalsholat['dzuhur']}"),
                      Text("Ashar : ${jadwalsholat['ashar']}"),
                      Text("Maghrib : ${jadwalsholat['maghrib']}"),
                      Text("Isya : ${jadwalsholat['isya']}"),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }
}
