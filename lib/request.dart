import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as secure;
import 'package:dio/dio.dart' as io;
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'models/Book.dart';
import 'models/Bookmark.dart';
import 'models/Request_Model/AddBuyerRequest.dart';
import 'models/Request_Model/AddExchangeRequest.dart';
import 'models/Request_Model/BookCategoryRequest.dart';
import 'models/Request_Model/BookExchangeNameRequest.dart';
import 'models/Request_Model/BookJson.dart';
import 'models/Request_Model/BookNameRequest.dart';
import 'models/Category.dart';
import 'models/Request_Model/BookPriceRequest.dart';
import 'models/Request_Model/ExchangeBookForAdding.dart';
import 'models/Request_Model/Login.dart';
import 'models/Request_Model/Refresh.dart';
import 'models/Request_Model/UpdateUserRequest.dart';
import 'models/User.dart';

final ipAndPort = "http://79.127.97.99:5000/";

Future<String> signUp(
    String username,
    String password,
    String email,
    String phoneNumber,
    String firstname,
    String lastname,
    String address) async {
  final url = ipAndPort + "User/SignUp";
  final client = io.Dio();
  User signUp = new User(
      username: username,
      password: password,
      email: email,
      phoneNumber: phoneNumber,
      firstname: firstname,
      lastname: lastname);
  String json = jsonEncode(signUp);
  try {
    io.Response response = await client.post(url,
        options: io.Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.userAgentHeader: 'kheft_Book'
          },
          followRedirects: false,
          validateStatus: (status) => false,
        ),
        data: json);
    List<String> lst = List.empty();
    lst.add(response.data!.toString());
    return response.data.toString();
  } on io.DioError catch (error) {
    String data = error.response!.data;
    // List<String> allErrors = data.cast<String>();
    // print(allErrors);
    return data;
  }
}

Future<String?> login(String username, String password) async {
  final url = ipAndPort + "Auth/Login";
  final client = io.Dio();
  Login login = new Login(username, password);
  String json = jsonEncode(login);
  try {
    io.Response response = await client.post(url,
        options: io.Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.userAgentHeader: 'kheft_Book'
          },
          followRedirects: false,
          validateStatus: (status) => false,
        ),
        data: json);
    return response.data.toString();
  } on io.DioError catch (error) {
    return error.response!.data.toString();
  }
}

Future<String?> verifyLogin(String username, int code) async {
  final url = ipAndPort + "Verify/VerifyLogin/$username/$code";
  final client = io.Dio();
  try {
    io.Response response = await client.get(url);
    Map tokens = response.data;
    final storage = new secure.FlutterSecureStorage();
    await storage.write(key: "jwtAccessToken", value: tokens["jwtAccessToken"]);
    await storage.write(key: "refreshToken", value: tokens["refreshToken"]);
    print(tokens["jwtAccessToken"]);
    print(tokens["refreshToken"]);
    return "ok";
  } on io.DioError catch (error) {
    return error.response!.data.toString();
  }
}

Future<String?> verifySignUp(String username, int code) async {
  final url = ipAndPort + "Verify/VerifySignUp/$username/$code";
  final client = io.Dio();
  try {
    io.Response response = await client.get(url);
    return response.data.toString();
  } on io.DioError catch (error) {
    return error.response!.data.toString();
  }
}

Future<String?> resendCodeSignUp(String username) async {
  final url = ipAndPort + "Verify/ResendCodeSignUp/$username";
  final client = io.Dio();
  try {
    io.Response response = await client.get(url);
    return response.data.toString();
  } on io.DioError catch (error) {
    return error.response!.data.toString();
  }
}

Future<String?> resendCodeLogin(String username) async {
  final url = ipAndPort + "Verify/ResendCodeLogin/$username";
  final client = io.Dio();
  try {
    io.Response response = await client.get(url);
    return response.data.toString();
  } on io.DioError catch (error) {
    return error.response!.data.toString();
  }
}

Future<bool> refreshRequest() async {
  final url = ipAndPort + "Refresh";
  final storage = new secure.FlutterSecureStorage();
  final client = io.Dio();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  String? refreshToken = await storage.read(key: "refreshToken");
  Refresh refresh = new Refresh(jwtAccessToken, refreshToken);
  String json = jsonEncode(refresh);
  print(url);
  try {
    io.Response response = await client.post(
      url,
      options: io.Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.userAgentHeader: 'kheft_Book',
        },
      ),
      data: json,
    );
    if (response.statusCode == 200) {
      Map data = response.data;
      if (data["statusCode"] == 200) {
        storage.write(key: "jwtAccessToken", value: data["jwtAccessToken"]);
        storage.write(key: "refreshToken", value: data["refreshToken"]);
        print("new jwt: " + data["jwtAccessToken"]);
        return true;
      } else {
        //print("alireza");
        print(response.data.toString());
        return false;
      }
    } else {
      // print(response.data.toString());
      return false;
    }
  } on io.DioError catch (error) {
    //print(error);
    return false;
  }
}

