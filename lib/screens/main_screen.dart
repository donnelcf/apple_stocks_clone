import 'package:flutter/material.dart';
import 'package:stocks_app_clone/widgets/search_bar.dart';
import 'package:stocks_app_clone/widgets/search_results.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Search',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stocks'),
        ),
        body: Column(
          children: [
            SearchBar(),
            SearchResults(),
          ],
        ),
      ),
    );
  }
}
