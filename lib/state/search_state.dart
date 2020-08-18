import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stocks_app_clone/models/search_quote.dart';
import 'package:stocks_app_clone/services/stock_data.dart';

class SearchState with ChangeNotifier, DiagnosticableTreeMixin {
  Future<List<SearchQuote>> _searchResults;
  Future<List<SearchQuote>> get searchResults => _searchResults;

  void search(String searchString) {
    _searchResults = searchStocks(searchString);
    notifyListeners();
  }

  void clear() {
    _searchResults = null;
    notifyListeners();
  }

  /// Makes `SearchResults` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('searchResults', searchResults));
  }
}
