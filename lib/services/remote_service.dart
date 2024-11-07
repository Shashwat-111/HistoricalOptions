import 'package:flutter/cupertino.dart';
import 'package:fno_view/models/expiry_data_class.dart';
import 'package:fno_view/models/graph_data_class.dart';
import 'package:fno_view/models/strikes_list_class.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  //final _baseUrl = 'https://hardy-antonym-424411-h8.el.r.appspot.com/api';
  final _baseUrl = 'https://98ad9677-66cd-48a3-8373-8fd7a8abf20d.mock.pstmn.io';

  // Generic method for GET requests
  Future<http.Response?> _getRequest(String endpoint) async {
    try {
      var uri = Uri.parse('$_baseUrl/$endpoint');
      debugPrint("Request sent to: $_baseUrl/$endpoint");
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        return response;
      } else {
        debugPrint("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error occurred: $e");
    }
    return null;
  }

  Future<OptionsData?> getFullData(String chartDetails) async {
    var response = await _getRequest('fulldata?$chartDetails');
    if (response != null) {
      return optionsDataFromJson(response.body);
    }
    return null;
  }

  Future<List<ExpiryData>> getExpiryData() async {
    var response = await _getRequest('expiries');
    if (response != null) {
      return expiryDataFromJson(response.body);
    }
    return [];
  }

  Future<List<StrikesData>> getStrikePriceList(String expiry, String right) async {
    var response = await _getRequest('strikePriceList?expiry=$expiry&right=$right');
    if (response != null) {
      return strikesDataFromJson(response.body);
    }
    return [];
  }
}
