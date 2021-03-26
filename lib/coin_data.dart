import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '';

class CoinData {
  Map<String, dynamic> coinData;

  Future<void> getCoinData() async {
    http.Response btcData = await http.get('$coinAPIURL/BTC?apikey=$apiKey');

    http.Response ethData = await http.get('$coinAPIURL/ETH?apikey=$apiKey');

    http.Response ltcData = await http.get('$coinAPIURL/LTC?apikey=$apiKey');

    print(ltcData.headers);

    coinData = {
      "BTC": jsonDecode(btcData.body),
      "ETH": jsonDecode(ethData.body),
      "LTC": jsonDecode(ltcData.body)
    };
  }

  double getRateByCrypto(String cryptoCurrency, String currency) {
    if (coinData != null) {
      for (dynamic rate in coinData[cryptoCurrency]['rates']) {
        if (rate['asset_id_quote'] == currency) {
          return rate['rate'];
        }
      }
    }
    return 0.0;
  }
}