Future<String?> logout() async {
  final url = ipAndPort + "Auth/logout";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwt = await storage.read(key: "jwtAccessToken");
  try {
    io.Response response = await client.delete(
      url,
      options: io.Options(headers: {
        HttpHeaders.authorizationHeader: 'Bearer $jwt',
        HttpHeaders.userAgentHeader: 'kheft_Book',
      }),
    );
    return response.data.toString();
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        String? data = await logout();
        return "خروج موفق";
      } else {
        return "لطفا مجددا ورود کنید";
      }
    } else {
      return "لطفا مجددا ورود کنید";
    }
  }
}

Future<List<Category>> getCategoriesByParent(int parentId) async {
  final url = ipAndPort + "Category/GetCategoriesByParent/$parentId";
  final client = new io.Dio();
  try {
    io.Response response = await client.get(url);
    List data = response.data;
    List<Category> children =
        data.map((category) => Category.fromJson(category)).toList();
    print(children);
    return children;
  } on io.DioError catch (error) {
    return List<Category>.empty();
  }
}

Future<String> updateBookName(String bookName, int bookId) async {
  final url = ipAndPort + "Book/UpdateBookName";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    BookNameRequest request = new BookNameRequest(bookName, bookId);
    String json = jsonEncode(request);
    io.Response response = await client.put(url,
        options: io.Options(headers: {
          HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.userAgentHeader: 'kheft_Book'
        }),
        data: json);
    return response.data.toString();
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await updateBookName(bookName, bookId);
      } else
        return "لطفا مجددا وارد شوید";
    } else
      return error.response!.data.toString();
  }
}

Future<String> updateBookPrice(int price, int bookId) async {
  final url = ipAndPort + "Book/UpdateBookPrice";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    BookPriceRequest request = new BookPriceRequest(price, bookId);
    String json = jsonEncode(request);
    io.Response response = await client.put(url,
        options: io.Options(headers: {
          HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.userAgentHeader: 'kheft_Book'
        }),
        data: json);
    return response.data.toString();
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await updateBookPrice(price, bookId);
      } else
        return "لطفا مجددا وارد شوید";
    } else
      return error.response!.data.toString();
  }
}

Future<String> updateBookCategory(int categoryId, int bookId) async {
  final url = ipAndPort + "Book/UpdateBookCategory";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    BookCategoryRequest request = new BookCategoryRequest(categoryId, bookId);
    String json = jsonEncode(request);
    io.Response response = await client.put(url,
        options: io.Options(headers: {
          HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.userAgentHeader: 'kheft_Book'
        }),
        data: json);
    return response.data.toString();
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await updateBookCategory(categoryId, bookId);
      } else
        return "لطفا مجددا وارد شوید";
    } else
      return error.response!.data.toString();
  }
}

Future<String> updateBookExchangeName(
    int exchangeId, int bookId, String bookName) async {
  final url = ipAndPort + "Book/UpdateBookExchangeName";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    BookExchangeNameRequest request =
        new BookExchangeNameRequest(exchangeId, bookId, bookName);
    String json = jsonEncode(request);
    io.Response response = await client.put(url,
        options: io.Options(headers: {
          HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.userAgentHeader: 'kheft_Book'
        }),
        data: json);
    return response.data.toString();
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await updateBookExchangeName(exchangeId, bookId, bookName);
      } else
        return "لطفا مجددا وارد شوید";
    } else
      return error.response!.data.toString();
  }
}

Future<String> addExchangeBook(int bookId, String bookName) async {
  final url = ipAndPort + "Book/AddExchangeBook";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    ExchangeBookForAdding exchange = ExchangeBookForAdding(bookName);
    AddExchangeRequest request = new AddExchangeRequest(bookId, exchange);
    String json = jsonEncode(request);
    io.Response response = await client.put(url,
        options: io.Options(headers: {
          HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.userAgentHeader: 'kheft_Book'
        }),
        data: json);
    return response.data.toString();
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await addExchangeBook(bookId, bookName);
      } else
        return "لطفا مجددا وارد شوید";
    } else
      return error.response!.data.toString();
  }
}

