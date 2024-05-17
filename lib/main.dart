import 'package:flutter/material.dart';
import 'package:fno_view/models/graph_data_calss.dart';
import 'package:fno_view/services/remote_service.dart';
import 'package:fno_view/widgets/my_appbar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TrackballBehavior _trackballBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  // late CrosshairBehavior _crosshairBehavior;
  int chartNumber = 2;
  List<OhlcDatum>? _ohlcDataList;

  @override
  void initState() {
    print("hi");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getData();
      setState(() {});
    });

    // ChartSampleData chartSampleData = ChartSampleData();
    // _chartData = chartSampleData.getChartData();
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
    // if (_ohlcDataList != null) {
    //   _ohlcDataList.forEach((ohlcData) {
    //     print("Datetime: ${ohlcData.datetime}");
    //     print("Open: ${ohlcData.open}");
    //     print("High: ${ohlcData.high}");
    //     print("Low: ${ohlcData.low}");
    //     print("Close: ${ohlcData.close}");
    //     print("-----------------------");
    //   });
    // }
    //;
  }

  @override
  Widget build(BuildContext context) {
    print("inside build");
    //ChartSampleData chartSampleData = ChartSampleData();
    //_chartData = chartSampleData.getChartData(chartNumber);
    while (_ohlcDataList == null) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyAppBar(),
              SizedBox(
                child: SizedBox(
                  height: 600,
                  width: 1000,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SfCartesianChart(
                      crosshairBehavior: CrosshairBehavior(
                          shouldAlwaysShow: true,
                          activationMode: ActivationMode.singleTap),
                      title: const ChartTitle(text: "Demo Chart For Ruddu"),
                      trackballBehavior: _trackballBehavior,
                      zoomPanBehavior: _zoomPanBehavior,
                      series: <CandleSeries>[
                        CandleSeries<OhlcDatum, DateTime>(
                            enableSolidCandles: true,
                            animationDuration: 0,
                            dataSource: _ohlcDataList,
                            name: 'AAPL',
                            xValueMapper: (OhlcDatum sales, _) =>
                                sales.datetime,
                            lowValueMapper: (OhlcDatum sales, _) =>
                                double.parse(sales.low),
                            highValueMapper: (OhlcDatum sales, _) =>
                                double.parse(sales.high),
                            openValueMapper: (OhlcDatum sales, _) =>
                                double.parse(sales.open),
                            closeValueMapper: (OhlcDatum sales, _) =>
                                double.parse(sales.close))
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
                        numberFormat:
                            NumberFormat.simpleCurrency(decimalDigits: 0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
