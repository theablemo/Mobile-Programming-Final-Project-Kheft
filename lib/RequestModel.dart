// import 'package:flutter/scheduler.dart';

// class Refresh {
//   String? jwtAccessToken;
//   String? refreshToken;

//   Refresh(String? access, String? refresh) {
//     this.jwtAccessToken = access;
//     this.refreshToken = refresh;
//   }
//   Map<String, dynamic> toJson() =>
//       {'jwtAccessToken': jwtAccessToken, 'refreshToken': refreshToken};
// }

// class Login {
//   String username = "";
//   String password = "";

//   Login(String username, String password) {
//     this.username = username;
//     this.password = password;
//   }

//   Map<String, dynamic> toJson() => {'Username': username, 'Password': password};
// }

// // class User {
// // int userId = 0;
// // String username = "";
// // String password = "";
// // String email = "";
// // String phoneNumber = "";
// // String firstname = "";
// // String lastname = "";
// // String address = "";
// // User(this.username, this.password, this.email, this.phoneNumber,
// //     this.firstname, this.lastname, this.address);

// // User.secondCons(this.userId, this.email, this.phoneNumber, this.firstname,
// //     this.lastname, this.address);

// // factory User.fromJson(Map<String, dynamic> json) {
// //   if (json["address"] != null)
// //     return User.secondCons(json["userId"], json["email"], json["phoneNumber"],
// //         json["firstName"], json["lastName"], json["address"]);
// //   else
// //     return User.secondCons(json["userId"], json["email"], json["phoneNumber"],
// //         json["firstName"], json["lastName"], "");
// // }

// // Map<String, dynamic> toJson() => {
// //       "Username": username,
// //       "Password": password,
// //       "Email": email,
// //       "phoneNumber": phoneNumber,
// //       "Firstname": firstname,
// //       "Lastname": lastname
// //     };
// // }

// // class Category {
// //   int categoryId = 0;
// //   String categoryName = "";

// //   Category(int id, String name) {
// //     this.categoryId = id;
// //     this.categoryName = name;
// //   }

// //   factory Category.fromJson(Map<String, dynamic> json) {
// //     return Category(json["categoryId"] as int, json["categoryName"] as String);
// //   }
// // }

// class BookNameRequest {
//   String bookName = "";
//   int bookId = 0;

//   BookNameRequest(this.bookName, this.bookId);

//   Map<String, dynamic> toJson() => {"BookName": bookName, "BookId": bookId};
// }

// class BookPriceRequest {
//   int price = 0;
//   int bookId = 0;

//   BookPriceRequest(this.price, this.bookId);

//   Map<String, dynamic> toJson() => {"Price": price, "BookId": bookId};
// }

// class BookCategoryRequest {
//   int categoryId = 0;
//   int bookId = 0;

//   BookCategoryRequest(this.categoryId, this.bookId);

//   Map<String, dynamic> toJson() => {"CategoryId": categoryId, "BookId": bookId};
// }

// class BookExchangeNameRequest {
//   int bookId = 0;
//   int exchangeId = 0;
//   String bookName = "";

//   BookExchangeNameRequest(this.bookId, this.exchangeId, this.bookName);

//   Map<String, dynamic> toJson() =>
//       {"BookId": bookId, "ExchangeId": exchangeId, "BookName": bookName};
// }

// class ExchangeBookForAdding {
//   String exchangeName = "";
//   ExchangeBookForAdding(this.exchangeName);

//   Map<String, dynamic> toJson() => {"BookName": exchangeName};
// }

// class BookJson {
//   int categoryId;
//   String bookName;
//   int price;
//   String publisherName;
//   int publication;
//   String writer;
//   List<ExchangeBookForAdding>? exchanges;

//   BookJson(this.categoryId, this.bookName, this.price, this.publisherName,
//       this.exchanges, this.publication, this.writer);

//   Map<String, dynamic> toJson() => {
//         "CategoryId": categoryId,
//         "BookName": bookName,
//         "Price": price,
//         "PublisherName": publisherName,
//         "Writer": writer,
//         "Publication": publication,
//         "exchanges": exchanges
//       };
// }

