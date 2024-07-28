import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../controllers/option_controller.dart';

class IndicatorDialogBox extends StatefulWidget {
  final Widget child;
  const IndicatorDialogBox({super.key, required this.child});

  @override
  State<IndicatorDialogBox> createState() => _IndicatorDialogBoxState();
}

class _IndicatorDialogBoxState extends State<IndicatorDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
          width: 500,
          child: widget.child));
  }
}

class IndicatorSelectorArea extends StatelessWidget {
  IndicatorSelectorArea({
    super.key,
    required this.indicators,
  });

  final List<String> indicators;
  final OptionDataController odController = Get.put(OptionDataController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 460,
      child: ListView.builder(
          itemCount: indicators.length,
          itemBuilder: (_,n){
            return Padding(
              padding: const EdgeInsets.all(0),
              child: Obx(
                    ()=> CheckboxListTile(
                    title: Text(indicators[n]),
                    value: odController.selectedIndicators[n],
                    onChanged: (bool? isSelected){
                      //print("index $n bool value: $isSelected");
                      odController.updateSelectedIndicator(n, isSelected);
                    }),
              ),
            );
          }),
    );
  }
}

List<String> supportedIndicatorList = [
  "Bollinger Band",
  "Relative Strength Index (RSI)",
  "Simple Moving Average (SMA)",
  "Exponential Moving Average (EMA)",
  "Moving Average Convergence Divergence (MACD)",
  "Average True Range (ATR)",
  "Momentum",
  "Stochastic",
  "Accumulation Distribution (AD)",
  "Triangular Moving Average (TMA)",
  "Rate of Change (ROC)",
  "Weighted Moving Average (WMA)"
];
