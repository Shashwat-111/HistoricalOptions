import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/chart_setting_controller.dart';
import '../../utils/custom_popup_function.dart';

class SettingsIconButton extends StatelessWidget {
  SettingsIconButton({super.key});
  final ChartSettingController chartSettingController = Get.put(ChartSettingController());
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showCustomPopup(
              context: context,
              title: "Settings",
              child: Column(
                children: [
                  ListTile(
                    title: const Text("Panning in Y direction"),
                    trailing: Obx(
                          ()=> Switch(
                          value: chartSettingController.isPanInYEnabled.value,
                          onChanged: (newValue){
                            chartSettingController.switchYPanMode();
                          }
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text("Enable Selection Zooming"),
                    trailing: Obx(
                          ()=> Switch(
                          value: chartSettingController.isSelectionZoomingEnabled.value,
                          onChanged: (newValue){
                            chartSettingController.switchSelectionZooming();
                          }
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text("Enable Solid Candles"),
                    trailing: Obx(
                          ()=> Switch(
                          value: chartSettingController.isCandleTypeSolid.value,
                          onChanged: (newValue){
                            chartSettingController.switchCandleTypeSolid();
                          }
                      ),
                    ),
                  )
                ],
              )
          );
        },
        tooltip: "settings",
        icon: const Icon(Icons.settings_sharp));
  }
}
