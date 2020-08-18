import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:stocks_app_clone/models/search_quote.dart';
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

Future<List<SearchQuote>> searchStocks(searchString) async {
  final response = await http.get(
      'https://query2.finance.yahoo.com/v1/finance/search?q=' +
          searchString +
          '&lang=en-US&region=US&quotesCount=6&newsCount=4&enableFuzzyQuery=false&quotesQueryId=tss_match_phrase_query&multiQuoteQueryId=multi_quote_single_token_query&newsQueryId=news_cie_vespa&enableCb=true&enableNavLinks=true&enableEnhancedTrivialQuery=true');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return compute(parseQuotes, response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load search');
  }
}

// A function that converts a response body into a List<SearchQuote>.
List<SearchQuote> parseQuotes(String responseBody) {
  final parsed = json.decode(responseBody);
  List<SearchQuote> parsedList = (parsed['quotes'] as List)
      .map((data) => new SearchQuote.fromJson(data))
      .toList();
  return parsedList;
}
