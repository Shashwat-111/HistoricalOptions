import 'package:flutter/material.dart';
import 'package:fno_view/controllers/annotations_controller.dart';
import 'package:fno_view/controllers/chart_setting_controller.dart';
import 'package:fno_view/utils/constants.dart';
import 'package:fno_view/views/widgets/settings_icon_button.dart';
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
  TextEditingController annotationTextController = TextEditingController();
  AnnotationsController annotationsController = Get.put(AnnotationsController());
  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width<mobileWidth;
    return Column(
      children: [
        if(isMobile)
          ThemeSwitchButton(),
        if(isMobile)
         SettingsIconButton(),
        if(isMobile)
          const TimeFrameSelectorButton(),
        buildIconButton(),
        switchCandleTypeButton(),
        annotateButton(),
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
        icon: chartSettingController.isPanEnabled.value
          ? const Icon(Icons.lock_open_sharp)
          : const Icon(Icons.lock_outline_sharp),);
  }

  Widget showToolTipButton() {
    return IconButton(
      onPressed: (){
        setState(() {
          chartSettingController.switchTooltipMode();
        });
      },
      icon: chartSettingController.isTooltipEnabled.value
          ? const Icon(Icons.chat_bubble_sharp)
          : const Icon(Icons.chat_bubble_outline_sharp),
      tooltip:"tooltip",
    );
  }

  Widget addTextButton() {
    return Obx(
      ()=> IconButton(
        isSelected: chartSettingController.isAnnotationEnabled.value,
        onPressed: (){
          chartSettingController.switchAnnotation();
          if(chartSettingController.isAnnotationEnabled.value){
            showDialog(
                context: context,
                builder: (context)=> AlertDialog(
                  title: const Text("Add Annotation"),
                  content: TextField(
                    controller: annotationTextController,
                  ),
                  actions: [
                    TextButton(
                        onPressed: (){
                          chartSettingController.switchAnnotation();
                          Navigator.pop(context);
                        },
                        child: const Text("CANCEL")
                    ),
                    TextButton(
                        onPressed: (){
                          annotationsController.setAnnotationText(annotationTextController.text);
                          Navigator.pop(context);
                        },
                        child: const Text("ADD")
                    ),
                  ],
                ));
          }
        },
        icon: const Icon(Icons.title_outlined),
        selectedIcon: Container(color : Colors.grey , child: const Icon(Icons.title_outlined)),
        tooltip:"Add Text",
      ),
    );
  }

  IconButton annotateButton() => IconButton(onPressed: (){}, icon: const Icon(Icons.mode_edit_outlined), tooltip:"annotate",);

  Widget switchCandleTypeButton() {
    return Obx(
        ()=> IconButton(
          onPressed: (){
            chartSettingController.switchCandleType();
            },
          icon: chartSettingController.candleType.value == CandleType.candle
              ? const Icon(Icons.candlestick_chart_outlined)
              : const Icon(Icons.bar_chart_rounded),
          tooltip:"Candle type"
      ),
    );
  }
}
