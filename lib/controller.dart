import 'package:flutter/material.dart';

import 'models/Book.dart';
import 'models/User.dart';

class Controller {
  static final Controller _singleton = Controller._internal();

  factory Controller() {
    return _singleton;
  }

  static User user = User(
    firstname: "hossein",
    lastname: "jigari",
    // birthDate: DateTime.now(),
    email: "dfasdf",
    username: "asdf",
    // image: Image.network(
    //     "https://widgetwhats.com/app/uploads/2019/11/free-profile-photo-whatsapp-4.png"),
    password: "1234",
    phoneNumber: "asdf",
  );

  static List<Book> books = <Book>[];

  Controller._internal();
}

void showErrorDialog(BuildContext context, String text) {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Ok",
                  style: Theme.of(context).textTheme.button,
                ))
          ],
        );
      });
}
