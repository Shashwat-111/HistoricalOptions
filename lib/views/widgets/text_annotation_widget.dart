import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../controllers/theme_controller.dart';

CartesianChartAnnotation getAnnotation(text,xOffset,yOffset) {

  //used to switch the text color based on dark or light mode.
  //Had to use this as we don't have a context to get the app theme directly
  ThemeController themeController = Get.put(ThemeController());
  return CartesianChartAnnotation(
    widget: Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w500,
          color:
          themeController.isDarkMode.value ? Colors.white : Colors.black,
          fontSize: 18
      ),
    ),
    coordinateUnit: CoordinateUnit.point,
    x: DateTime.parse(xOffset),
    y: yOffset,
  );
}