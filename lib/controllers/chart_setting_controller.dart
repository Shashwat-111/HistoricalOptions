import 'package:get/get.dart';

enum CandleType {
  bar,
  candle,
}

class ChartSettingController extends GetxController {
  var enablePan = true.obs;
  var enableZoom = true.obs;
  var candleType = CandleType.candle.obs;

  switchPanMode(){
    enablePan.value = !enablePan.value;
  }

  switchCandleType(){
    if(candleType.value == CandleType.bar){
      candleType.value = CandleType.candle;
    } else {
      candleType.value = CandleType.bar;
    }
  }
}