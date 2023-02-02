import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../controller/controllerKu.dart';

class SholatKu extends StatelessWidget {
  SholatKu({
    Key? key,
    required this.jam,
    required this.waktu,
    this.adzan = false,
  }) : super(key: key);

  String jam;
  String waktu;
  bool adzan;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      width: Get.width,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: (adzan == true)
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
          Text('$jam WIB',
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.white))
        ],
      ),
    );
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
            const SizedBox(
              height: 50,
            ),
            Obx(
              () => LottieBuilder.asset(
                "assets/${c.lottie()}",
                width: Get.width - 50,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 150,
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
