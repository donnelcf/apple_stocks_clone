class SearchQuote {
  final String exchange;
  final String shortName;
  final String quoteType;
  final String symbol;
  final String index;
  final String score;
  final String typeDisp;
  final String longName;

  SearchQuote(
      {this.exchange,
      this.shortName,
      this.quoteType,
      this.symbol,
      this.index,
      this.score,
      this.typeDisp,
      this.longName});

  factory SearchQuote.fromJson(Map<String, dynamic> json) {
    return SearchQuote(
        exchange: json['exchange'].toString(),
        shortName: json['shortname'].toString(),
        quoteType: json['quoteType'].toString(),
        symbol: json['symbol'].toString(),
        index: json['index'].toString(),
        score: json['score'].toString(),
        typeDisp: json['typeDisp'].toString(),
        longName: json['longname'].toString());
  }
}
