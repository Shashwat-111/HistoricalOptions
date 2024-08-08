import 'package:get/get.dart';
import '../models/graph_data_class.dart';
import '../utils/helper_functions.dart';
import 'ohlc_data_controller.dart';

enum CandleType {
  bar,
  candle,
}

enum CandleTimeFrame {
  oneMinute,
  fiveMinute,
  fifteenMinute,
}

class ChartSettingController extends GetxController {
  var isPanEnabled = true.obs;
  var isPanInYEnabled = true.obs;
  var isZoomEnabled = true.obs;
  var isTooltipEnabled = false.obs;
  var isSelectionZoomingEnabled = false.obs;
  var candleType = CandleType.candle.obs;
  var isCandleTypeSolid = true.obs;
  var selectedCandleTimeFrame = CandleTimeFrame.oneMinute.obs;
  var isAnnotationEnabled = false.obs;


  @override
  void onInit() {
    isPanInYEnabled.value = !HelperFunctions.isMobileView();
    super.onInit();
  }

  switchPanMode(){
    isPanEnabled.value = !isPanEnabled.value;
  }

  switchAnnotation(){
    isAnnotationEnabled.value = !isAnnotationEnabled.value;
  }

  switchYPanMode(){
    isPanInYEnabled.value = !isPanInYEnabled.value;
  }

  switchTooltipMode(){
    isTooltipEnabled.value = !isTooltipEnabled.value;
  }

  switchSelectionZooming(){
    isSelectionZoomingEnabled.value = !isSelectionZoomingEnabled.value;
  }

  switchCandleTypeSolid(){
    isCandleTypeSolid.value = !isCandleTypeSolid.value;
  }

  switchCandleType(){
    if(candleType.value == CandleType.bar){
      candleType.value = CandleType.candle;
    } else {
      candleType.value = CandleType.bar;
    }
  }

  void updateCandleTimeFrame (CandleTimeFrame candleTimeFrame){
    selectedCandleTimeFrame.value = candleTimeFrame;
  }
}


void aggregateOHLC(List<OhlcDatum> ohlcData, int intervalMinutes) {
  OhlcDataController dataController = Get.put(OhlcDataController());
  List<OhlcDatum> result = [];
  ohlcData.sort((a, b) => a.datetime.compareTo(b.datetime));

  DateTime? currentIntervalStart;
  List<OhlcDatum> chunk = [];

  for (var datum in ohlcData) {
    currentIntervalStart ??= datum.datetime;

    if (datum.datetime.difference(currentIntervalStart).inMinutes < intervalMinutes) {
      chunk.add(datum);
    } else {
      result.add(_aggregateChunk(chunk));
      chunk = [datum];
      currentIntervalStart = datum.datetime;
    }
  }

  if (chunk.isNotEmpty) {
    result.add(_aggregateChunk(chunk));
  }

  dataController.ohlcDataList.value =result;
}

OhlcDatum _aggregateChunk(List<OhlcDatum> chunk) {
  double open = double.parse(chunk.first.open);
  double close = double.parse(chunk.last.close);
  double high = chunk.map((e) => double.parse(e.high)).reduce((a, b) =>
  a > b
      ? a
      : b);
  double low = chunk.map((e) => double.parse(e.low)).reduce((a, b) =>
  a < b
      ? a
      : b);
  int volume = chunk.map((e) => e.volume).reduce((a, b) => a + b);
  int openInterest = chunk.last.openInterest;

  return OhlcDatum(
    open: open.toString(),
    high: high.toString(),
    low: low.toString(),
    close: close.toString(),
    count: chunk.length,
    datetime: chunk.first.datetime,
    openInterest: openInterest,
    volume: volume,
  );
}