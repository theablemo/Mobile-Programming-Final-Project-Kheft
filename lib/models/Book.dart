import 'package:flutter/material.dart';
import 'package:kheft/models/Category.dart';

import 'Exchange.dart';
import 'User.dart';

class Book {
  int bookId = 0; //
  String bookName; //
  String writer; //
  String publisherName;
  int publication; //
  // double originalPrice;
  List<Exchange> exchange = <Exchange>[]; //
  User? user;
  int addedDate;
  Category? category;
  bool exchangable;
  double price;
  // bool isSold;
  List<Image> images = <Image>[];
  int imageCount;
  int views = 0;
  int bookmarks = 0;
  int sellStatus = 0;

  Book({
    required this.bookName,
    required this.writer,
    required this.publisherName,
    required this.publication,
    // required this.originalPrice,
    this.exchange = const <Exchange>[],
    this.user,
    required this.addedDate,
    this.category,
    required this.exchangable,
    required this.price,
    this.imageCount = 0,
    // this.isSold = false,
    this.bookId = 0,
    this.views = 0,
    this.bookmarks = 0,
    this.sellStatus = 0,
  });

  Book.second(
      this.bookId,
      this.bookName,
      this.price,
      this.addedDate,
      this.publisherName,
      this.imageCount,
      this.exchangable,
      this.views,
      this.sellStatus,
      this.bookmarks,
      this.category,
      this.user,
      this.publication,
      this.writer);

  factory Book.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("category") == false)
      return Book(
          bookId: json["bookId"] as int,
          bookName: json["bookName"] as String,
          price: json["price"] as double,
          addedDate: json["addedDate"] as int,
          publisherName: json["publisherName"] as String,
          imageCount: json["imageCount"] as int,
          exchangable: json["exchangable"] as bool,
          views: json["views"] as int,
          sellStatus: json["sellStatus"] as int,
          bookmarks: json["bookmarks"] as int,
          publication: json["publication"] as int,
          writer: json["writer"] as String);
    else {
      Book book = Book.second(
          json["bookId"] as int,
          json["bookName"] as String,
          json["price"] as double,
          json["addedDate"] as int,
          json["publisherName"] as String,
          json["imageCount"] as int,
          json["exchangable"] as bool,
          json["views"] as int,
          json["sellStatus"] as int,
          json["bookmarks"] as int,
          Category.fromJson(json["category"]),
          User.fromJson(json["user"]),
          json["publication"] as int,
          json["writer"] as String);
      if (json.containsKey("exchanges")) {
        var exchangeList = json["exchanges"] as List;
        book.exchange = exchangeList.map((i) => Exchange.fromJson(i)).toList();
      }
      return book;
    }
  }

  void addImage(Image image) {
    this.images.add(image);
  }
}
