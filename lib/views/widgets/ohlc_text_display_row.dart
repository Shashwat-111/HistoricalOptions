import 'package:flutter/cupertino.dart';
import 'package:fno_view/utils/helper_functions.dart';
import 'package:get/get.dart';
import '../../controllers/trackball_controller.dart';

class OhlcValueTextColumn extends StatelessWidget {
  OhlcValueTextColumn({super.key});
  final TrackballController trackballController = Get.put(TrackballController());

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("O "),
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Change: "),
                Text("${HelperFunctions.getPercentageChange(trackballController.trackballIndex.value)} %  ", style:TextStyle(color: trackballController.trackballColor.value)),
                const SizedBox(width: 8,),
                Text("Vol : ${HelperFunctions.getVolumeFromIndex(trackballController.trackballIndex.value)}"),
              ],
            )
          ],
        ),
    );
  }
}