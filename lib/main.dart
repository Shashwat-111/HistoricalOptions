import 'package:flutter/material.dart';
import 'package:fno_view/utils/constants.dart';
import 'package:fno_view/utils/theme.dart';
import 'package:fno_view/views/responsive/desktop_layout.dart';
import 'package:fno_view/views/responsive/mobile_layout.dart';
import 'package:fno_view/views/responsive/responsive.dart';
import 'package:get/get.dart';
import 'controllers/theme_controller.dart';

void main() {
  runApp(
      Obx((){
        ThemeController themeController = Get.put(ThemeController());
        return MaterialApp(
          home: const MyApp(),
          theme: themeController.currentTheme.value,
          //darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
        );
      }
  )
  );
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
    return const SafeArea(
          child: Scaffold(
            body: ResponsiveLayout(
              mobileBody: MobileBody(),
              desktopBody: DesktopBody(),
            ),
          ),
        );
  }
}

