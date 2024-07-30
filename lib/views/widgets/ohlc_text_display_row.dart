import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../controllers/option_controller.dart';
import '../../controllers/trackball_controller.dart';

class OhlcValueTextColumn extends StatelessWidget {
  OhlcValueTextColumn({super.key});
  final TrackballController trackballController = Get.put(TrackballController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Obx(()=>
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(" O "),
                Text(trackballController.trackballOpen.value,
                style: TextStyle(color: trackballController.trackballColor.value)
                ),
                const Text(" H "),
                Text(trackballController.trackballHigh.value,
                style: TextStyle(color: trackballController.trackballColor.value)),
                const Text(" L "),
                Text(trackballController.trackballLow.value,
                style: TextStyle(color: trackballController.trackballColor.value)),
                const Text(" C "),
                Text(trackballController.trackballClose.value,
                style: TextStyle(color: trackballController.trackballColor.value)),
                      ],
                    ),
      ),
    );
  }
}
