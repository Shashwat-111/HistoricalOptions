import 'dart:ui';
import 'package:get/get.dart';

// Controls the display of OHLC values for each candlestick when hovered.
class TrackballController extends GetxController {
  var trackballOpen = "0.00".obs;
  var trackballHigh = "0.00".obs;
  var trackballLow = "0.00".obs;
  var trackballClose = "0.00".obs;
  var trackballIndex = 0.obs;
  //var trackballVolume = "".obs;
  var trackballColor = const Color(0xfff44336).obs;

  void updateTrackballPoints (String open, String high, String low, String close, Color color, int index){
    trackballOpen.value = open;
    trackballHigh.value = high;
    trackballLow.value = low;
    trackballClose.value = close;
    trackballColor.value = color;
    trackballIndex.value = index;
  }
}