Future<String> deleteExchangeBook(int bookId) async {
  final url = ipAndPort + "Book/DeleteExchangeBook/$bookId";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    io.Response response = await client.delete(
      url,
      options: io.Options(headers: {
        HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
        HttpHeaders.userAgentHeader: 'kheft_Book'
      }),
    );
    return response.data.toString();
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await deleteExchangeBook(bookId);
      } else
        return "لطفا مجددا وارد شوید";
    } else
      return error.response!.data.toString();
  }
}

Future<String> deleteBookById(int bookId) async {
  final url = ipAndPort + "Book/DeleteBook/$bookId";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    io.Response response = await client.delete(
      url,
      options: io.Options(headers: {
        HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
        HttpHeaders.userAgentHeader: 'kheft_Book'
      }),
    );
    return response.data.toString();
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await deleteBookById(bookId);
      } else
        return "لطفا مجددا وارد شوید";
    } else
      return error.response!.data.toString();
  }
}

Future<String> bookmarkBookById(int bookId) async {
  final url = ipAndPort + "Book/Bookmark/$bookId";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    io.Response response = await client.put(
      url,
      options: io.Options(headers: {
        HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
        HttpHeaders.userAgentHeader: 'kheft_Book'
      }),
    );
    return response.data.toString();
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await bookmarkBookById(bookId);
      } else
        return "لطفا مجددا وارد شوید";
    } else
      return error.response!.data.toString();
  }
}

Future<String> deleteBookmarkById(int bookmarkId) async {
  final url = ipAndPort + "Book/DeleteBookmark/$bookmarkId";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    io.Response response = await client.delete(
      url,
      options: io.Options(headers: {
        HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
        HttpHeaders.userAgentHeader: 'kheft_Book'
      }),
    );
    return response.data.toString();
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await deleteBookmarkById(bookmarkId);
      } else
        return "لطفا مجددا وارد شوید";
    } else
      return error.response!.data.toString();
  }
}

Future<String> addBuyerToBook(int bookId, String username) async {
  final url = ipAndPort + "Book/AddBuyer";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    AddBuyerRequest request = new AddBuyerRequest(bookId, username);
    String json = jsonEncode(request);
    io.Response response = await client.post(url,
        options: io.Options(headers: {
          HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.userAgentHeader: 'kheft_Book'
        }),
        data: json);
    return response.data.toString();
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await addBuyerToBook(bookId, username);
      } else
        return "لطفا مجددا وارد شوید";
    } else
      return error.response!.data.toString();
  }
}

Future<String> updateUserFirstOrLastName(
    String updateField, String value) async {
  final url = ipAndPort + "User/update";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    UpdateUserRequest request = new UpdateUserRequest(updateField, value);
    String json = jsonEncode(request);
    io.Response response = await client.put(url,
        options: io.Options(headers: {
          HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.userAgentHeader: 'kheft_Book'
        }),
        data: json);
    return response.statusMessage.toString();
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await updateUserFirstOrLastName(updateField, value);
      } else
        return "لطفا مجددا وارد شوید";
    } else
      return error.response!.data.toString();
  }
}

Future<String> deleteProfileImage() async {
  final url = ipAndPort + "File/DeleteProfileImage";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    io.Response response = await client.delete(
      url,
      options: io.Options(headers: {
        HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
        HttpHeaders.userAgentHeader: 'kheft_Book'
      }),
    );
    return response.data.toString();
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await deleteProfileImage();
      } else
        return "لطفا مجددا وارد شوید";
    } else
      return error.response!.data.toString();
  }
}

Future<String> deleteBookImage(int bookId, int imageId) async {
  final url = ipAndPort + "File/DeleteBookImage/$bookId/$imageId";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    io.Response response = await client.delete(
      url,
      options: io.Options(headers: {
        HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
        HttpHeaders.userAgentHeader: 'kheft_Book'
      }),
    );
    return response.data.toString();
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await deleteProfileImage();
      } else
        return "لطفا مجددا وارد شوید";
    } else
      return error.response!.data.toString();
  }
}

Future<List<Book>?> getAllBooksByUserId() async {
  final url = ipAndPort + "Book/GetAllBooksByUserId";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    io.Response response = await client.get(
      url,
      options: io.Options(headers: {
        HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
        HttpHeaders.userAgentHeader: 'kheft_Book'
      }),
    );
    List data = response.data;
    List<Book> books = data.map((book) => Book.fromJson(book)).toList();
    return books;
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await getAllBooksByUserId();
      } else
        return null;
    } else
      return null;
  }
}

