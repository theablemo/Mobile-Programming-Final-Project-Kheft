import 'Book.dart';

class Category {
  int categoryId = 0;
  List<String> books = <String>[];
  String categoryName;

  Category({
    this.books = const <String>[],
    required this.categoryName,
    this.categoryId = 0,
  });
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        categoryId: json["categoryId"] as int,
        categoryName: json["categoryName"] as String);
  }
}
