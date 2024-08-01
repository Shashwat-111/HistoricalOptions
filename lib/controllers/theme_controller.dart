import 'package:fno_view/utils/theme.dart';
import 'package:get/get.dart';

enum AppThemeMode {
  dark,
  light
}

class ThemeController extends GetxController {

  //the default theme is dark
  var currentTheme = lightTheme.obs;

  // to check the current theme
  var isDarkMode = false.obs;

  //switches the theme to the desired mode
  void switchTheme(AppThemeMode themeMode){
    if (themeMode == AppThemeMode.dark){
      currentTheme.value = darkTheme;
      isDarkMode.value = true;
    }
    if (themeMode == AppThemeMode.light){
      currentTheme.value = lightTheme;
      isDarkMode.value =false;
    }
  }
}

