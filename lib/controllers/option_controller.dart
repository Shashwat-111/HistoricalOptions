import 'package:flutter/material.dart';
import 'package:fno_view/models/graph_data_class.dart';
import 'package:fno_view/services/remote_service.dart';
import 'package:get/get.dart';

class OptionDataController extends GetxController {
  var ohlcDataList = <OhlcDatum>[].obs;
  var ohlcDataListOriginal = <OhlcDatum>[].obs;
  var stockCode = "NA".obs; 
  var expiryDate = "NA".obs; 
  var strikePrice = 0000.obs;
  var expiryDates = ["Loading..."].obs;
  var strikePriceList = ["Loading..."].obs;
  var selectedCandleTimeFrame = {"1m",}.obs;
  var selectedRight = {"call",}.obs;
  var temp = "".obs; // defined, as update button is not working without it (showing incorrect use of getx error)
  var isLoading = false.obs;
  var trackballOpen = "".obs;
  var trackballHigh = "".obs;
  var trackballLow = "".obs;
  var trackballClose = "".obs;
  //var trackballVolume = "".obs;
  var trackballColor = const Color(0xfff44336).obs;
  var darkMode = ThemeData(brightness: Brightness.dark).obs;
  var isDarkMode = true.obs;

  var strikepriceapi = "34400".obs;
  var expiryapi = "24-Jun-2021".obs;
  var rightapi = "call".obs;
  var selectedIndicators = List.generate(12, (_) => false).obs;
  @override
  void onInit() {
    getData(expiry: "24-Jun-2021", right: "call", strike: "34400");
    getExpiryData();
    //getStrikePriceData(expiry: "24-Jun-2021", right: "call");
    super.onInit();
  }

  void updateSelectedIndicator(index, bool? isSelected) {
    selectedIndicators[index]= isSelected!;
    //print("update called");
    //print(selectedIndicators);
  }
 void switchDarkMode(bool darkmode){
    if (darkmode == true){
      darkMode.value = ThemeData(brightness: Brightness.dark);
      isDarkMode.value = true;
    }
    if (darkmode == false){
      darkMode.value = ThemeData(brightness: Brightness.light);
      isDarkMode.value =false;
    }
 }
  void updateTrackballPoints (String a, String b, String c, String d, Color e){
    trackballOpen.value = a;
    trackballHigh.value = b;
    trackballLow.value = c;
    trackballClose.value = d;
    trackballColor.value = e;

  }

  void updateCandleTimeFrame (Set<String> a){
  selectedCandleTimeFrame.value = a;
 }

 void updateRight (Set<String> a){
  selectedRight.value = a;
 }

  void getData({required String expiry, required String right, required String strike}) async {
    isLoading.value = true;
    var response = await RemoteService().getFullData("expiry=$expiry&right1=$right&strike=$strike");
    if (response!=null)
      {
        ohlcDataList.value = response.ohlcData;
        ohlcDataListOriginal.value = response.ohlcData;
        stockCode.value = response.stockCode;
        expiryDate.value = response.expiryDate;
        strikePrice.value = response.strikePrice;
      }
    else {
      ohlcDataList.value = <OhlcDatum>[];
      stockCode.value = "N/A";
      expiryDate.value = "N/A";
      strikePrice.value = 0000;
    }
    isLoading.value = false;
  }

  void setExpiry(String expiry){
    expiryapi.value = expiry;
  }

  void setRight(String right){
    rightapi.value = right;
  }

  void setStrikeprice(String strikeprice){
    strikepriceapi.value = strikeprice;
  }

    getExpiryData() async {
    var response = await RemoteService().getExpiryData();
    expiryDates.value = response.map((e) => e.expiryDates).toList().sublist(0,2); //todo remove this sublist when data of all expiry is available
    // Print the expiry data here
  }

    getStrikePriceData({required String expiry, required String right}) async {
    var response = await RemoteService().getStrikePriceList(expiry, right);

    //todo remove this if else statements and the sublist function when backend has rectified its error.
    if(expiry=="29-Jul-2021" && right=="put") {
      strikePriceList.value =
          response.map((e) => e.strikes.toString()).toList().sublist(0, 4);
    }
    else {
      strikePriceList.value =
          response.map((e) => e.strikes.toString()).toList().sublist(0, 5);
    }
  }

  void aggregateOHLC(List<OhlcDatum> ohlcData, int intervalMinutes) {

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

    ohlcDataList.value =result;
  }

  OhlcDatum _aggregateChunk(List<OhlcDatum> chunk) {
    double open = double.parse(chunk.first.open);
    double close = double.parse(chunk.last.close);
    double high = chunk.map((e) => double.parse(e.high)).reduce((a, b) => a > b ? a : b);
    double low = chunk.map((e) => double.parse(e.low)).reduce((a, b) => a < b ? a : b);
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
}