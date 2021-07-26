class Exchange {
  int exchangeId;
  int bookToExchangeId;
  String bookName;
  Exchange(this.exchangeId, this.bookToExchangeId, this.bookName);

  factory Exchange.fromJson(Map<String, dynamic> json) {
    return Exchange(
        json["exchangeId"], json["bookToExchangeId"], json["bookName"]);
  }
}
