import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class Stock {
  final String exchange;
  final String shortName;
  final String regularMarketPrice;
  final String regularMarketChange;
  final String fiftyTwoWeekRange;

  Stock(
      {this.exchange,
      this.shortName,
      this.regularMarketPrice,
      this.regularMarketChange,
      this.fiftyTwoWeekRange});

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
        exchange: json['quoteResponse']['result'][0]['exchange'],
        shortName: json['quoteResponse']['result'][0]['shortName'],
        regularMarketPrice: json['quoteResponse']['result'][0]
            ['regularMarketPrice']['fmt'],
        regularMarketChange: json['quoteResponse']['result'][0]
            ['regularMarketChange']['fmt'],
        fiftyTwoWeekRange: json['quoteResponse']['result'][0]
            ['fiftyTwoWeekRange']['fmt']);
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Stock> futureStock;

  @override
  void initState() {
    super.initState();
    futureStock = fetchStock();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Yahoo Finance Data'),
        ),
        body: FutureBuilder<Stock>(
          future: futureStock,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data.shortName +
                          ' (' +
                          snapshot.data.exchange +
                          ')',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      snapshot.data.regularMarketPrice,
                    ),
                    Text(
                      "Change: " + snapshot.data.regularMarketChange,
                      style: TextStyle(
                          color: snapshot.data.regularMarketChange.contains('-')
                              ? Colors.red
                              : Colors.lightGreenAccent),
                    ),
                    Text(
                      "52-Week Change: " + snapshot.data.fiftyTwoWeekRange,
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
