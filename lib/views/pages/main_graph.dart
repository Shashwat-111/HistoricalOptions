import 'package:flutter/material.dart';
import 'package:fno_view/controllers/option_controller.dart';
import 'package:fno_view/models/graph_data_class.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'chart_area.dart';

class MainChart extends StatefulWidget {
  const MainChart({
    super.key,
  });
  @override
  State<MainChart> createState() => _MainChartState();
}

class _MainChartState extends State<MainChart> {
  OptionDataController odController = Get.put(OptionDataController());
  //don't change the order of this list
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    bool isDeviceSmall = width < 1000 ? true : false;
    return SizedBox(
          height:
              height - 50, //todo make 50 a global variable named appBarHeight
          width: width,
          child: isDeviceSmall ? const ChartArea() : buildFullScreen(),
        );
  }

  Row buildFullScreen() {
    return Row(
          children: [
            const Expanded(
              flex: 3,
              child: ChartArea(),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  IndicatorSelectorArea(indicators: indicators),
                  //buildWatchlist()
                ],
              ),
            )
          ],
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

}

class IndicatorSelectorArea extends StatelessWidget {
  IndicatorSelectorArea({
    super.key,
    required this.indicators,
  });

  final List<String> indicators;
  final OptionDataController odController = Get.put(OptionDataController());
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox.expand(
            child: Card(
          elevation: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10,10,0,0),
                    child: Text("Technical Indicators", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: indicators.length,
                        itemBuilder: (_,n){
                      return Padding(
                        padding: const EdgeInsets.all(0),
                        child: Obx(
                            ()=> CheckboxListTile(
                              title: Text(indicators[n]),
                              value: odController.selectedIndicators[n],
                              onChanged: (bool? isSelected){
                                //print("index $n bool value: $isSelected");
                                odController.updateSelectedIndicator(n, isSelected);
                          }),
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
    initialZoomFactor: 0.25,
    intervalType: DateTimeIntervalType.auto,
    dateFormat: DateFormat("d MMM ''yy HH:mm"), // Adjusted date format
    majorGridLines: const MajorGridLines(width: 1),
  );
}

NumericAxis buildNumericAxis() {
  OptionDataController odController = Get.put(OptionDataController());
  return NumericAxis(
    opposedPosition: !(odController.isDeviceSmall.value),
    numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
  );
}

List<TechnicalIndicator<dynamic, dynamic>> getIndicators() {
  OptionDataController odController = Get.put(OptionDataController());
  var selectedIndicators = odController.selectedIndicators;
  //print(selectedIndicators);
  List<TechnicalIndicator<dynamic, dynamic>> indicators = [];
  String _name = "candle";
  if (selectedIndicators[0]) {
    indicators.add(BollingerBandIndicator(seriesName: _name));
  }
  if (selectedIndicators[1]) {
    indicators.add(RsiIndicator<dynamic, dynamic>(seriesName: _name));
  }
  if (selectedIndicators[2]) {
    indicators.add(SmaIndicator<dynamic, dynamic>(period: 5, seriesName: _name));
  }
  if (selectedIndicators[3]) {
    indicators.add(EmaIndicator<dynamic, dynamic>(period: 14, seriesName: _name));
  }
  if (selectedIndicators[4]) {
    indicators.add(MacdIndicator<dynamic, dynamic>(seriesName: _name));
  }
  if (selectedIndicators[5]) {
    indicators.add(AtrIndicator<dynamic, dynamic>(period: 3, seriesName: _name));
  }
  if (selectedIndicators[6]) {
    indicators.add(MomentumIndicator<dynamic, dynamic>(seriesName: _name));
  }
  if (selectedIndicators[7]) {
    indicators.add(StochasticIndicator<dynamic, dynamic>(seriesName: _name));
  }
  if (selectedIndicators[8]) {
    indicators.add(AccumulationDistributionIndicator<dynamic, dynamic>(seriesName: _name));
  }
  if (selectedIndicators[9]) {
    indicators.add(TmaIndicator<dynamic, dynamic>(period: 9, seriesName: _name));
  }
  if (selectedIndicators[10]) {
    indicators.add(RocIndicator<dynamic, dynamic>(seriesName: _name));
  }
  if (selectedIndicators[11]) {
    indicators.add(WmaIndicator<dynamic, dynamic>(period: 5, seriesName: _name));
  }

  return indicators;
}

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
