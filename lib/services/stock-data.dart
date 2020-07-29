import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stocks_app_clone/models/stock.dart';

Future<Stock> fetchStock() async {
  final response = await http.get(
      'https://query2.finance.yahoo.com/v7/finance/quote?formatted=true&crumb=3f.o6nvzDu8&lang=en-US&region=US&symbols=%5EDJI&fields=messageBoardId%2ClongName%2CshortName%2CmarketCap%2CunderlyingSymbol%2CunderlyingExchangeSymbol%2CheadSymbolAsString%2CregularMarketPrice%2CregularMarketChange%2CregularMarketChangePercent%2CregularMarketVolume%2Cuuid%2CregularMarketOpen%2CfiftyTwoWeekLow%2CfiftyTwoWeekHigh%2CtoCurrency%2CfromCurrency%2CtoExchange%2CfromExchange&corsDomain=finance.yahoo.com');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Stock.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load stock');
  }
}