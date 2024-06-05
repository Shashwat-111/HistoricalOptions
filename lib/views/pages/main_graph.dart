import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fno_view/controllers/option_controller.dart';
import 'package:fno_view/models/graph_data_calss.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:collection/collection.dart';

class MainChart extends StatefulWidget {
  const MainChart({
    super.key,
  });
  @override
  State<MainChart> createState() => _MainChartState();
}

class _MainChartState extends State<MainChart> {
  OptionDataController odController = Get.put(OptionDataController());
  late TrackballBehavior _trackballBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  late CrosshairBehavior _crosshairBehavior;

  late List<OhlcDatum> _initialData;

  @override
  void initState() {
    _crosshairBehavior = CrosshairBehavior(
      enable: true,
      shouldAlwaysShow: true,
      lineType: CrosshairLineType.horizontal,
      activationMode: ActivationMode.singleTap,
    );
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
    );
    _zoomPanBehavior = ZoomPanBehavior(
      maximumZoomLevel: 0.001,
      enableMouseWheelZooming: true,
      enablePanning: true,
      enableSelectionZooming: true,
      selectionRectBorderColor: Colors.red,
      zoomMode: ZoomMode.x,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        // Check if the data list is null or empty and show a progress indicator
        if (odController.isLoading.value == true) {
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));
        }
        if (kDebugMode) {
          print("The no. of candles is : ${odController.ohlcDataList.length}");
          _initialData = odController.ohlcDataList;
          //.slices(1000).toList()[odController.chartpart.value];    //this makes a list of list of ohlcData with 1000 values
          print(_initialData.length);   
          //print(_initialData);
        }
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SfCartesianChart(
              crosshairBehavior: _crosshairBehavior,
              title: ChartTitle(
                  text:
                      "${odController.stockCode} | ${odController.expiryDate} | ${odController.strikePrice}",
                  alignment: ChartAlignment.near),
              trackballBehavior: _trackballBehavior,
              zoomPanBehavior: _zoomPanBehavior,
              series: <CandleSeries>[
                CandleSeries<OhlcDatum, DateTime>(
                  //enableSolidCandles: true,
                  animationDuration: 0,
                  dataSource: _initialData,
                  name: 'AAPL',
                  xValueMapper: (OhlcDatum sales, _) => sales.datetime,
                  lowValueMapper: (OhlcDatum sales, _) =>
                      double.parse(sales.low),
                  highValueMapper: (OhlcDatum sales, _) =>
                      double.parse(sales.high),
                  openValueMapper: (OhlcDatum sales, _) =>
                      double.parse(sales.open),
                  closeValueMapper: (OhlcDatum sales, _) =>
                      double.parse(sales.close),
                ),
              ],
              primaryXAxis: DateTimeCategoryAxis(
                initialZoomPosition: 0.5,
                interactiveTooltip: const InteractiveTooltip(),
                initialZoomFactor: 0.5,
                intervalType: DateTimeIntervalType.auto,
                dateFormat: DateFormat.yMMM().add_jm(),
                majorGridLines: const MajorGridLines(width: 0),
              ),
              primaryYAxis: NumericAxis(
                numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
              ),
            ),
          ),
        );
      },
    );
  }

}