Future<List<Book>?> getBoughtBooks() async {
  final url = ipAndPort + "Book/GetBoughtBooks";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    io.Response response = await client.get(
      url,
      options: io.Options(headers: {
        HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
        HttpHeaders.userAgentHeader: 'kheft_Book'
      }),
    );
    List data = response.data;
    List<Book> books = data.map((book) => Book.fromJson(book)).toList();
    return books;
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await getBoughtBooks();
      } else
        return null;
    } else
      return null;
  }
}

Future<List<Book>?> getSoldBooks() async {
  final url = ipAndPort + "Book/GetSoldBooks";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    io.Response response = await client.get(
      url,
      options: io.Options(headers: {
        HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
        HttpHeaders.userAgentHeader: 'kheft_Book'
      }),
    );
    List data = response.data;
    List<Book> books = data.map((book) => Book.fromJson(book)).toList();
    return books;
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await getSoldBooks();
      } else
        return null;
    } else
      return null;
  }
}

/// queryParams example : index=1&min_price=120&max_price=1200&sort=time&status=all
/// status can be all or exchange and default is all and is not neccessary
/// sort can be time or price and default is time and is not nesseccary
/// min_price is not neccessary
/// max_price is not neccessary
/// index shows the index of 3 bookItems! is obligated!
Future<List<Book>?> getAllBooksByCategory(
    int categoryId, String queryParams) async {
  final url = ipAndPort + "Book/GetAllBooksByCategory/$categoryId?$queryParams";
  final client = io.Dio();
  try {
    io.Response response = await client.get(url);
    List data = response.data;
    List<Book> books = data.map((book) => Book.fromJson(book)).toList();
    return books;
  } on io.DioError catch (error) {
    return List<Book>.empty();
  }
}

Future<List<Bookmark>?> getUserBookmarks() async {
  final url = ipAndPort + "Book/GetUserBookmarks";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    io.Response response = await client.get(
      url,
      options: io.Options(headers: {
        HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
        HttpHeaders.userAgentHeader: 'kheft_Book'
      }),
    );
    List data = response.data;
    List<Bookmark> bookmarks =
        data.map((book) => Bookmark.fromJson(book)).toList();
    return bookmarks;
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await getUserBookmarks();
      } else
        return null;
    } else
      return null;
  }
}

Future<Book?> getBookById(int bookId) async {
  final url = ipAndPort + "Book/GetBookById/$bookId";
  final client = io.Dio();
  try {
    io.Response response = await client.get(url);
    Book book = Book.fromJson(response.data);
    return book;
  } on io.DioError catch (error) {
    return null;
  }
}

Future<void> uploadImages(
  List<Asset> resultList,
  String url,
) async {
  // images = resultList;
  // Upload photos one by one when uploading
  for (int i = 0; i < resultList.length; i++) {
    // Get ByteData
    ByteData byteData = await resultList[i].getByteData();
    List<int> imageData = byteData.buffer.asUint8List();

    MultipartFile multipartFile = MultipartFile.fromBytes(
      imageData,
      // file name
      filename: 'some-file-name.jpg',
      // file type
      contentType: MediaType("image", "jpg"),
    );
    FormData formData = FormData.fromMap({
      // Parameter name of the back-end interface
      "files": multipartFile
    });
    // backend interface url
    // String url = ；
    // Other parameters of the back-end interface
    Map<String, dynamic> params = Map();
    // Use dio to upload pictures
    var response =
        await io.Dio().post(url, data: formData, queryParameters: params);
    //
    // do something with response...
  }
}

Future<String> addBook(
    int categoryId,
    String bookName,
    int price,
    String publisherName,
    String writer,
    int publication,
    List<String>? exchanges,
    List<Asset> images) async {
  final url = ipAndPort + "Book/AddBook";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    List<ExchangeBookForAdding> all =
        exchanges!.map((i) => new ExchangeBookForAdding(i)).toList();
    BookJson bookJson = new BookJson(
        categoryId, bookName, price, publisherName, all, publication, writer);
    String json = jsonEncode(bookJson);
    print(json);
    io.FormData formData = new io.FormData();
    formData.fields.add(MapEntry("bookJson", json));

    for (var file in images) {
      ByteData byteData = await file.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      formData.files.add(
        MapEntry(
            "bookImages",
            MultipartFile.fromBytes(
              imageData,
              filename: "iui.jpg",
              contentType: MediaType("image", "jpg"),
            )),
      );
    }
    io.Response response = await client.post(url,
        options: io.Options(headers: {
          HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
          HttpHeaders.contentTypeHeader: "multipart/form-data",
          HttpHeaders.userAgentHeader: 'kheft_Book'
        }),
        data: formData);
    return response.statusMessage.toString();
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await addBook(categoryId, bookName, price, publisherName, writer,
            publication, exchanges, images);
      } else
        return "لطفا مجددا وارد شوید";
    } else
      return error.response!.data.toString();
  }
}

