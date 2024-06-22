import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fno_view/controllers/option_controller.dart';
import 'package:fno_view/models/graph_data_class.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../widgets/ohlc_text_display_row.dart';

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
  List<String> indicators = [
    "Average True Range",
    "Bollinger Bands",
    "Exponential Moving Average",
    "Moving Average Convergence Divergence",
    "Momentum",
    "Relative Strength Index",
    "Simple Moving Average",
    "Stochastic Oscillator",
    "Technical Indicator",
    "Triangular Moving Average"
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
      //tooltipDisplayMode: TrackballDisplayMode.none,
      enable: true,
      lineWidth: 0.5,
      lineDashArray: [5, 5],
      activationMode: ActivationMode.singleTap,
    );

    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      maximumZoomLevel: 0.1,
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(
      () {
        // Check if the data list is null or empty and show a progress indicator
        if (odController.isLoading.value == true) {
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));
        }
        if (kDebugMode) {
          print("The no. of candles is : ${odController.ohlcDataList.length}");
          _initialData = odController.ohlcDataList.slices(300).toList()[0];
          print(_initialData.length);
          //[odController.chartpart.value];    //this makes a list of list of ohlcData with 1000 values
        }
        return SizedBox(
          height:
              height - 50, //todo make 50 a global variable named appBarHeight
          width: width,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: buildChartArea(),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [NewWidget(indicators: indicators), buildWatchlist()],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildWatchlist() {
    return const Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox.expand(
            child: Card(
          elevation: 20,
          child: Center(
            child: Text("Place for Watchlist"),
          ),
        )),
      ),
    );
  }

  Widget buildChartArea() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(
          alignment: Alignment.topCenter,
          children: [buildSfCartesianChart(), OhlcValueTextColumn()]),
    );
  }

  Widget buildSfCartesianChart() {
    return Card(
      elevation: 20,
      child: SfCartesianChart(
        //todo: when indicators are also displayed in chart, the values below dont make sense/give null values.
        // onTrackballPositionChanging: (trackballArgs) {
        //   odController.updateTrackballPoints(
        //       trackballArgs.chartPointInfo.chartPoint!.open!.toStringAsFixed(2),
        //       trackballArgs.chartPointInfo.chartPoint!.high
        //           !.toStringAsFixed(2),
        //       trackballArgs.chartPointInfo.chartPoint!.low
        //           !.toStringAsFixed(2),
        //       trackballArgs.chartPointInfo.chartPoint!.close
        //           !.toStringAsFixed(2),
        //       trackballArgs.chartPointInfo.color!,
        //   );
        // },
        margin: const EdgeInsets.fromLTRB(50, 50, 10, 10),
        //backgroundColor: const Color.fromRGBO(23,27,38,1),
        // title: ChartTitle(
        //     text:
        //         "${odController.stockCode} | ${odController.expiryDate} | ${odController.strikePrice}",
        //     alignment: ChartAlignment.near),
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

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.indicators,
  });

  final List<String> indicators;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox.expand(
            child: Card(
          elevation: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Technical Indicator", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  SizedBox(height: 10,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: indicators.length,
                        itemBuilder: (_,n){
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Icon(Icons.check_box_outline_blank_sharp),
                            SizedBox(width: 5,),
                            Text(indicators[n]),
                          ],
                        ),
                      );
                    }),
                  )
                ],
              ),
        )),
      ),
    );
  }
}

DateTimeCategoryAxis buildDateTimeCategoryAxis() {
  return DateTimeCategoryAxis(
    initialZoomPosition: 1,
    interactiveTooltip: const InteractiveTooltip(),
    initialZoomFactor: 0.2,
    intervalType: DateTimeIntervalType.auto,
    dateFormat: DateFormat("d MMM ''yy HH:mm"), // Adjusted date format
    majorGridLines: const MajorGridLines(width: 1),
  );
}

NumericAxis buildNumericAxis() {
  return NumericAxis(
    opposedPosition: true,
    numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
  );
}

List<TechnicalIndicator<dynamic, dynamic>> getIndicators() {
  List<bool> selectedIndicators = List.generate(12, (_) => false);
  print(selectedIndicators);
  List<TechnicalIndicator<dynamic, dynamic>> indicators = [];

  if (selectedIndicators[0]) {
    indicators.add(AccumulationDistributionIndicator<dynamic, dynamic>(
      seriesName: 'candle',
    ));
  }
  if (selectedIndicators[1]) {
    indicators.add(AtrIndicator<dynamic, dynamic>(
      period: 3,
      seriesName: 'candle',
    ));
  }
  if (selectedIndicators[2]) {
    indicators.add(BollingerBandIndicator(
      seriesName: "candle",
    ));
  }
  if (selectedIndicators[3]) {
    indicators.add(EmaIndicator<dynamic, dynamic>(
      period: 14,
      seriesName: 'candle',
    ));
  }
  if (selectedIndicators[4]) {
    indicators.add(MacdIndicator<dynamic, dynamic>(
      seriesName: 'candle',
    ));
  }
  if (selectedIndicators[5]) {
    indicators.add(MomentumIndicator<dynamic, dynamic>(
      seriesName: 'candle',
    ));
  }
  if (selectedIndicators[6]) {
    indicators.add(RsiIndicator<dynamic, dynamic>(
      seriesName: 'candle',
    ));
  }
  if (selectedIndicators[7]) {
    indicators.add(SmaIndicator<dynamic, dynamic>(
      period: 5,
      seriesName: 'candle',
    ));
  }
  if (selectedIndicators[8]) {
    indicators.add(StochasticIndicator<dynamic, dynamic>(
      seriesName: 'candle',
    ));
  }
  if (selectedIndicators[9]) {
    indicators.add(TmaIndicator<dynamic, dynamic>(
      period: 9,
      seriesName: 'candle',
    ));
  }
  if (true) {
    indicators.add(RocIndicator<dynamic, dynamic>(
      seriesName: 'candle',
    ));
  }
  if (selectedIndicators[11]) {
    indicators.add(WmaIndicator<dynamic, dynamic>(
      period: 5,
      seriesName: 'candle',
    ));
  }

  return indicators;
}
