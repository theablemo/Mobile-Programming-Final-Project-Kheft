class BookCategoryRequest {
  int categoryId = 0;
  int bookId = 0;

  BookCategoryRequest(this.categoryId, this.bookId);

  Map<String, dynamic> toJson() => {"CategoryId": categoryId, "BookId": bookId};
}