// Future<String> addBook(
//     int categoryId,
//     String bookName,
//     int price,
//     String publisherName,
//     String writer,
//     int publication,
//     List<String>? exchanges,
//     List<Asset> images) async {
//   final url = ipAndPort + "Book/AddBook";
//   final client = io.Dio();
//   final storage = new secure.FlutterSecureStorage();
//   String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
//   try {
//     List<ExchangeBookForAdding> all =
//         exchanges!.map((i) => new ExchangeBookForAdding(i)).toList();
//     BookJson bookJson = new BookJson(
//         categoryId, bookName, price, publisherName, all, publication, writer);
//     String json = jsonEncode(bookJson);
//     print(json);
//     // io.FormData formData = new io.FormData();
//     // for (var file in images) {
//     //   formData.files.addAll([
//     //     MapEntry("bookImages", await MultipartFile.fromFile(file)),
//     //   ]);
//     // }
//     List<MultipartFile> multipartImageList = <MultipartFile>[];

//     images.forEach((image) async {
//       ByteData byteData = await image.getByteData();
//       List<int> imageData = byteData.buffer.asUint8List();
//       MultipartFile bookimage = new MultipartFile.fromBytes(
//         imageData,
//         filename: 'bookImages',
//       );
//       multipartImageList.add(bookimage);
//     });
//     FormData formData = new FormData.fromMap({
//       "bookImages": multipartImageList,
//       "bookJson": json,
//     });

//     // formData.fields.add(MapEntry("bookJson", json));
//     io.Response response = await client.post(url,
//         options: io.Options(headers: {
//           HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
//           HttpHeaders.contentTypeHeader: "multipart/form-data",
//           HttpHeaders.userAgentHeader: 'kheft_Book'
//         }),
//         data: formData);
//     return response.statusMessage.toString();
//   } on io.DioError catch (error) {
//     if (error.response!.statusCode == 401) {
//       bool result = await refreshRequest();
//       if (result == true) {
//         return await addBook(categoryId, bookName, price, publisherName, writer,
//             publication, exchanges, images);
//       } else
//         return "لطفا مجددا وارد شوید";
//     } else
//       return error.response!.data.toString();
//   }
// }

Future<String?> uploadProfileImage(String path) async {
  final url = ipAndPort + "User/UploadProfile";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    io.FormData formData = new io.FormData();
    formData.files.add(MapEntry("profile", await MultipartFile.fromFile(path)));
    io.Response response = await client.put(url,
        options: io.Options(headers: {
          HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
          HttpHeaders.contentTypeHeader: "multipart/form-data",
          HttpHeaders.userAgentHeader: 'kheft_Book'
        }),
        data: formData);
    return response.data.toString();
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await uploadProfileImage(path);
      } else
        return null;
    } else
      return null;
  }
}

Future<User?> getUserProfile() async {
  final url = ipAndPort + "User/GetProfile";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwtAccessToken = await storage.read(key: "jwtAccessToken");
  try {
    io.Response response = await client.get(
      url,
      options: io.Options(headers: {
        HttpHeaders.authorizationHeader: "Bearer $jwtAccessToken",
        HttpHeaders.userAgentHeader: 'kheft_Book'
      }),
    );
    User user = User.fromJson(response.data);
    return user;
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        return await getUserProfile();
      } else
        return null;
    } else
      return null;
  }
}

Future<String?> testReq() async {
  final url = ipAndPort + "Auth/test";
  final client = io.Dio();
  final storage = new secure.FlutterSecureStorage();
  String? jwt = await storage.read(key: "jwtAccessToken");
  try {
    print(jwt);
    io.Response response = await client.get(
      url,
      options: io.Options(headers: {
        HttpHeaders.authorizationHeader: 'Bearer $jwt',
        HttpHeaders.userAgentHeader: 'kheft_Book'
      }),
    );
    print("alireza");
    return response.data.toString();
  } on io.DioError catch (error) {
    if (error.response!.statusCode == 401) {
      bool result = await refreshRequest();
      if (result == true) {
        String? data = await testReq();
        return data;
      } else {
        return "لطفا مجددا ورود کنید";
      }
    } else {
      return error.response!.statusCode.toString();
    }
  }
}
