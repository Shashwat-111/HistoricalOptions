import 'dart:ui';

import 'package:fno_view/models/graph_data_class.dart';
import 'package:fno_view/services/remote_service.dart';
import 'package:get/get.dart';

class OptionDataController extends GetxController {
  var ohlcDataList = <OhlcDatum>[].obs;
  var stockCode = "NA".obs; 
  var expiryDate = "NA".obs; 
  var strikePrice = 0000.obs;
  var expiryDates = ["NA"].obs;
  var strikePriceList = ["NA"].obs;
  var chartpart = 1.obs;
  var selectedCandleTimeFrame = {"1m",}.obs;
  var selectedRight = {"call",}.obs;
  var temp = "".obs; // defined, as update button is not working without it (showing incorrect use of getx error)
  var isLoading = false.obs;
  var trackballOpen = "".obs;
  var trackballHigh = "".obs;
  var trackballLow = "".obs;
  var trackballClose = "".obs;
  var trackballColor = const Color(0xfff44336).obs;

  var strikepriceapi = "34400".obs;
  var expiryapi = "24-Jun-2021".obs;
  var rightapi = "call".obs;
  

  @override
  void onInit() {
    getData(expiry: "24-Jun-2021", right: "call", strike: "34400");
    getExpiryData();
    //getStrikePriceData(expiry: "24-Jun-2021", right: "call");
    super.onInit();
  }

  void updatetrackballPoints (String a, String b, String c, String d, Color e){
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

 void updateChartpartNo(){
  if (chartpart<10) {
    chartpart++;
  }
  
 }
 
  void getData({required String expiry, required String right, required String strike}) async {
    isLoading.value = true;
    var response = await RemoteService().getFullData("expiry=$expiry&right1=$right&strike=$strike");
    if (response!=null)
      {
        ohlcDataList.value = response.ohlcData;
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
    expiryDates.value = response.map((e) => e.expiryDates).toList();
    // Print the expiry data here
  }

    getStrikePriceData({required String expiry, required String right}) async {
    var response = await RemoteService().getStrikePriceList(expiry, right);
    strikePriceList.value = response.map((e) => e.strikes.toString()).toList();
  }
}