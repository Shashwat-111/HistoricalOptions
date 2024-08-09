import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/indicator_controller.dart';

class IndicatorSelectorArea extends StatelessWidget {
  IndicatorSelectorArea({
    super.key,
    required this.indicators,
  });

  final List<String> indicators;
  final IndicatorController indicatorController = Get.put(IndicatorController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 250,
      child: ListView.builder(
          itemCount: indicators.length,
          itemBuilder: (_,n){
            return Obx(
                  ()=> CheckboxListTile(
                  title: Text(indicators[n]),
                  value: indicatorController.selectedIndicators[n],
                  onChanged: (bool? isSelected){
                    //print("index $n bool value: $isSelected");
                    indicatorController.updateSelectedIndicator(n, isSelected);
                  }),
            );
          }),
    );
  }
}
