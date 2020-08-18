import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stocks_app_clone/widgets/search_bar.dart';
import 'package:stocks_app_clone/widgets/search_results.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  String _getDate() {
    final now = new DateTime.now();
    String formatter = DateFormat.MMMMd('en_US').format(now);
    return formatter;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Search',
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.black
      ),
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0, left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Stocks", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),),
                      Text(_getDate(), style: TextStyle(color: Colors.white70, fontSize: 22, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                SearchBar(),
                SearchResults(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
