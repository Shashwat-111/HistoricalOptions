import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../controllers/option_controller.dart';

class OhlcValueTextColumn extends StatelessWidget {
  OhlcValueTextColumn({super.key});
  OptionDataController odController = Get.put(OptionDataController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 30,
      //width: 100,
      child: Obx(
            ()=> Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("O "),
            Text(odController.trackballOpen.value,
                style: TextStyle(color: odController.trackballColor.value)
            ),
            Text(" H "),
            Text(odController.trackballHigh.value,
                style: TextStyle(color: odController.trackballColor.value)),
            Text(" L "),
            Text(odController.trackballLow.value,
                style: TextStyle(color: odController.trackballColor.value)),
            Text(" C "),
            Text(odController.trackballClose.value,
                style: TextStyle(color: odController.trackballColor.value)),
          ],
        ),
      ),
    );
  }
}
