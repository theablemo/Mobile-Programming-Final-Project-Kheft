import 'package:flutter/material.dart';

import 'Book.dart';

class User {
  Image? image;
  int? userId = 0;

  String firstname;
  String lastname;
  String username = "";
  String phoneNumber;
  String email;
  String password = "";
  String address = "";
  // DateTime birthDate;
  List<Book> bookmarkedBooks = <Book>[];
  User({
    required this.firstname,
    required this.lastname,
    required this.image,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.password,
    // required this.birthDate,
  });
  User.secondCons(this.userId, this.email, this.phoneNumber, this.firstname,
      this.lastname, this.address);
  Map<String, dynamic> toJson() => {
        "Username": username,
        "Password": password,
        "Email": email,
        "phoneNumber": phoneNumber,
        "Firstname": firstname,
        "Lastname": lastname,
      };
  factory User.fromJson(Map<String, dynamic> json) {
    if (json["address"] != null)
      return User.secondCons(json["userId"], json["email"], json["phoneNumber"],
          json["firstName"], json["lastName"], json["address"]);
    else
      return User.secondCons(json["userId"], json["email"], json["phoneNumber"],
          json["firstName"], json["lastName"], "");
  }
}