// class AddExchangeRequest {
//   int bookId = 0;
//   ExchangeBookForAdding exchange;
//   AddExchangeRequest(this.bookId, this.exchange);

//   Map<String, dynamic> toJson() => {"BookId": bookId, "exchange": exchange};
// }

// class AddBuyerRequest {
//   int bookId;
//   String username;

//   AddBuyerRequest(this.bookId, this.username);
//   Map<String, dynamic> toJson() => {"BookId": bookId, "username": username};
// }

// class UpdateUserRequest {
//   String updateField;
//   String value;

//   UpdateUserRequest(this.updateField, this.value);

//   Map<String, dynamic> toJson() => {"updateField": updateField, "value": value};
// }

// class Exchange {
//   int exchangeId;
//   int bookToExchangeId;
//   String bookName;
//   Exchange(this.exchangeId, this.bookToExchangeId, this.bookName);

//   factory Exchange.fromJson(Map<String, dynamic> json) {
//     return Exchange(
//         json["exchangeId"], json["bookToExchangeId"], json["bookName"]);
//   }
// }

// // class Book {
// //   int bookId;
// //   String bookName;
// //   double price;
// //   int addedDate;
// //   String publisherName;
// //   int imageCount;
// //   bool exchangable;
// //   int views;
// //   int sellStatus;
// //   int bookmarks;
// //   int publication;
// //   String writer;
// //   Category? category;
// //   List<Exchange>? exchange;
// //   User? user;
// //   Book(
// //       this.bookId,
// //       this.bookName,
// //       this.price,
// //       this.addedDate,
// //       this.publisherName,
// //       this.imageCount,
// //       this.exchangable,
// //       this.views,
// //       this.sellStatus,
// //       this.bookmarks,
// //       this.publication,
// //       this.writer);

// //   Book.second(
// //       this.bookId,
// //       this.bookName,
// //       this.price,
// //       this.addedDate,
// //       this.publisherName,
// //       this.imageCount,
// //       this.exchangable,
// //       this.views,
// //       this.sellStatus,
// //       this.bookmarks,
// //       this.category,
// //       this.user,
// //       this.publication,
// //       this.writer);

// //   factory Book.fromJson(Map<String, dynamic> json) {
// //     if (json.containsKey("category") == false)
// //       return Book(
// //           json["bookId"] as int,
// //           json["bookName"] as String,
// //           json["price"] as double,
// //           json["addedDate"] as int,
// //           json["publisherName"] as String,
// //           json["imageCount"] as int,
// //           json["exchangable"] as bool,
// //           json["views"] as int,
// //           json["sellStatus"] as int,
// //           json["bookmarks"] as int,
// //           json["publication"] as int,
// //           json["writer"] as String);
// //     else {
// //       Book book = Book.second(
// //           json["bookId"] as int,
// //           json["bookName"] as String,
// //           json["price"] as double,
// //           json["addedDate"] as int,
// //           json["publisherName"] as String,
// //           json["imageCount"] as int,
// //           json["exchangable"] as bool,
// //           json["views"] as int,
// //           json["sellStatus"] as int,
// //           json["bookmarks"] as int,
// //           Category.fromJson(json["category"]),
// //           User.fromJson(json["user"]),
// //           json["publication"] as int,
// //           json["writer"] as String);
// //       if (json.containsKey("exchanges")) {
// //         var exchangeList = json["exchanges"] as List;
// //         book.exchange = exchangeList.map((i) => Exchange.fromJson(i)).toList();
// //       }
// //       return book;
// //     }
// //   }
// // }

// class Bookmark {
//   int bookmarkId;
//   Book book;
//   Bookmark(this.bookmarkId, this.book);

//   factory Bookmark.fromJson(Map<String, dynamic> json) {
//     return Bookmark(json["bookmarkId"], Book.fromJson(json["book"]));
//   }
// }
