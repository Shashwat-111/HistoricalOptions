import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      tooltipDisplayMode: TrackballDisplayMode.none,
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
    return Obx(
      () {
        // Check if the data list is null or empty and show a progress indicator
        if (odController.isLoading.value == true) {
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));
        }
        if (kDebugMode) {
          print("The no. of candles is : ${odController.ohlcDataList.length}");
          _initialData =
              odController.ohlcDataList.slices(300).toList()[0];
          print(_initialData.length);
          //[odController.chartpart.value];    //this makes a list of list of ohlcData with 1000 values
        }
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                right: 400, top: 10, left: 10, bottom: 10),
            child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  buildSfCartesianChart(),
                  OhlcValueTextColumn()
            ]),
          ),
        );
      },
    );
  }

  Card buildSfCartesianChart() {
    return Card(
              elevation: 20,
              child: SfCartesianChart(
                onTrackballPositionChanging: (trackballArgs) {
                  odController.updateTrackballPoints(
                      trackballArgs.chartPointInfo.chartPoint!.open!.toStringAsFixed(2),
                      trackballArgs.chartPointInfo.chartPoint!.high
                          !.toStringAsFixed(2),
                      trackballArgs.chartPointInfo.chartPoint!.low
                          !.toStringAsFixed(2),
                      trackballArgs.chartPointInfo.chartPoint!.close
                          !.toStringAsFixed(2),
                      trackballArgs.chartPointInfo.color!,
                  );
                },
                margin: const EdgeInsets.fromLTRB(40, 10, 10, 10),
                //backgroundColor: const Color.fromRGBO(23,27,38,1),
                title: ChartTitle(
                    text:
                        "${odController.stockCode} | ${odController.expiryDate} | ${odController.strikePrice}",
                    alignment: ChartAlignment.near),
                trackballBehavior: _trackballBehavior,
                zoomPanBehavior: _zoomPanBehavior,
                crosshairBehavior: _crosshairBehavior,
                series: <CandleSeries>[
                  CandleSeries<OhlcDatum, DateTime>(
                    enableSolidCandles: true,
                    animationDuration: 0.5,
                    dataSource: _initialData,
                    xValueMapper: (OhlcDatum data, _) => data.datetime,
                    lowValueMapper: (OhlcDatum data, _) =>
                        double.parse(data.low),
                    highValueMapper: (OhlcDatum data, _) =>
                        double.parse(data.high),
                    openValueMapper: (OhlcDatum data, _) =>
                        double.parse(data.open),
                    closeValueMapper: (OhlcDatum data, _) =>
                        double.parse(data.close),
                  ),
                ],
                primaryXAxis: buildDateTimeCategoryAxis(),
                primaryYAxis: buildNumericAxis(),
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
