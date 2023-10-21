class AddBuyerRequest {
  int bookId;
  String username;

  AddBuyerRequest(this.bookId, this.username);
  Map<String, dynamic> toJson() => {"BookId": bookId, "username": username};
}
