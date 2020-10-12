import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkService {
  String url;

  NetworkService({this.url});

  Future<dynamic> getExchangeRate() async {
    String apiUrl = "https://rest.coinapi.io/v1";
    String apiKey = "EAFB846D-9C3A-4722-A508-AECB634F4F8B";
    try {
      Response res = await get('$apiUrl/${this.url}?apikey=$apiKey');

      if (res.statusCode == 200) {
        dynamic data = jsonDecode(res.body);
        return data;
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  void setUrl(String url) {
    this.url = url;
  }
}
