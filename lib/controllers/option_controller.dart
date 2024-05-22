import 'package:fno_view/models/graph_data_calss.dart';
import 'package:fno_view/services/remote_service.dart';
import 'package:get/get.dart';

class OptionDataController extends GetxController {
  var ohlcDataList = <OhlcDatum>[].obs;
  var stockCode = "NA".obs; 
  var expiryDate = "NA".obs; 
  var strikePrice = "NA".obs;
  var expiryDates = ["NA"].obs;
  var strikePriceList = ["NA"].obs;
  @override
  void onInit() {
    getData();
    getExpiryData();
    getStrikePriceData();
    super.onInit();
  }


  void getData() async {
    var response = await RemoteService().getFullData("/options/2");
    ohlcDataList.value = response!.ohlcData;
    stockCode.value = response.stockCode;
    expiryDate.value = response.expiryDate;
    strikePrice.value = response.strikePrice;
  }

    getExpiryData() async {
    var response = await RemoteService().getExpiryData();
    expiryDates.value = response.map((e) => e.expiryDates).toList();
    // Print the expiry data here
  }

    getStrikePriceData() async {
    var response = await RemoteService().getStrikePriceList();
    strikePriceList.value = response.map((e) => e.strikes.toString()).toList();
  }
}