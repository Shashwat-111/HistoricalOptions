import 'package:flutter/material.dart';
import 'package:fno_view/controllers/annotations_controller.dart';
import 'package:fno_view/controllers/chart_setting_controller.dart';
import 'package:fno_view/utils/helper_functions.dart';
import 'package:fno_view/views/responsive/responsive.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../controllers/ohlc_data_controller.dart';
import '../../controllers/trackball_controller.dart';
import '../../models/graph_data_class.dart';
import '../../utils/constants.dart';
import '../widgets/ohlc_text_display_row.dart';

class ChartArea extends StatefulWidget {
  const ChartArea({super.key});

  @override
  State<ChartArea> createState() => _ChartAreaState();
}

class _ChartAreaState extends State<ChartArea> {
  OhlcDataController dataController = Get.put(OhlcDataController());
  ChartSettingController chartSettingController =
      Get.put(ChartSettingController());
  TrackballController trackballController = Get.put(TrackballController());
  AnnotationsController annotationsController = Get.put(AnnotationsController());
  late List<OhlcDatum> currentlyDisplayedOHLC;
  ChartSeriesController? seriesController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // show a progress indicator till data is being fetched
      if (dataController.isLoading.value == true) {
        return const Center(child: CircularProgressIndicator());
      }
      //todo implement lazy loading
      //huge number of candles are causing performance issue so,
      //using less number of candles till lazy loading is implemented
      currentlyDisplayedOHLC = HelperFunctions.decreaseNumberOfCandles(context);
      return buildChartLayout2();
    });
  }

  Widget buildChartLayout2() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [buildChartDetailsRow(), buildSfCartesianChart()],
    );
  }

  Widget buildChartDetailsRow() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ResponsiveLayout(
          //just showing the trackball value on mobile device.
          mobileBody: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OhlcValueTextColumn(
                  currentlyDisplayedOHLC: currentlyDisplayedOHLC),
            ],
          ),

          desktopBody: Row(
            children: [
              Text(
                  "BANKNIFTY INDEX OPTIONS\n"
                  "${dataController.currentExpiry} | "
                  "${dataController.currentRight.toUpperCase()} | "
                  "${dataController.currentStrike}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
              const Spacer(),
              OhlcValueTextColumn(
                  currentlyDisplayedOHLC: currentlyDisplayedOHLC),
            ],
          ),
        ));
  }

  Widget buildSfCartesianChart() {
    return Obx(() {
      return Expanded(
        child: SfCartesianChart(
          backgroundColor: Theme.of(context).canvasColor,
          trackballBehavior: TrackballBehavior(
            tooltipDisplayMode: chartSettingController.isTooltipEnabled.value
                ? TrackballDisplayMode.floatAllPoints
                : TrackballDisplayMode.none,
            enable: true,
            lineWidth: 0.5,
            lineDashArray: [5, 5],
            activationMode: ActivationMode.singleTap,
          ),
          zoomPanBehavior:
              //CustomZoomPanBehavior2(),
              ZoomPanBehavior(
            enablePinching: true,
            maximumZoomLevel: 0.05,
            enableMouseWheelZooming: true,
            enablePanning: chartSettingController.isPanEnabled.value,
            enableSelectionZooming:
                chartSettingController.isSelectionZoomingEnabled.value,
            selectionRectBorderColor: Colors.red,
            zoomMode: chartSettingController.isPanInYEnabled.value
                ? ZoomMode.xy
                : ZoomMode.x,
          ),
          crosshairBehavior: CrosshairBehavior(
            enable: true,
            lineWidth: 0.5,
            lineDashArray: [5, 5],
            shouldAlwaysShow: true,
            lineType: CrosshairLineType.horizontal,
            activationMode: ActivationMode.singleTap,
          ),
          onTrackballPositionChanging: (trackballArgs) {
            trackballController.updateTrackballPoints(
                trackballArgs.chartPointInfo.chartPoint!.open!
                    .toStringAsFixed(2),
                trackballArgs.chartPointInfo.chartPoint!.high!
                    .toStringAsFixed(2),
                trackballArgs.chartPointInfo.chartPoint!.low!
                    .toStringAsFixed(2),
                trackballArgs.chartPointInfo.chartPoint!.close!
                    .toStringAsFixed(2),
                trackballArgs.chartPointInfo.color!,
                trackballArgs.chartPointInfo.dataPointIndex!);
          },
          indicators: HelperFunctions.getIndicators(),
          annotations: annotationsController.annotationList,
          enableSideBySideSeriesPlacement: false,
          series: [
            // checks if user wants bar or candle type graph and selects the chart
            chartSettingController.candleType.value == CandleType.bar
                ? HiloOpenCloseSeries<OhlcDatum, DateTime>(
                    bearColor: const Color.fromRGBO(242, 54, 69, 1),
                    bullColor: const Color.fromRGBO(8, 153, 129, 1),
                    //enableTooltip: true,
                    name: "candle",
                    onRendererCreated: (ChartSeriesController controller) {
                      seriesController = controller;
                    },
                    animationDuration: 0.5,
                    dataSource: currentlyDisplayedOHLC,
                    xValueMapper: (OhlcDatum data, _) => data.datetime,
                    lowValueMapper: (OhlcDatum data, _) =>
                        double.parse(data.low),
                    highValueMapper: (OhlcDatum data, _) =>
                        double.parse(data.high),
                    openValueMapper: (OhlcDatum data, _) =>
                        double.parse(data.open),
                    closeValueMapper: (OhlcDatum data, _) =>
                        double.parse(data.close),
                  )
                : CandleSeries<OhlcDatum, DateTime>(
                    bearColor: const Color.fromRGBO(242, 54, 69, 1),
                    bullColor: const Color.fromRGBO(8, 153, 129, 1),
                    //enableTooltip: true,
                    name: "candle",
                    onRendererCreated: (ChartSeriesController controller) {
                      seriesController = controller;
                    },
                    enableSolidCandles:
                        chartSettingController.isCandleTypeSolid.value,
                    animationDuration: 0.5,
                    dataSource: currentlyDisplayedOHLC,
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
          // onChartTouchInteractionMove: (ChartTouchInteractionArgs args) {
          //   final Offset value = Offset(args.position.dx, args.position.dy);
          //   CartesianChartPoint<dynamic> chartpoint =
          //   seriesController!.pixelToPoint(value);
          //   print('X point: ${chartpoint.x}');
          //   print('Y point: ${chartpoint.y}');
          // },
          onChartTouchInteractionUp: (ChartTouchInteractionArgs args) {
            final Offset value = Offset(args.position.dx, args.position.dy);
            CartesianChartPoint<dynamic> chartpoint =
                seriesController!.pixelToPoint(value);

            //todo figure how to get rid of this set state
            setState(() {
              if (chartSettingController.isAnnotationEnabled.value){
                annotationsController.annotate(xOffset: chartpoint.x.toString(), yOffset: chartpoint.y!.toDouble(), text: annotationsController.annotationText.value);
                chartSettingController.switchAnnotation();
              }
            });
          },
          primaryXAxis: buildDateTimeCategoryAxis(),
          primaryYAxis: buildNumericAxis(),
        ),
      );
    });
  }

  ChartAxis buildDateTimeCategoryAxis() {
    return DateTimeCategoryAxis(
      edgeLabelPlacement: EdgeLabelPlacement.shift,
      //labelIntersectAction: AxisLabelIntersectAction.hide,
      labelAlignment: LabelAlignment.center,
      initialZoomPosition: 1,
      interactiveTooltip: const InteractiveTooltip(),
      //initialZoomFactor: 0.25,
      initialZoomFactor: MediaQuery.of(context).size.width < mobileWidth
          ? initialZoomFactorForMobile
          : initialZoomFactorForDesktop,
      intervalType: DateTimeIntervalType.auto,
      dateFormat: DateFormat("d MMM ''yy HH:mm"),
      majorGridLines: const MajorGridLines(width: 1),
    );
  }

  ChartAxis buildNumericAxis() {
    return NumericAxis(
      initialVisibleMaximum:
          HelperFunctions.getGlobalHigh(currentlyDisplayedOHLC),
      initialVisibleMinimum:
          HelperFunctions.getGlobalLowest(currentlyDisplayedOHLC),
      maximum: HelperFunctions.getGlobalHigh(currentlyDisplayedOHLC),
      minimum: HelperFunctions.getGlobalLowest(currentlyDisplayedOHLC),
      anchorRangeToVisiblePoints: true,
      opposedPosition: false,
      numberFormat: NumberFormat.simpleCurrency(
        decimalDigits: MediaQuery.of(context).size.width < mobileWidth ? 0 : 2,
      ),
    );
  }
}