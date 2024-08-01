import 'package:flutter/material.dart';
import 'package:fno_view/controllers/chart_setting_controller.dart';
import 'package:fno_view/utils/constants.dart';
import 'package:get/get.dart';

import '../widgets/theme_switch_button.dart';
import '../widgets/timeframe_selector_button.dart';

class LeftSidebar extends StatefulWidget {
  const LeftSidebar({super.key});

  @override
  State<LeftSidebar> createState() => _LeftSidebarState();
}

class _LeftSidebarState extends State<LeftSidebar> {
  ChartSettingController chartSettingController = Get.put(ChartSettingController());
  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width<mobileWidth;
    return Column(
      children: [
        if(isMobile)
          ThemeSwitchButton(),
        if(isMobile)
         IconButton(
            onPressed: () {},
            tooltip: "settings",
            icon: const Icon(Icons.settings_sharp)),
        if(isMobile)
          const TimeFrameSelectorButton(),
        buildIconButton(),
        switchCandleTypeButton(),
        annotateButton(),
        measureButton(),
        addTextButton(),
        showToolTipButton(),
      ],
    );
  }

  IconButton buildIconButton() {
    return IconButton(
        tooltip: "Lock Chart",
        onPressed: (){
          setState(() {
            chartSettingController.switchPanMode();
          });
          },
        icon: chartSettingController.enablePan.value
          ? const Icon(Icons.lock_open_sharp)
          : const Icon(Icons.lock_outline_sharp),);
  }

  IconButton showToolTipButton() => IconButton(onPressed: (){}, icon: const Icon(Icons.chat_bubble_outline_sharp), tooltip:"tooltip",);

  IconButton addTextButton() => IconButton(onPressed: (){}, icon: const Icon(Icons.title_outlined), tooltip:"Add Text",);

  IconButton measureButton() => IconButton(onPressed: (){}, icon: const Icon(Icons.straighten_outlined), tooltip:"measure",);

  IconButton annotateButton() => IconButton(onPressed: (){}, icon: const Icon(Icons.mode_edit_outlined), tooltip:"annotate",);

  IconButton switchCandleTypeButton() => IconButton(onPressed: (){chartSettingController.switchCandleType();}, icon: const Icon(Icons.candlestick_chart_outlined),tooltip:"Candle type");
}
