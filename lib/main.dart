import 'package:flutter/material.dart';
import 'package:fno_view/widgets/my_appbar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'chart_sample_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<ChartSampleData> _chartData;
  late TrackballBehavior _trackballBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

 @override
  void initState() {
    ChartSampleData chartSampleData = ChartSampleData();
    _chartData = chartSampleData.getChartData();
    _trackballBehavior = TrackballBehavior(
        enable: true, 
        activationMode: ActivationMode.singleTap);
    _zoomPanBehavior = ZoomPanBehavior(
      enableMouseWheelZooming: true, 
      enablePanning: true,
      enableSelectionZooming: true,
      zoomMode: ZoomMode.x,
      );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyAppBar(),
              SizedBox(
                child: SizedBox(
                  height: 600,
                  width: 1000,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SfCartesianChart(
                      title: const ChartTitle(text: "Demo Chart For Ruddu"),
                      trackballBehavior: _trackballBehavior,
                      zoomPanBehavior: _zoomPanBehavior,
                      series: <CandleSeries>[
                        CandleSeries<ChartSampleData, DateTime>(
                            enableSolidCandles: true,
                            animationDuration: 300,
                            dataSource: _chartData,
                            name: 'AAPL',
                            xValueMapper: (ChartSampleData sales, _) => sales.x,
                            lowValueMapper: (ChartSampleData sales, _) => sales.low,
                            highValueMapper: (ChartSampleData sales, _) => sales.high,
                            openValueMapper: (ChartSampleData sales, _) => sales.open,
                            closeValueMapper: (ChartSampleData sales, _) => sales.close)
                      ],
                      primaryXAxis: DateTimeAxis(
                        dateFormat: DateFormat.MMM(),
                        majorGridLines: const MajorGridLines(width: 0),
                      ),
                      primaryYAxis: NumericAxis(
                        minimum: 70,
                        maximum: 140,
                        interval: 10,
                        numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
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


