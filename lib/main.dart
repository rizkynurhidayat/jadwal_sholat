import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadwal_sholat/controller/controllerKu.dart';

import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends GetView<ControllerKu> {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomePage(),
    );
  }
}
