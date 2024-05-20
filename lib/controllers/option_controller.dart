import 'package:fno_view/models/graph_data_calss.dart';
import 'package:fno_view/services/remote_service.dart';
import 'package:get/get.dart';

class OptionDataController extends GetxController {
  var ohlcDataList = <OhlcDatum>[].obs;
  var stockCode = "NA".obs; 
  var expiryDate = "NA".obs; 
  var strikePrice = "NA".obs;
  @override
  void onInit() {
    getData();
    super.onInit();
  }


  void getData() async {
    var response = await RemoteService().getData("/options/2");
    ohlcDataList.value = response!.ohlcData;
    stockCode.value = response.stockCode;
    expiryDate.value = response.expiryDate;
    strikePrice.value = response.strikePrice;
  }
}