import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jadwal_sholat/controller/controllerKu.dart';
import 'package:lottie/lottie.dart';
import 'package:slide_countdown/slide_countdown.dart';

class SorePage extends StatelessWidget {
  SorePage({super.key, required this.kota});

  String kota;

  @override
  Widget build(BuildContext context) {
    final con = Get.put(Kota());

    var respon = con.getjadwal();
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
                c.incremet();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Stack(
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
                  Text(
                    kota,
                    style:
                        GoogleFonts.poppins(fontSize: 14, color: Colors.white),
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
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: respon,
            builder: (context, snapshot) {
              try {
                if (snapshot.hasData) {
                  final data = snapshot.data!.body!;
                  final jadwalsholat = data['data']['jadwal'];
                  return SafeArea(
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
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              width: Get.width,
                              height: 500,
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 3),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)),
                                  color: Colors.grey.shade200.withOpacity(0.2)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Sholat(
                                    jadwalsholat: jadwalsholat,
                                    waktu: "imsak",
                                  ),
                                  Sholat(
                                      jadwalsholat: jadwalsholat,
                                      waktu: 'subuh'),
                                  Sholat(
                                      jadwalsholat: jadwalsholat,
                                      waktu: 'terbit'),
                                  Sholat(
                                    jadwalsholat: jadwalsholat,
                                    waktu: 'dhuha',
                                  ),
                                  Sholat(
                                      jadwalsholat: jadwalsholat,
                                      waktu: 'dzuhur'),
                                  Sholat(
                                      jadwalsholat: jadwalsholat,
                                      waktu: 'ashar'),
                                  Sholat(
                                      jadwalsholat: jadwalsholat,
                                      waktu: 'maghrib'),
                                  Sholat(
                                      jadwalsholat: jadwalsholat, waktu: 'isya')
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              } catch (err) {
                print(err);
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}

class Sholat extends StatelessWidget {
  Sholat({
    Key? key,
    required this.jadwalsholat,
    required this.waktu,
  }) : super(key: key);

  var jadwalsholat;
  String waktu;

  @override
  Widget build(BuildContext context) {
    var s = jadwalsholat[waktu];
    var p = DateFormat.Hm().parse(s);

    print(p.hour);

    final c = Get.put(ControllerKu());

    return Obx(() {
      c.adzan(jadwalsholat[waktu]);
      return AnimatedContainer(
        duration: Duration(seconds: 1),
        width: Get.width,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: (c.isAdzan.value == true)
              ? Colors.white.withOpacity(0.3)
              : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              toBeginningOfSentenceCase(waktu)!,
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
            ),
            Text('${jadwalsholat[waktu]} WIB',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.white))
          ],
        ),
      );
    });
  }
}

class animasiKu extends StatelessWidget {
  const animasiKu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerKu());
    return SafeArea(
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
            ),
            Obx(
              () => LottieBuilder.asset(
                "assets/${c.lottie()}",
                width: Get.width - 50,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Opacity(
                    opacity: 0.2,
                    child: LottieBuilder.asset(
                      "assets/circleKU.json",
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Obx(
                    () => Image.asset(
                      "assets/${c.moon()}",
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class bgKu extends StatelessWidget {
  bgKu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerKu());
    return Obx(
      () => AnimatedContainer(
          duration: const Duration(seconds: 1),
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: c.color(),
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 80,
              ),
              Image(
                width: 180,
                fit: BoxFit.cover,
                image: AssetImage("assets/bg_masjid.png"),
                alignment: Alignment.bottomLeft,
              ),
            ],
          )),
    );
  }
}
