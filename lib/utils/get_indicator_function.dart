import 'package:fno_view/controllers/indicator_controller.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

List<TechnicalIndicator<dynamic, dynamic>> getIndicators() {
  IndicatorController indicatorController = Get.put(IndicatorController());
  var selectedIndicators = indicatorController.selectedIndicators;

  List<TechnicalIndicator<dynamic, dynamic>> indicators = [];
  String name = "candle";
  if (selectedIndicators[0]) {
    indicators.add(BollingerBandIndicator(seriesName: name));
  }
  if (selectedIndicators[1]) {
    indicators.add(RsiIndicator<dynamic, dynamic>(seriesName: name));
  }
  if (selectedIndicators[2]) {
    indicators.add(SmaIndicator<dynamic, dynamic>(period: 5, seriesName: name));
  }
  if (selectedIndicators[3]) {
    indicators.add(EmaIndicator<dynamic, dynamic>(period: 14, seriesName: name));
  }
  if (selectedIndicators[4]) {
    indicators.add(MacdIndicator<dynamic, dynamic>(seriesName: name));
  }
  if (selectedIndicators[5]) {
    indicators.add(AtrIndicator<dynamic, dynamic>(period: 3, seriesName: name));
  }
  if (selectedIndicators[6]) {
    indicators.add(MomentumIndicator<dynamic, dynamic>(seriesName: name));
  }
  if (selectedIndicators[7]) {
    indicators.add(StochasticIndicator<dynamic, dynamic>(seriesName: name));
  }
  if (selectedIndicators[8]) {
    indicators.add(AccumulationDistributionIndicator<dynamic, dynamic>(seriesName: name));
  }
  if (selectedIndicators[9]) {
    indicators.add(TmaIndicator<dynamic, dynamic>(period: 9, seriesName: name));
  }
  if (selectedIndicators[10]) {
    indicators.add(RocIndicator<dynamic, dynamic>(seriesName: name));
  }
  if (selectedIndicators[11]) {
    indicators.add(WmaIndicator<dynamic, dynamic>(period: 5, seriesName: name));
  }
  return indicators;
}