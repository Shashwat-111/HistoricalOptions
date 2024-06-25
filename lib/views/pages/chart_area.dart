import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../controllers/option_controller.dart';
import '../../models/graph_data_class.dart';
import '../widgets/ohlc_text_display_row.dart';
import 'main_graph.dart';

class ChartArea extends StatefulWidget {
  const ChartArea({super.key});

  @override
  State<ChartArea> createState() => _ChartAreaState();
}

class _ChartAreaState extends State<ChartArea> {
  OptionDataController odController = Get.put(OptionDataController());
  late TrackballBehavior _trackballBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  late CrosshairBehavior _crosshairBehavior;

  late List<OhlcDatum> _initialData;

  //don't change the order of this list
  List<String> indicators = [
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
  @override
  void initState() {
    _crosshairBehavior = CrosshairBehavior(
      enable: true,
      lineWidth: 0.5,
      lineDashArray: [5, 5],
      shouldAlwaysShow: true,
      lineType: CrosshairLineType.horizontal,
      activationMode: ActivationMode.singleTap,
    );
    _trackballBehavior = TrackballBehavior(
      tooltipDisplayMode: TrackballDisplayMode.none,  //use floatAllPoints to display the trackball,
      enable: true,
      lineWidth: 0.5,
      lineDashArray: [5, 5],
      activationMode: ActivationMode.singleTap,
    );

    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      maximumZoomLevel: 0.05,
      enableMouseWheelZooming: true,
      enablePanning: true,
      enableSelectionZooming: true,
      selectionRectBorderColor: Colors.red,
      zoomMode: ZoomMode.xy,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Check if the data list is null or empty and show a progress indicator
      if (odController.isLoading.value == true) {
        return const Center(child: CircularProgressIndicator());
      }
      if (true) {
        //print("The no. of candles is : ${odController.ohlcDataList.length}");
        //_initialData = odController.ohlcDataList.toList();
        var temp = odController.ohlcDataList.slices(1500).toList();
        _initialData = temp[temp.length - 1];


        //print(_initialData.length);
        //[odController.chartpart.value];    //this makes a list of list of ohlcData with 1000 values
      }
      return buildChartArea();
    });
  }

  Widget buildChartArea() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(
          alignment: Alignment.topCenter,
          children: [
            buildSfCartesianChart(),
            OhlcValueTextColumn(),
            Positioned(
                top: 10,
                left: 20,
                child: Text( "${odController.stockCode} | ${odController.expiryDate} | ${odController.strikePrice}")),
          ]
      ),

    );
  }

  Widget buildSfCartesianChart() {
    return Card(
      elevation: 20,
      child: SfCartesianChart(
        onTrackballPositionChanging: (trackballArgs) {
          odController.updateTrackballPoints(
            trackballArgs.chartPointInfo.chartPoint!.open!.toStringAsFixed(2),
            trackballArgs.chartPointInfo.chartPoint!.high!.toStringAsFixed(2),
            trackballArgs.chartPointInfo.chartPoint!.low!.toStringAsFixed(2),
            trackballArgs.chartPointInfo.chartPoint!.close!.toStringAsFixed(2),
            trackballArgs.chartPointInfo.color!,
            //trackballArgs.chartPointInfo.chartPoint!.volume.toString()....giving null value, no volume attached in chart.
          );
        },
        margin: const EdgeInsets.fromLTRB(50, 50, 10, 10),
        trackballBehavior: _trackballBehavior,
        zoomPanBehavior: _zoomPanBehavior,
        crosshairBehavior: _crosshairBehavior,
        indicators: getIndicators(),
        series: <CandleSeries>[
          CandleSeries<OhlcDatum, DateTime>(
            name: "candle",
            enableSolidCandles: true,
            animationDuration: 0.5,
            dataSource: _initialData,
            xValueMapper: (OhlcDatum data, _) => data.datetime,
            lowValueMapper: (OhlcDatum data, _) => double.parse(data.low),
            highValueMapper: (OhlcDatum data, _) => double.parse(data.high),
            openValueMapper: (OhlcDatum data, _) => double.parse(data.open),
            closeValueMapper: (OhlcDatum data, _) => double.parse(data.close),
          ),
        ],
        primaryXAxis: buildDateTimeCategoryAxis(),
        primaryYAxis: buildNumericAxis(),
      ),
    );
  }
}
