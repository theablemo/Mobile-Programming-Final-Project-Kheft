import 'Book.dart';

class Bookmark {
  int bookmarkId;
  Book book;
  Bookmark(this.bookmarkId, this.book);

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(json["bookmarkId"], Book.fromJson(json["book"]));
  }
}
