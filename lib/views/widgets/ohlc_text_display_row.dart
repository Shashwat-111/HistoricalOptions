import 'package:flutter/cupertino.dart';
import 'package:fno_view/controllers/ohlc_data_controller.dart';
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
                Text("${getPercentageChange(trackballController.trackballIndex.value)} %  ", style:TextStyle(color: trackballController.trackballColor.value)),
                const SizedBox(width: 8,),
                Text("Vol : ${getVolumeFromIndex(trackballController.trackballIndex.value)}"),
              ],
            )
          ],
        ),
    );
  }
}

int getVolumeFromIndex(int index){
  OhlcDataController dataController = Get.put(OhlcDataController());
  return dataController.ohlcDataList[index].volume;
}

String getPercentageChange(int currentIndex){
  OhlcDataController dataController = Get.put(OhlcDataController());
  if(currentIndex!=0){
    var previousClose =double.parse(dataController.ohlcDataList[currentIndex-1].close);
    var currentClose =double.parse(dataController.ohlcDataList[currentIndex].close);
    var percentChange = (((previousClose-currentClose)/previousClose)*100).toPrecision(2);
    if (percentChange<0) {
      return percentChange.toStringAsFixed(2);
    } else {
      return "+${percentChange.toStringAsFixed(2)}";
    }
  } else {
    return "-";
  }
}