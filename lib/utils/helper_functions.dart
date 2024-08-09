import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../controllers/chart_setting_controller.dart';
import '../controllers/indicator_controller.dart';
import '../controllers/ohlc_data_controller.dart';
import '../models/graph_data_class.dart';
import 'constants.dart';

abstract class HelperFunctions {

  ///returns true if the current width of screen is
  ///less than the defined [mobileWidth]
  static bool isMobileView(){
    //gets the width of the current screen without needing any context
    return (WidgetsBinding
        .instance.platformDispatcher.views.first.physicalSize.width /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio)<mobileWidth;
  }

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

    //the indicators that are commented, works, but do not get
    // displayed on the chart as there value is mostly very lower that
    // the current visible min and current visible max. So till a solution
    // is found to display both simultaneous, keeping such indicator commented.
    //change the [selectedIndicators[index] in 0-12 sequence.
    if (selectedIndicators[0]) {
      indicators.add(BollingerBandIndicator(seriesName: name));
    }
    // if (selectedIndicators[1]) {
    //   indicators.add(RsiIndicator<dynamic, dynamic>(seriesName: name));
    // }
    if (selectedIndicators[1]) {
      indicators.add(SmaIndicator<dynamic, dynamic>(period: 5, seriesName: name));
    }
    if (selectedIndicators[2]) {
      indicators.add(EmaIndicator<dynamic, dynamic>(period: 14, seriesName: name));
    }
    // if (selectedIndicators[4]) {
    //   indicators.add(MacdIndicator<dynamic, dynamic>(seriesName: name));
    // }
    // if (selectedIndicators[5]) {
    //   indicators.add(AtrIndicator<dynamic, dynamic>(period: 3, seriesName: name));
    // }
    // if (selectedIndicators[6]) {
    //   indicators.add(MomentumIndicator<dynamic, dynamic>(seriesName: name));
    // }
    // if (selectedIndicators[7]) {
    //   indicators.add(StochasticIndicator<dynamic, dynamic>(seriesName: name));
    // }
    // if (selectedIndicators[8]) {
    //   indicators.add(AccumulationDistributionIndicator<dynamic, dynamic>(seriesName: name));
    // }
    if (selectedIndicators[3]) {
      indicators.add(TmaIndicator<dynamic, dynamic>(period: 9, seriesName: name));
    }
    // if (selectedIndicators[10]) {
    //   indicators.add(RocIndicator<dynamic, dynamic>(seriesName: name));
    // }
    if (selectedIndicators[4]) {
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
  ///it returns -20% value of the lowest to make sure there is a padding at the bottom
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
    return double.parse(tempList[lowestValuesIndex].low)*0.80;
  }

  ///takes in a index value, and return the value of volume
  ///associated with that index in the current ohlcDataLIst
  static int getVolumeFromIndex(int index, List<OhlcDatum> currentlyDisplayedOHLC){
    try {
      return currentlyDisplayedOHLC[index].volume;
    } catch (e){
      return 0;
    }
  }

  ///takes in the index of the candle currently being hovered on,
  ///and returns a percent change value, compared form the previous candle.
  ///if the index is zero, it returns a "-"
  static String getPercentageChange(int currentIndex, currentlyDisplayedOHLC){
    try {
      if(currentIndex!=0){
        var previousClose =double.parse(currentlyDisplayedOHLC[currentIndex-1].close);
        var currentClose =double.parse(currentlyDisplayedOHLC[currentIndex].close);
        var percentChange = (((currentClose-previousClose)/previousClose)*100).abs();
        return previousClose>currentClose
            ? "-${percentChange.toStringAsFixed(2)}"
            : "+${percentChange.toStringAsFixed(2)}";
      } else {
        return "-";
      }
    } catch (e){
      return "-";
    }
  }

  ///Till lazy loading is implemented, this function is being used to
  /// return the number of candles that any chart needs to display
  /// based on the device mobile or desktop.
  /// For mobile device 500 candles are displayed.
  /// for desktop 1500 candles are displayed.
  /// these defaults can be changed from the constants file.
  static List<OhlcDatum> decreaseNumberOfCandles(BuildContext context){
    OhlcDataController dataController = Get.put(OhlcDataController());
    var temp = dataController.ohlcDataList.slices(
        MediaQuery.of(context).size.width< mobileWidth
            ? candleNumberForMobile
            : candleNumberForDesktop
    ).toList();
    return temp[temp.length - 1];
  }
}