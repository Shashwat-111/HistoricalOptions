import 'package:flutter/material.dart';
import 'package:fno_view/views/responsive/desktop_layout.dart';
import 'package:fno_view/views/responsive/mobile_layout.dart';
import 'package:fno_view/views/responsive/responsive.dart';
import 'package:get/get.dart';
import 'controllers/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> MaterialApp(
        theme: themeController.currentTheme.value,
        title: "Historical Options",
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey[700],
            body: const ResponsiveLayout(
              mobileBody: MobileBody(),
              desktopBody: DesktopBody(),
            ),
          ),
        ),
      ),
    );
  }
}

