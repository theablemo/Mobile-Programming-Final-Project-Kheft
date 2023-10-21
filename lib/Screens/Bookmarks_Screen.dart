import 'package:flutter/material.dart';
import 'package:kheft/Widgets/PageTitleText.dart';
import 'package:kheft/controller.dart';

import 'Book_Screen.dart';

class BookmarkScreen extends StatelessWidget {
  static const routeAddress = "/Bookmarks_page";

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
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
              alignment: Alignment.topLeft,
              // margin: EdgeInsets.only(
              //   left: 20,
              // ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  child: Icon(
                    Icons.chevron_left,
                    size: mediaQuery.size.width * 0.11,
                  ),
                  alignment: Alignment.topLeft,
                  width: mediaQuery.size.width * 0.1,
                  margin: EdgeInsets.only(bottom: 10),
                ),
              ),
            ),
            PageTitleText("Your Bookmarks"),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      BookScreen.routeAddress,
                      arguments: Controller.user.bookmarkedBooks[index],
                    );
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
                            width: mediaQuery.size.width * 0.3,
                            height: mediaQuery.size.width * 0.3,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(
                                    "https://widgetwhats.com/app/uploads/2019/11/free-profile-photo-whatsapp-4.png"),
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
                                            Controller
                                                .user
                                                .bookmarkedBooks[index]
                                                .bookName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ),
                                        ),
                                        if (Controller.user
                                            .bookmarkedBooks[index].exchangable)
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            alignment: Alignment.topRight,
                                            child: Icon(
                                              Icons.sync_alt,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
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
                                          Controller.user.bookmarkedBooks[index]
                                                      .category ==
                                                  null
                                              ? ""
                                              : Controller
                                                  .user
                                                  .bookmarkedBooks[index]
                                                  .category!
                                                  .categoryName,
                                          style: TextStyle(
                                            fontFamily: "Varela",
                                            fontSize: 12,
                                            color: Color.fromRGBO(
                                                112, 112, 112, 1),
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
                                        Controller.user.bookmarkedBooks[index]
                                                    .user ==
                                                null
                                            ? ""
                                            : Controller
                                                .user
                                                .bookmarkedBooks[index]
                                                .user!
                                                .username,
                                        style: TextStyle(
                                          fontFamily: "Varela",
                                          fontSize: 12,
                                          color:
                                              Color.fromRGBO(112, 112, 112, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10, right: 10),
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "${Controller.user.bookmarkedBooks[index].price.toString()} \$",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
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
              itemCount: Controller.user.bookmarkedBooks.length,
            )),
          ],
        ),
      ),
    );
  }
}
