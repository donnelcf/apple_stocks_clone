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