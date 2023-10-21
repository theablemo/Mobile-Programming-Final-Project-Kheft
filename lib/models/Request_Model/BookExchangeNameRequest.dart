class BookExchangeNameRequest {
  int bookId = 0;
  int exchangeId = 0;
  String bookName = "";

  BookExchangeNameRequest(this.bookId, this.exchangeId, this.bookName);

  Map<String, dynamic> toJson() =>
      {"BookId": bookId, "ExchangeId": exchangeId, "BookName": bookName};
}
