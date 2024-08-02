import 'package:flutter/material.dart';
import 'package:fno_view/utils/custom_popup_function.dart';
import 'package:fno_view/views/widgets/settings_icon_button.dart';
import 'package:fno_view/views/widgets/timeframe_selector_button.dart';
import 'package:get/get.dart';
import '../../controllers/chart_setting_controller.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const TimeFrameSelectorButton(),
        const Spacer(),
        SettingsIconButton()
      ],
    );
  }
}


