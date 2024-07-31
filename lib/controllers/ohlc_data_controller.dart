import 'package:get/get.dart';
import '../models/graph_data_class.dart';
import '../services/remote_service.dart';

class OhlcDataController extends GetxController {

  //Dropdown selections by user. Initially set to null.
  var selectedStrike = Rxn<String>();
  var selectedExpiry = Rxn<String>();
  var selectedRight = Rxn<String>();

  //we need a different set of variable to display the current chart information
  //as the dropdown values can be temporarily different than currently visible chart.
  //have been set to a default values of chart that is shown initially.
  var currentStrike = "34400".obs;
  var currentExpiry = "24-Jun-2021".obs;
  var currentRight = "call".obs;
  var stockCode = "CNXBAN".obs;

  //Price list to display in strike price dropdown,after
  //fetching it from the backend. Initially set to null
  var strikePriceList = <String>[].obs;

  //the list of OHLC values to plot the chart
  var ohlcDataList = <OhlcDatum>[].obs;

  //a copy of the initial data received from network.
  //this helps in
  var ohlcDataListOriginal = <OhlcDatum>[].obs;

  var isLoading = false.obs;
  var isStrikeLoading = false.obs;
  var expiryDateList = <String>[].obs;

  @override
  void onInit() {
    fetchOhlcDataFromNetwork(expiry: currentExpiry.value, right: currentRight.value, strike: currentStrike.value);
    getExpiryDatesList();
    super.onInit();
  }

  selectExpiry(String expiry){
    selectedExpiry.value = expiry;
  }

  selectRight(String right){
    selectedRight.value = right;
  }

  //fetches strike price list, based on selected expiry and right.
  //todo: remove this if statements and sublist fx when backend has rectified its error.
  //for now it is reducing the the list of strike price to first 4, as only
  //that data is currently available.
  getStrikePriceData({required String expiry, required String right}) async {
    isStrikeLoading.value = true;
    var response = await RemoteService().getStrikePriceList(expiry, right);
    if(expiry=="29-Jul-2021" && right=="put") {
      strikePriceList.value =
          response.map((e) => e.strikes.toString()).toList().sublist(0, 4);
    } else {
      strikePriceList.value =
          response.map((e) => e.strikes.toString()).toList().sublist(0, 5);}
    isStrikeLoading.value = false;
  }

  // after getting all required input from user, this
  // sends a get request to fetch the data from backend
  void fetchOhlcDataFromNetwork({required String expiry, required String right, required String strike}) async {
    isLoading.value = true;
    var response = await RemoteService().getFullData("expiry=$expiry&right1=$right&strike=$strike");
    if (response!=null)
    {
      ohlcDataList.value = response.ohlcData;
      ohlcDataListOriginal.value = response.ohlcData;
      stockCode.value = response.stockCode;
      currentExpiry.value = response.expiryDate;
      currentStrike.value = response.strikePrice.toString();
      currentRight.value = response.right;
    }
    else {
      ohlcDataList.value = <OhlcDatum>[];
      stockCode.value = "N/A";
      currentExpiry.value = "N/A";
      currentStrike.value = "0000";
    }
    isLoading.value = false;
  }

  getExpiryDatesList() async {
    var response = await RemoteService().getExpiryData();
    //todo remove this sublist when data of all expiry is available
    expiryDateList.value = response.map((e) => e.expiryDates).toList().sublist(0,2);
  }

}