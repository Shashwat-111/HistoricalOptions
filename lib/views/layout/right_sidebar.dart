import 'package:flutter/material.dart';

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
  Widget themeSwitchButton() => IconButton(onPressed: (){}, icon: const Icon(Icons.light_mode_outlined));
}
