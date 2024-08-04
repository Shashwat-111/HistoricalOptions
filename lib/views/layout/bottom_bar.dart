import 'package:flutter/material.dart';
import 'package:fno_view/views/widgets/settings_icon_button.dart';
import 'package:fno_view/views/widgets/timeframe_selector_button.dart';

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


