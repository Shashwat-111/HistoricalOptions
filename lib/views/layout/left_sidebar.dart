import 'package:flutter/material.dart';
import 'package:fno_view/controllers/chart_setting_controller.dart';
import 'package:get/get.dart';

class LeftSidebar extends StatefulWidget {
  const LeftSidebar({super.key});

  @override
  State<LeftSidebar> createState() => _LeftSidebarState();
}

class _LeftSidebarState extends State<LeftSidebar> {
  ChartSettingController chartSettingController = Get.put(ChartSettingController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          tooltip: "Lock Chart",
          onPressed: (){
            setState(() {
              chartSettingController.switchPanMode();
            });
            },
          icon: chartSettingController.enablePan.value
            ? const Icon(Icons.lock_open_sharp)
            : const Icon(Icons.lock_outline_sharp),),
        IconButton(onPressed: (){chartSettingController.switchCandleType();}, icon: const Icon(Icons.candlestick_chart_outlined),tooltip:"Candle type"),
        IconButton(onPressed: (){}, icon: const Icon(Icons.mode_edit_outlined), tooltip:"annotate",),
        IconButton(onPressed: (){}, icon: const Icon(Icons.straighten_outlined), tooltip:"measure",),
        IconButton(onPressed: (){}, icon: const Icon(Icons.title_outlined), tooltip:"Add Text",),
        IconButton(onPressed: (){}, icon: const Icon(Icons.chat_bubble_outline_sharp), tooltip:"tooltip",),

      ],
    );
  }
}
