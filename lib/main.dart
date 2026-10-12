import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vascular_blood/routes/pages.dart';
import 'package:vascular_blood/routes/route.dart';
import 'package:vascular_blood/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
      theme: AppTheme().lightTheme,
      initialRoute: Routes.splash,
      debugShowCheckedModeBanner: false,
    );
  }
}
