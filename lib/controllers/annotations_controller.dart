import 'package:flutter/material.dart';
import 'package:fno_view/controllers/theme_controller.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnnotationsController extends GetxController {
  var annotationList = <CartesianChartAnnotation>[].obs;
  var annotationText = "default".obs;

  ThemeController themeController = Get.put(ThemeController());

  setAnnotationText(String text){
    print("setting annotation text to $text");
    annotationText.value = text;
    print("new setting annotation text to ${annotationText.value}");
  }

  List<CartesianChartAnnotation> annotate(
      {required String x, required double y, required String text}) {
    var newAnnotation = CartesianChartAnnotation(
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
      x: DateTime.parse(x),
      y: y,
    );
    annotationList.add(newAnnotation);
    return annotationList;
  }
}
