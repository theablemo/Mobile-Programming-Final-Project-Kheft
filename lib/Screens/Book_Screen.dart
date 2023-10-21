import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kheft/Widgets/CustomSubmitButton.dart';
import 'package:kheft/Widgets/ExplainText.dart';
import 'package:kheft/Widgets/PageTitleText.dart';
import 'package:kheft/controller.dart';
import 'package:kheft/models/Book.dart';
import 'package:intl/intl.dart';

class BookScreen extends StatefulWidget {
  static const routeAddress = "/book_page";

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    Book book = ModalRoute.of(context)!.settings.arguments as Book;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    size: mediaQuery.size.width * 0.1,
                  ),
                ),
                Column(
                  children: [
                    PageTitleText(book.bookName),
                    Text(
                      book.price.toString(),
                      style: Theme.of(context).textTheme.overline,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (Controller.user.bookmarkedBooks.contains(book)) {
                        Controller.user.bookmarkedBooks.remove(book);
                      } else {
                        Controller.user.bookmarkedBooks.add(book);
                      }
                    });
                  },
                  icon: Controller.user.bookmarkedBooks.contains(book)
                      ? Icon(
                          Icons.bookmark,
                        )
                      : Icon(
                          Icons.bookmark_border_outlined,
                        ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2.5,
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 0.5,
                            aspectRatio: 2,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                          ),
                          items: book.images.map((image) {
                            return Builder(
                              builder: (ctx) {
                                return Container(
                                  width: mediaQuery.size.width * 0.5,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Image(
                                      image: image.image,
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2.5,
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.menu_book),
                                    Text(
                                      "Book info",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Container(),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    ExplainText(
                                      title: "Title:",
                                      explanation: book.bookName,
                                    ),
                                    ExplainText(
                                      title: "Writer:",
                                      explanation: book.writer,
                                    ),
                                    ExplainText(
                                      title: "Publisher:",
                                      explanation: book.publisherName,
                                    ),
                                    ExplainText(
                                        title: "Publication:",
                                        explanation:
                                            book.publication.toString()),
                                    ExplainText(
                                      title: "Price:",
                                      explanation: book.price.toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (book.exchangable && book.exchange!.isNotEmpty)
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2.5,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.sync_alt),
                                      Text(
                                        "ExchangeBook",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      Container(),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    book.exchange!.isEmpty
                                        ? ""
                                        : book.exchange![0].bookName,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2.5,
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.person),
                                    Text(
                                      "Post info",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Container(),
                                  ],
                                ),
                              ),
                              ExplainText(
                                title: "Publisher:",
                                explanation: book.user == null
                                    ? ""
                                    : book.user!.firstname +
                                        " " +
                                        book.user!.firstname,
                              ),
                              ExplainText(
                                title: "Published Date:",
                                explanation: DateFormat.yMMMd().format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        book.addedDate * 1000)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: mediaQuery.size.width,
              margin: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: CustomSubmitButton(
                      doOnPressed: () {},
                      icon: Icons.phone,
                      text: book.user == null
                          ? ""
                          : "Contact ${book.user!.firstname}",
                      width: null,
                    ),
                  ),
                ],
              ),
            ),

            ///

            /////
          ],
        ),
      ),
    );
  }
}
