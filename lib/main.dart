import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadwal_sholat/controller/controllerKu.dart';
import 'package:jadwal_sholat/pages/jadwal_coba.dart';

import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends GetView<ControllerKu> {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const CobaPage(),
    );
  }
}
