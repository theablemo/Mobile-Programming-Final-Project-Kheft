class BookNameRequest {
  String bookName = "";
  int bookId = 0;

  BookNameRequest(this.bookName, this.bookId);

  Map<String, dynamic> toJson() => {"BookName": bookName, "BookId": bookId};
}
