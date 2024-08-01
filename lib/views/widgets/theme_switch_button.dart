import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme_controller.dart';

class ThemeSwitchButton extends StatelessWidget {
  ThemeSwitchButton({super.key});
  final ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
          ()=> IconButton(
          onPressed: (){
            themeController.isDarkMode.value
                ? themeController.switchTheme(AppThemeMode.light)
                : themeController.switchTheme(AppThemeMode.dark);
          },
          icon: themeController.isDarkMode.value
              ? const Icon(Icons.dark_mode_outlined)
              : const Icon(Icons.light_mode_outlined)
      ),
    );
  }
}