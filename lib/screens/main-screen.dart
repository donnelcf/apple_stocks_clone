import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stocks_app_clone/models/stock.dart';
import 'package:stocks_app_clone/services/stock-data.dart';


class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
                              : Colors.green),
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
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}