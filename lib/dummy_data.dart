import 'package:flutter/material.dart';
import 'package:kheft/models/Book.dart';
import 'package:kheft/models/User.dart';

import 'package:kheft/models/Category.dart';

import 'models/Exchange.dart';

final books = [
  Book(
    exchangable: true,
    price: 10,
    category: new Category(
      categoryName: "novel",
      books: ["ij"],
    ),
    bookName: "avvali",
    writer: "mammad",
    publisherName: "akbar",
    publication: 1234,
    // originalPrice: 100,
    exchange: [],
    user: User(
        firstname: "hossein",
        lastname: "jigari",
        // birthDate: DateTime.now(),
        email: "dfasdf",
        username: "asdf",
        image: Image.network(
            "https://widgetwhats.com/app/uploads/2019/11/free-profile-photo-whatsapp-4.png"),
        password: "1234",
        phoneNumber: "asdf"),
    addedDate: 23412,
  ),
  Book(
    exchangable: false,
    price: 200,
    bookName: "dovvomo",
    writer: "asdf",
    publisherName: "ggads",
    publication: 234,
    // originalPrice: 1030,
    exchange: [Exchange(1, 3, "dfasd")],
    user: User(
        firstname: "akbar",
        lastname: "salehi",
        // birthDate: DateTime.now(),
        email: "dfasdf",
        username: "asdf",
        image: Image.network(
            "https://widgetwhats.com/app/uploads/2019/11/free-profile-photo-whatsapp-3.png"),
        password: "4444",
        phoneNumber: "22assd"),
    addedDate: 1245,
    category: new Category(
      categoryName: "Science",
      books: ["ok"],
    ),
  ),
  Book(
    exchangable: true,
    price: 200,
    bookName: "dovvomo",
    writer: "asdf",
    publisherName: "ggads",
    publication: 1234,
    // originalPrice: 1030,
    exchange: [Exchange(1, 3, "dfasd")],
    user: User(
        firstname: "mammad",
        lastname: "abolnejad",
        // birthDate: DateTime.now(),
        email: "dfasdf",
        username: "asdf",
        image: Image.network(
            "https://widgetwhats.com/app/uploads/2019/11/free-profile-photo-whatsapp-3.png"),
        password: "4444",
        phoneNumber: "22assd"),
    addedDate: 1234,
    category: new Category(
      categoryName: "Science",
      books: ["ok"],
    ),
  ),
];
