import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controllerKu.dart';

class CariLokasiPage extends StatelessWidget {
  const CariLokasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ControllerKu());
    final con = Get.put(Kota());

    return Scaffold(
        appBar: AppBar(
          title: const Text("Cari Lokasi"),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: FutureBuilder<Response>(
                future: con.getAllKota(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final res = snapshot.data!.body!;
                    final data = res as List<dynamic>;

                    return Center(
                      child: ListView.builder(
                        controller: controller.scroll,
                        addRepaintBoundaries: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) => ListTile(
                          onTap: () {
                            // Get.to(JadwalSholatPage(
                            //     kota: data[index]['lokasi'], id: data[index]['id']));

                            controller.namaKota.value = data[index]['lokasi'];
                            controller.idKota.value = data[index]['id'];
                            Get.back();
                          },
                          title: Text(data[index]['lokasi']),
                          subtitle: Text(data[index]['id']),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("Loading"),
                    );
                  }
                },
              ),
            ),
          ],
        )));
  }
}
