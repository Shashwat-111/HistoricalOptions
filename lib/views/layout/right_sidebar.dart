import 'package:flutter/material.dart';
import 'package:fno_view/utils/custom_snackbar_function.dart';
import '../widgets/theme_switch_button.dart';

class RightSidebar extends StatefulWidget {
  const RightSidebar({super.key});

  @override
  State<RightSidebar> createState() => _RightSidebarState();
}

class _RightSidebarState extends State<RightSidebar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ThemeSwitchButton(),
        IconButton(onPressed: (){
          showCustomSnackBar(context: context, text: "Custom Color theming coming soon!");
        }, icon: const Icon(Icons.color_lens_outlined)),
        RotatedBox(
          quarterTurns: 1,
            child: IconButton(onPressed: (){
              showCustomSnackBar(context: context, text: "chart comparison view currently unavailable");
            }, icon: const Icon(Icons.splitscreen_sharp))),
        const Spacer(),
        IconButton(onPressed: (){
          
        }, icon: const Icon(Icons.info_outlined))
      ],
    );
  }
}
