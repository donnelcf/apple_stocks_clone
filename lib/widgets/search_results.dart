import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stocks_app_clone/models/search_quote.dart';
import 'package:stocks_app_clone/state/search_state.dart';

class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<SearchQuote>>(
        future: context.watch<SearchState>().searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState.index == 0){
            return Center(child: Text("Lets find some stocks...", style: TextStyle(color: Colors.white)));
          } else if (snapshot.hasData && snapshot.connectionState.index == 3) {
            return new ListView.builder
              (
                itemCount: snapshot.data.length - 2,
                itemBuilder: (BuildContext context, int index) {
                  SearchQuote quote = snapshot.data[index];
                  return new ListTile(
                    title: Text(quote.symbol, style: TextStyle(color: Colors.white),),
                    subtitle: quote.longName != 'null' ? Text(quote.longName, style: TextStyle(color: Colors.white70)) : quote.shortName != 'null' ? Text(quote.shortName, style: TextStyle(color: Colors.white70)) : Container(),
                    trailing: Text(quote.quoteType + " - " + quote.exchange, style: TextStyle(color: Colors.white)),
                  );
                }
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}", style: TextStyle(color: Colors.white)));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
