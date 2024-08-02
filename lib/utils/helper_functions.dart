import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../controllers/chart_setting_controller.dart';
import '../controllers/indicator_controller.dart';
import '../controllers/ohlc_data_controller.dart';

abstract class HelperFunctions {

  ///gets the enum value of the selected timeFrame
  ///and gives back the time value in int
  static convertTimeFrameToMinutes(CandleTimeFrame timeFrame) {
    switch (timeFrame) {
      case CandleTimeFrame.oneMinute:
        return 1;
      case CandleTimeFrame.fiveMinute:
        return 5;
      case CandleTimeFrame.fifteenMinute:
        return 15;
      default:
        throw ArgumentError('Unsupported time frame: $timeFrame');
    }
  }


  ///returns a list of the available selected indicator
  ///with a index associated to it.
  static List<TechnicalIndicator<dynamic, dynamic>> getIndicators() {
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

  ///takes in a OHLC data list and gives the highest value that list ever reached.
  ///use to define the max and min value of y axis to plot the graph
  ///it returns +20% value of the highest to make sure there is a padding at he top
  static double getGlobalHigh (List list) {
    var tempList = list;
    int highestValuesIndex = 0;
    for (int i = 1;i<tempList.length;i++){
      bool isHigh = double.parse(tempList[i].high) > double.parse(tempList[highestValuesIndex].high);
      if(isHigh){
        highestValuesIndex = i;
      }
    }
    //increase the returned value by 20%, for padding
    return double.parse(tempList[highestValuesIndex].high)*1.2;
  }


  ///takes in a OHLC data list and gives the lowest value that list ever reached.
  ///use to define the max and min value of y axis to plot the graph
  ///it returns +20% value of the lowest to make sure there is a padding at the bottom
  static double getGlobalLowest(List list){
    var tempList = list;
    int lowestValuesIndex = 0;
    for (int i = 1;i<tempList.length;i++){
      bool isLower = double.parse(tempList[i].low) < double.parse(tempList[lowestValuesIndex].low);
      if(isLower){
        lowestValuesIndex = i;
      }
    }
    //increase the returned value by 20%, for padding
    return double.parse(tempList[lowestValuesIndex].low)*1.2;
  }

  ///takes in a index value, and return the value of volume
  ///associated with that index in the current ohlcDataLIst
  static int getVolumeFromIndex(int index){
    OhlcDataController dataController = Get.put(OhlcDataController());
    return dataController.ohlcDataList[index].volume;
  }

  ///takes in the index of the candle currently being hovered on,
  ///and returns a percent change value, compared form the previous candle.
  ///if the index is zero, it returns a "-"
  static String getPercentageChange(int currentIndex){
    OhlcDataController dataController = Get.put(OhlcDataController());
    if(currentIndex!=0){
      var previousClose =double.parse(dataController.ohlcDataList[currentIndex-1].close);
      var currentClose =double.parse(dataController.ohlcDataList[currentIndex].close);
      var percentChange = (((previousClose-currentClose)/previousClose)*100).toPrecision(2);
      if (percentChange<0) {
        return percentChange.toStringAsFixed(2);
      } else {
        return "+${percentChange.toStringAsFixed(2)}";
      }
    } else {
      return "-";
    }
  }
}