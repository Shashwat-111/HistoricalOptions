import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fno_view/models/graph_data_calss.dart';
import 'package:fno_view/services/remote_service.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MainChart extends StatefulWidget {
  const MainChart({
    super.key,
  });
  @override
  State<MainChart> createState() => _MainChartState();
}

class _MainChartState extends State<MainChart> {
  late TrackballBehavior _trackballBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  List<OhlcDatum>? _ohlcDataList;

  @override
  void initState() {
    if (kDebugMode) {
      print("hi");
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getData();
      setState(() {});
    });
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
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

  getData() async {
    var shashwat = await RemoteService().getData("/options/2");
    _ohlcDataList = shashwat!.ohlcData;
  }

  @override
  Widget build(BuildContext context) {
 
    return Stack(
      alignment: Alignment.center,
      children: [
        _ohlcDataList == null ? const CircularProgressIndicator() : Container(),
        SfCartesianChart(
        crosshairBehavior: CrosshairBehavior(
            shouldAlwaysShow: true, activationMode: ActivationMode.singleTap),
        title: const ChartTitle(text: "Demo Chart For Ruddu"),
        trackballBehavior: _trackballBehavior,
        zoomPanBehavior: _zoomPanBehavior,
        series: <CandleSeries>[
          CandleSeries<OhlcDatum, DateTime>(
              enableSolidCandles: true,
              animationDuration: 0,
              dataSource: _ohlcDataList,
              name: 'AAPL',
              xValueMapper: (OhlcDatum sales, _) => sales.datetime,
              lowValueMapper: (OhlcDatum sales, _) => double.parse(sales.low),
              highValueMapper: (OhlcDatum sales, _) => double.parse(sales.high),
              openValueMapper: (OhlcDatum sales, _) => double.parse(sales.open),
              closeValueMapper: (OhlcDatum sales, _) => double.parse(sales.close))
        ],
        primaryXAxis: const DateTimeCategoryAxis(
          initialZoomPosition: 1,
          interactiveTooltip: InteractiveTooltip(),
          initialZoomFactor: 0.05,
          intervalType: DateTimeIntervalType.minutes,
          //dateFormat: DateFormat.MMM(),
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          // minimum: 70,
          // maximum: 140,
          //interval:,
          numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
        ),
      ),]
    );
  }
}
