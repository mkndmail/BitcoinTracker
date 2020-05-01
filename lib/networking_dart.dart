import 'package:http/http.dart' as http;

class NetworkHelper {
  String url;

  NetworkHelper({this.url});
  Future<String> getExchangeRate() async {
    var response = await http.get(url);
    print(response.body);
    return response.body;
  }
}
