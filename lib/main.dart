import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:jadwal_sholat/controller/controllerKu.dart';
import 'package:jadwal_sholat/pages/jadwal_coba.dart';

import 'pages/home_page.dart';

void main() async {
  await initializeDateFormatting("id_ID", null)
      .then((value) => runApp(MyApp()));
}

class MyApp extends GetView<ControllerKu> {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: SorePage(kota: 'Kab. Tegal'),
    );
  }
}
