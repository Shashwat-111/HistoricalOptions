import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../views/widgets/text_annotation_widget.dart';

class AnnotationsController extends GetxController {

  //maintains the current list of annotations added
  var annotationList = <CartesianChartAnnotation>[].obs;

  //A temporary value to store the text that user adds in the "add annotation" text field
  var annotationText = "".obs;

  //called after user press "ok" in the add annotation text box
  setAnnotationText(String text){
    annotationText.value = text;
  }

  //returns the new list of annotated values, including the one recently added.
  List<CartesianChartAnnotation> annotate(
      {required String xOffset, required double yOffset, required String text}) {
    annotationList.add(getAnnotation(text,xOffset,yOffset));
    return annotationList;
  }

  //a function to clear all annotation. Used when chat is reloaded/ new chat is fetched.
  clearAnnotations(){
    annotationList.clear();
    annotationText.value = "";
  }
}
