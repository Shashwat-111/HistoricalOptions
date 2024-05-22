import 'package:fno_view/models/expiry_data_class.dart';
import 'package:fno_view/models/graph_data_calss.dart';
import 'package:fno_view/models/strikes_list_class.dart';
import 'package:http/http.dart' as http;


class RemoteService {


  Future<OptionsData?> getFullData(String chartNumber ) async {
    var client = http.Client();
    var uri = Uri.parse('https://98ad9677-66cd-48a3-8373-8fd7a8abf20d.mock.pstmn.io$chartNumber');
    var response = await client.get(uri);
    //print(response.body);
    if(response.statusCode == 200)
    {
      var json = response.body;
      return optionsDataFromJson(json);
    }
    return null;
  }

  Future<List<ExpiryData>> getExpiryData() async {
    var client = http.Client();
    var uri = Uri.parse('https://98ad9677-66cd-48a3-8373-8fd7a8abf20d.mock.pstmn.io/stkcode');
    var response2 = await client.get(uri);
    if(response2.statusCode == 200)
    {
      var json2 = response2.body;
      return expiryDataFromJson(json2);
    }
    return [];
  }

  Future<List<StrikesData>> getStrikePriceList () async {
      var client = http.Client();
      var uri = Uri.parse('https://98ad9677-66cd-48a3-8373-8fd7a8abf20d.mock.pstmn.io/strikePriceList');
      var response3 = await client.get(uri);
      if(response3.statusCode == 200)
    {
      var json2 = response3.body;
      return strikesDataFromJson(json2);
    }
    return [];
  }
  }