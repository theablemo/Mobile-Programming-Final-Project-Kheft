class BookPriceRequest {
  int price = 0;
  int bookId = 0;

  BookPriceRequest(this.price, this.bookId);

  Map<String, dynamic> toJson() => {"Price": price, "BookId": bookId};
}
