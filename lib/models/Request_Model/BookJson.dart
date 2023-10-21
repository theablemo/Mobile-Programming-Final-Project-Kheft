import 'ExchangeBookForAdding.dart';

class BookJson {
  int categoryId;
  String bookName;
  int price;
  String publisherName;
  int publication;
  String writer;
  List<ExchangeBookForAdding>? exchanges;

  BookJson(this.categoryId, this.bookName, this.price, this.publisherName,
      this.exchanges, this.publication, this.writer);

  Map<String, dynamic> toJson() => {
        "CategoryId": categoryId,
        "BookName": bookName,
        "Price": price,
        "PublisherName": publisherName,
        "Writer": writer,
        "Publication": publication,
        "exchanges": exchanges
      };
}
