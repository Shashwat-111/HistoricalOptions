import 'package:fno_view/models/graph_data_calss.dart';
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
  var temp = "".obs; // defined as update button is not working without it (showing incorrect use of getx error)

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
    var response = await RemoteService().getFullData("expiry=$expiry&right1=$right&strike=$strike");
    ohlcDataList.value = response!.ohlcData;
    stockCode.value = response.stockCode;
    expiryDate.value = response.expiryDate;
    strikePrice.value = response.strikePrice;
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