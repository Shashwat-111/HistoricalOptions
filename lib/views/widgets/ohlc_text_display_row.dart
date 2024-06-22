import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../controllers/option_controller.dart';

class OhlcValueTextColumn extends StatelessWidget {
  OhlcValueTextColumn({super.key});
  final OptionDataController odController = Get.put(OptionDataController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
            ()=> Row(
          mainAxisAlignment: MainAxisAlignment.end,
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
