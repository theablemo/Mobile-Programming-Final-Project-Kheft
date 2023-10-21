import 'ExchangeBookForAdding.dart';

class AddExchangeRequest {
  int bookId = 0;
  ExchangeBookForAdding exchange;
  AddExchangeRequest(this.bookId, this.exchange);

  Map<String, dynamic> toJson() => {"BookId": bookId, "exchange": exchange};
}
