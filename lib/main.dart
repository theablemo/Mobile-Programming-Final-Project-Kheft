import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kheft/Screens/Book_Screen.dart';
import 'package:kheft/Screens/Bookmarks_Screen.dart';
import 'package:kheft/Screens/BottomNav_Screen.dart';
import 'package:kheft/Screens/PublishBook_Screen.dart';
import 'package:kheft/Screens/Signin_Screen.dart';
import 'package:kheft/Screens/Signup_Screen.dart';
import 'package:kheft/Screens/Verification_Screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color.fromRGBO(251, 251, 251, 1),
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var signedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(33, 192, 245, 1),
        buttonColor: Color.fromRGBO(161, 232, 240, 1),
        canvasColor: Color.fromRGBO(251, 251, 251, 1),
        accentColor: Color.fromRGBO(119, 119, 119, 1),
        hintColor: Color.fromRGBO(177, 177, 177, 1),
        cardColor: Color.fromRGBO(226, 226, 226, 1),
        errorColor: Colors.redAccent[100],
        textTheme: ThemeData.light().textTheme.copyWith(
            subtitle2: TextStyle(
              fontFamily: "Varela",
              fontSize: 16,
              color: Color.fromRGBO(112, 112, 112, 1),
            ),
            subtitle1: TextStyle(
              fontFamily: "Varela",
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(112, 112, 112, 1),
            ),
            button: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              decorationColor: Colors.grey,
            ),
            headline1: TextStyle(
              fontFamily: "Varela",
              fontSize: 30,
              color: Color.fromRGBO(119, 119, 119, 1),
            ),
            bodyText1: TextStyle(
              fontFamily: "Varela",
              fontSize: 20,
              color: Color.fromRGBO(119, 119, 119, 1),
            ),
            caption: TextStyle(color: Color.fromRGBO(177, 177, 177, 1)),
            overline: TextStyle(
              fontFamily: "Varela",
              fontSize: 10,
              color: Color.fromRGBO(119, 119, 119, 1),
            )),
      ),
      home: !signedIn ? SignInScreen() : SignupScreen(),
      routes: {
        SignInScreen.routeAddress: (ctx) => SignInScreen(),
        SignupScreen.routeAddress: (ctx) => SignupScreen(),
        VerficationScreen.routeAddress: (ctx) => VerficationScreen(),
        BottomNavScreen.routeAddress: (ctx) => BottomNavScreen(),
        PublishBookScreen.routeAddress: (ctx) => PublishBookScreen(),
        BookScreen.routeAddress: (ctx) => BookScreen(),
        BookmarkScreen.routeAddress: (ctx) => BookmarkScreen(),
      },
    );
  }
}
