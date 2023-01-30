import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadwal_sholat/pages/jadwal_sholat.dart';

import '../controller/controllerKu.dart';

class HomePage extends GetView<ControllerKu> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final kota = Get.put(Kota());
    var respon = kota.getAllKota();

    return Scaffold(
        appBar: AppBar(
          title: Text("Aplikasi Jadwal sholat"),
        ),
        body: SafeArea(
            child: FutureBuilder<Response>(
          future: respon,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final res = snapshot.data!.body!;
              final data = res['data'];
              print(data[0]["lokasi"]);
              return Center(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      Get.to(JadwalSholatPage(
                          kota: data[index]['lokasi'], id: data[index]['id']));
                    },
                    title: Text(data[index]['lokasi']),
                    subtitle: Text(data[index]['id']),
                  ),
                ),
              );
            } else {
              return Center(
                child: Text("Loading"),
              );
            }
          },
        )));
  }
}
