import 'package:bitcoin_ticker/services/network.dart';
import 'package:bitcoin_ticker/utils/coin_data.dart';

class RatesService {
  List rates = [];

  Future<List<dynamic>> getRates(String currency) async {
    NetworkService client = NetworkService();
    for (String cc in cryptoList) {
      client.setUrl('exchangerate/$cc/$currency');
      dynamic data = await client.getExchangeRate();
      rates.add({"key": cc, "rate": data['rate'].toStringAsFixed(2)});
    }

    return rates;
  }
}
