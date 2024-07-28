
import 'package:get/get.dart';

class ChartSettingController extends GetxController {
  var enablePan = true.obs;
  var enableZoom = true.obs;

  switchPanMode(){
    enablePan.value = !enablePan.value;
  }
}