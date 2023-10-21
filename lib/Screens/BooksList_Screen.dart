import 'package:flutter/material.dart';
import 'package:kheft/Widgets/PageTitleText.dart';
// import 'package:kheft/dummy_data.dart';
import 'package:kheft/controller.dart';
import 'package:kheft/dummy_data.dart';
import 'package:kheft/request.dart';

import 'Book_Screen.dart';

class BooksListScreen extends StatefulWidget {
  @override
  _BooksListScreenState createState() => _BooksListScreenState();
}

class _BooksListScreenState extends State<BooksListScreen> {
  var _listScrollController = ScrollController();
  int booksIndex = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listScrollController.addListener(() {
      if (_listScrollController.position.atEdge) {
        if (_listScrollController.position.pixels == 0) {
          // You're at the top.
        } else {
          booksIndex++;
          setState(() {
            getAllBooksByCategory(0, "index=$booksIndex").then((value) {
              if (value!.isNotEmpty) {
                Controller.books.addAll(value);
              } else {
                // booksIndex--;
              }
            });
          });
          // You're at the bottom.
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          Container(
            width: mediaQuery.size.width,
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/logo.png",
              height: mediaQuery.size.width * 0.08,
              alignment: Alignment.center,
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(
              right: 20,
            ),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                child: Icon(
                  Icons.menu,
                  size: 30,
                ),
                alignment: Alignment.topLeft,
                width: mediaQuery.size.width * 0.1,
                margin: EdgeInsets.only(left: 20),
              ),
            ),
          ),
          PageTitleText("All Books"),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            physics: ClampingScrollPhysics(),
            controller: _listScrollController,
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () {
                  getBookById(Controller.books[index].bookId).then((value) {
                    for (int i = 1; i <= value!.imageCount; i++) {
                      Controller.books[index].addImage(
                        Image.network(
                            "http://79.127.97.99:5000/File/DownloadImage/${Controller.books[index].bookId}_$i"),
                      );
                    }
                    Navigator.of(context).pushNamed(
                      BookScreen.routeAddress,
                      arguments: Controller.books[index],
                    );
                  });
                },
                splashColor: Colors.grey,
                radius: 10,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        // CircleAvatar(
                        //   backgroundImage: NetworkImage(
                        //       "https://widgetwhats.com/app/uploads/2019/11/free-profile-photo-whatsapp-3.png"),
                        // ),
                        Container(
                          width: mediaQuery.size.width * 0.25,
                          height: mediaQuery.size.width * 0.25,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(
                                  "http://79.127.97.99:5000/File/DownloadImage/${Controller.books[index].bookId}_1"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Text(
                                          Controller.books[index].bookName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                      ),
                                      if (Controller.books[index].exchangable)
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          alignment: Alignment.topRight,
                                          child: Icon(
                                            Icons.sync_alt,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Icon(Icons.menu),
                                      ),
                                      Text(
                                        Controller.books[index].category == null
                                            ? ""
                                            : Controller.books[index].category!
                                                .categoryName,
                                        style: TextStyle(
                                          fontFamily: "Varela",
                                          fontSize: 12,
                                          color:
                                              Color.fromRGBO(112, 112, 112, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Icon(Icons.people_outline),
                                    ),
                                    Text(
                                      Controller.books[index].user == null
                                          ? ""
                                          : Controller
                                              .books[index].user!.firstname,
                                      style: TextStyle(
                                        fontFamily: "Varela",
                                        fontSize: 12,
                                        color: Color.fromRGBO(112, 112, 112, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, right: 10),
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "${Controller.books[index].price.toString()} \$",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: Controller.books.length,
          )),
        ],
      ),
    );
  }
}
