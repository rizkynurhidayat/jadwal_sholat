import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jadwal_sholat/controller/controllerKu.dart';
import 'package:lottie/lottie.dart';

class CobaPage extends StatelessWidget {
  const CobaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.lazyPut(() => ControllerKu());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "Aplikasi Jadwal Sholat",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          SizedBox(
            width: Get.width,
            height: Get.height,
            child: const Image(
                fit: BoxFit.cover, image: AssetImage("assets/bg_moon1.png")),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                width: Get.width,
              ),
              Text(
                "Kab. Tegal",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
              ),
              Text(
                "22:23:24",
                style: GoogleFonts.poppins(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 60,
              ),
              LottieBuilder.asset(
                "assets/bintang.json",
                width: Get.width - 50,
                fit: BoxFit.cover,
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
                        height: 160,
                        width: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Image.asset(
                      "assets/moon1.png",
                      width: 140,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/masjid.png",
              fit: BoxFit.cover,
            ),
          )
        ],
      )),
    );
  }
}
