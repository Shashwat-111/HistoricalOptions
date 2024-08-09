import 'package:get/get.dart';

//for managing available and currently selected technical indicators
class IndicatorController extends GetxController {

  //generates a list of 12 bool values, indicating
  // which of the 12 available indicators are active
  var selectedIndicators = List.generate(supportedIndicatorList.length, (_) => false).obs;

  //updates the value to true/false in the above list
  // based on the current selected indicator
  void updateSelectedIndicator(index, bool? isSelected) {
    selectedIndicators[index]= isSelected!;
  }
}

List<String> supportedIndicatorList = [
  "Bollinger Band",
  // "Relative Strength Index (RSI)",
  "Simple Moving Average (SMA)",
  "Exponential Moving Average (EMA)",
  // "Moving Average Convergence Divergence (MACD)",
  // "Average True Range (ATR)",
  // "Momentum",
  // "Stochastic",
  // "Accumulation Distribution (AD)",
  "Triangular Moving Average (TMA)",
  // "Rate of Change (ROC)",
  "Weighted Moving Average (WMA)"
];