import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navega_app/core/routes/app_page.dart';


void main() {
  runApp(const NavegaApp());
}

class NavegaApp extends StatelessWidget {
  const NavegaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navega 2025',

      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}