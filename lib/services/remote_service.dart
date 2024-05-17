import 'package:fno_view/models/graph_data_calss.dart';
import 'package:http/http.dart' as http;


class RemoteService {
  Future<OptionsData?> getData(String A ) async {
    var client = http.Client();
    var uri = Uri.parse('https://98ad9677-66cd-48a3-8373-8fd7a8abf20d.mock.pstmn.io$A');
    var response = await client.get(uri);
    //print(response.body);
    if(response.statusCode == 200)
    {
      var json = response.body;
      return optionsDataFromJson(json);
    }
    return null;
  }
  }