import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fno_view/controllers/chart_setting_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  late TooltipBehavior _tooltipBehavior;
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
      tooltipDisplayMode: TrackballDisplayMode
          .none, //use floatAllPoints to display the trackball,
      enable: true,
      lineWidth: 0.5,
      lineDashArray: [5, 5],
      activationMode: ActivationMode.singleTap,
    );

    // _zoomPanBehavior = ZoomPanBehavior(
    //   enablePinching: true,
    //   maximumZoomLevel: 0.05,
    //   enableMouseWheelZooming: true,
    //   enablePanning: true,
    //   enableSelectionZooming: true,
    //   selectionRectBorderColor: Colors.red,
    //   zoomMode: ZoomMode.xy,
    // );

    _tooltipBehavior = TooltipBehavior(
      enable: false,
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
    return Stack(
        alignment: odController.isDeviceSmall.value
            ? Alignment.topLeft
            : Alignment.topRight,
        children: [
          buildSfCartesianChart(),
          OhlcValueTextColumn(),
          Positioned(
              top: 5,
              left: 5,
              child: Text(
                "BANKNIFTY INDEX OPTIONS\n${odController.expiryDate} | CALL | ${odController.strikePrice}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )),
        ]);
  }

  Widget buildSfCartesianChart() {
    ChartSettingController chartSettingController = Get.put(ChartSettingController());
    return Obx(() {
      return SfCartesianChart(
        backgroundColor: Colors.white,
        margin: odController.isDeviceSmall.value
            ? const EdgeInsets.only(top: 70, bottom: 5, right: 5, left: 5)
            : const EdgeInsets.only(top: 70, bottom: 5, right: 5, left: 5),
        tooltipBehavior: _tooltipBehavior,
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
        trackballBehavior: _trackballBehavior,
        zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          maximumZoomLevel: 0.05,
          enableMouseWheelZooming: true,
          enablePanning: chartSettingController.enablePan.value,
          enableSelectionZooming: true,
          selectionRectBorderColor: Colors.red,
          zoomMode: ZoomMode.xy,
        ),
        crosshairBehavior: _crosshairBehavior,
        indicators: getIndicators(),
        enableSideBySideSeriesPlacement: false,
        series: [
          CandleSeries<OhlcDatum, DateTime>(
            //enableTooltip: true,
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
      );
    }
    );
  }
}

ChartAxis buildDateTimeCategoryAxis() {
  return DateTimeCategoryAxis(
    edgeLabelPlacement: EdgeLabelPlacement.shift,
    //labelIntersectAction: AxisLabelIntersectAction.hide,
    labelAlignment: LabelAlignment.center,
    initialZoomPosition: 1,
    interactiveTooltip: const InteractiveTooltip(),
    initialZoomFactor: 0.25,
    intervalType: DateTimeIntervalType.auto,
    dateFormat: DateFormat("d MMM ''yy HH:mm"),
    majorGridLines: const MajorGridLines(width: 1),
  );
}

ChartAxis buildNumericAxis() {
  OptionDataController odController = Get.put(OptionDataController());
  return NumericAxis(
    opposedPosition: !(odController.isDeviceSmall.value),
    numberFormat: NumberFormat.simpleCurrency(decimalDigits: 2),
  );
}
