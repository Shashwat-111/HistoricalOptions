import 'package:flutter/material.dart';
import 'package:fno_view/controllers/option_controller.dart';
import 'package:fno_view/models/graph_data_class.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../widgets/Indicator_dialog_box.dart';
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
                  IndicatorSelectorArea(indicators: supportedIndicatorList),
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