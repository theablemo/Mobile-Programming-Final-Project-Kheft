class ExchangeBookForAdding {
  String exchangeName = "";
  ExchangeBookForAdding(this.exchangeName);

  Map<String, dynamic> toJson() => {"BookName": exchangeName};
}
