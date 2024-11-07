import 'package:fno_view/utils/theme.dart';
import 'package:get/get.dart';

enum Layout {
  mobile,
  desktop
}

//A controller to keep track of the current layout based on the screen size.
class LayoutController extends GetxController {

  var currentLayout = Layout.mobile.obs;

  void changeLayout(Layout layout) {
    currentLayout.value = layout;
  }
}

