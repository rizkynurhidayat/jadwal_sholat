import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jadwal_sholat/controller/controllerKu.dart';

import 'package:jadwal_sholat/pages/cari_lokasi.dart';

import '../model/contain.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final con = Get.put(Kota());

    final c = Get.put(ControllerKu());

    final now = DateTime.now();
    final tanggal = DateFormat("EEEE, d MMMM y", "id_ID").format(now);

    c.waktu();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Jadwal Sholat",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const CariLokasiPage());
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              )),
        ],
      ),
      body: SizedBox(
        child: Stack(
          children: [
            bgKu(),
            const animasiKu(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/masjid.png",
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: SizedBox(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: Get.width,
                    ),
                    Obx(
                      () => Text(
                        c.namaKota.value,
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: Colors.white),
                      ),
                    ),
                    Obx(() {
                      return Text(
                        c.pukul.value,
                        style: GoogleFonts.poppins(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      );
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => Text(
                          c.remain.value,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white,
                              fontStyle: FontStyle.italic),
                        )),
                    const Spacer(),
                    SizedBox(
                      height: Get.height / 3,
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: ListView(
                children: [
                  SizedBox(
                    height: Get.height - 200,
                  ),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(tanggal,
                        style: GoogleFonts.poppins(
                            fontSize: 18, color: Colors.white)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        width: Get.width,
                        height: 500,
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                            color: Colors.grey.shade200.withOpacity(0.2)),
                        child: Obx(
                          () => FutureBuilder<Response<dynamic>>(
                            future: con.getjadwal(id: c.idKota.value),
                            builder: (context, snapshot) {
                              try {
                                if (snapshot.hasData) {
                                  final data = snapshot.data!.body!;
                                  final jadwalsholat = data['data']['jadwal']
                                      as Map<String, dynamic>;

                                  // c.jadwalsholat.addAll(jadwalsholat);
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
                                  final i = <DateTime>[];
                                  for (var element in u) {
                                    i.add(DateFormat.Hm()
                                        .parse(jadwalsholat[element]));
                                  }

                                  if (c.jamsholat.isNotEmpty) {
                                    c.jamsholat.clear();
                                  }
                                  for (var element in i) {
                                    c.jamsholat.add(
                                        (element.hour * 60) + element.minute);
                                  }
                                  print("jam sholat di bawah");
                                  print(c.jamsholat);
                                  // c.updateJadwalSholat();

                                  return ListView.builder(
                                    itemCount: u.length,
                                    itemBuilder: (context, index) {
                                      return SholatKu(
                                        jam: DateFormat.Hm().format(i[index]),
                                        waktu: u[index],
                                        adzan: c.cek()[index],
                                      );
                                    },
                                  );
                                }
                              } catch (err) {
                                print(err);
                              }
                              return Container();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}




//  Obx(
//                       () => FutureBuilder<Response<dynamic>>(
//                         future: con.getjadwal(id: c.idKota.value),
//                         builder: (context, snapshot) {
//                           try {
//                             if (snapshot.hasData) {
//                               final data = snapshot.data!.body!;
//                               final jadwalsholat = data['data']['jadwal']
//                                   as Map<String, dynamic>;
//                               final u = [
//                                 'imsak',
//                                 'subuh',
//                                 'terbit',
//                                 'dhuha',
//                                 'dzuhur',
//                                 'ashar',
//                                 'maghrib',
//                                 'isya'
//                               ];
//                               final i = <DateTime>[];
//                               for (var element in u) {
//                                 i.add(DateFormat.Hm()
//                                     .parse(jadwalsholat[element]));
//                               }

//                               if (c.jamsholat.isNotEmpty) {
//                                 c.jamsholat.clear();
//                               }
//                               for (var element in i) {
//                                 c.jamsholat
//                                     .add((element.hour * 60) + element.minute);
//                               }
//                               print("jam sholat di atas");
//                               print(c.jamsholat);
//                               return Obx(
//                                 () => Text(c.remain.value,
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 14,
//                                         color: Colors.white,
//                                         fontStyle: FontStyle.italic)),
//                               );
//                             }
//                           } catch (err) {
//                             print(err);
//                           }
//                           return SizedBox(
//                             child: Text(c.remain.value,
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 18,
//                                   color: Colors.white,
//                                 )),
//                           );
//                         },
//                       ),
//                     ),