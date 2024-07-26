import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../controllers/option_controller.dart';

class OhlcValueTextColumn extends StatelessWidget {
  OhlcValueTextColumn({super.key});
  final OptionDataController odController = Get.put(OptionDataController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: odController.isDeviceSmall.value ? const EdgeInsets.fromLTRB(10, 25,0,8) : const EdgeInsets.all(5),
      child: Obx(
            ()=> Row(
                      mainAxisAlignment: odController.isDeviceSmall.value ? MainAxisAlignment.start : MainAxisAlignment.end,
                      children: [
            const Text("O "),
            Text(odController.trackballOpen.value,
                style: TextStyle(color: odController.trackballColor.value)
            ),
            const Text(" H "),
            Text(odController.trackballHigh.value,
                style: TextStyle(color: odController.trackballColor.value)),
            const Text(" L "),
            Text(odController.trackballLow.value,
                style: TextStyle(color: odController.trackballColor.value)),
            const Text(" C "),
            Text(odController.trackballClose.value,
                style: TextStyle(color: odController.trackballColor.value)),
                      ],
                    ),
      ),
    );
  }
}
