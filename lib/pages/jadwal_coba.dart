import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jadwal_sholat/controller/controllerKu.dart';
import 'package:jadwal_sholat/model/sholat_model.dart';
import 'package:jadwal_sholat/pages/home_page.dart';
import 'package:lottie/lottie.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../model/contain.dart';

class SorePage extends StatelessWidget {
  SorePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final con = Get.put(Kota());

    final c = Get.put(ControllerKu());
    c.waktu();
    final now = DateTime.now();
    final tanggal = DateFormat("EEEE, d MMMM y", "id_ID").format(now);
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
                Get.to(HomePage());
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
            animasiKu(),
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
                    Spacer(),
                    Text("sekian menit"),
                    SizedBox(
                      height: Get.height / 5,
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
                        child: FutureBuilder<Response<dynamic>>(
                          future: con.getjadwal(),
                          builder: (context, snapshot) {
                            try {
                              if (snapshot.hasData) {
                                final data = snapshot.data!.body!;
                                final jadwalsholat = data['data']['jadwal']
                                    as Map<String, dynamic>;

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
                                final i = [
                                  DateFormat.Hm().parse(jadwalsholat[u[0]]),
                                  DateFormat.Hm().parse(jadwalsholat[u[1]]),
                                  DateFormat.Hm().parse(jadwalsholat[u[2]]),
                                  DateFormat.Hm().parse(jadwalsholat[u[3]]),
                                  DateFormat.Hm().parse(jadwalsholat[u[4]]),
                                  DateFormat.Hm().parse(jadwalsholat[u[5]]),
                                  DateFormat.Hm().parse(jadwalsholat[u[6]]),
                                  DateFormat.Hm().parse(jadwalsholat[u[7]]),
                                ];
                                final j = [
                                  (i[0].hour * 60) + i[0].minute,
                                  (i[1].hour * 60) + i[1].minute,
                                  (i[2].hour * 60) + i[2].minute,
                                  (i[3].hour * 60) + i[3].minute,
                                  (i[4].hour * 60) + i[4].minute,
                                  (i[5].hour * 60) + i[5].minute,
                                  (i[6].hour * 60) + i[6].minute,
                                  (i[7].hour * 60) + i[7].minute,
                                ];
                                final sek = (20 * 60);
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
                                print(j);
                                print(sek);
                                return ListView.builder(
                                  itemCount: u.length,
                                  itemBuilder: (context, index) {
                                    return SholatKu(
                                      jam: DateFormat.Hm().format(i[index]),
                                      waktu: u[index],
                                      adzan: c.cek(j)[index],
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
