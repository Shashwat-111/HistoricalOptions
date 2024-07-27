import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme_controller.dart';

class RightSidebar extends StatefulWidget {
  const RightSidebar({super.key});

  @override
  State<RightSidebar> createState() => _RightSidebarState();
}

class _RightSidebarState extends State<RightSidebar> {
  ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        themeSwitchButton(),
        IconButton(onPressed: (){}, icon: const Icon(Icons.color_lens_outlined)),
        RotatedBox(
          quarterTurns: 1,
            child: IconButton(onPressed: (){}, icon: const Icon(Icons.splitscreen_sharp))),
        const Spacer(),
        IconButton(onPressed: (){}, icon: const Icon(Icons.info_outlined))
      ],
    );
  }

  Widget themeSwitchButton() {
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
