import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadwal_sholat/model/model_lokasi.dart';

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
            child: FutureBuilder<Response>(
          future: con.getAllKota(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final res = snapshot.data!.body!;
              final data = res as List<dynamic>;
              List<lokasiKu> g = [];
              data.forEach(
                (element) {
                  g.add(lokasiKu.fromJson(element));
                },
              );

              return Autocomplete<lokasiKu>(
                optionsBuilder: (textEditingValue) {
                  if (textEditingValue.text == "") {
                    return const Iterable<lokasiKu>.empty();
                  }
                  return g
                      .where((element) => element.lokasi!
                          .contains(textEditingValue.text.toUpperCase()))
                      .toList();
                },
                onSelected: (lokasiKu item) {
                  controller.namaKota.value = item.lokasi!;
                  controller.idKota.value = item.id!;
                  controller.jamsholat.clear();
                  Get.back();
                  print("item ${item.lokasi} sudah dipilih");
                },
                displayStringForOption: (option) => option.lokasi!,
                fieldViewBuilder: (context, textEditingController, focusNode,
                        onFieldSubmitted) =>
                    Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                        hintText: "silakan ketik lokasi",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.blue))),
                    focusNode: focusNode,
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text("Loading"),
              );
            }
          },
        )));
  }
}
