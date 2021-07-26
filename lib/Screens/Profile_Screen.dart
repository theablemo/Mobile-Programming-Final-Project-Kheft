import 'package:flutter/material.dart';
import 'package:kheft/Screens/Bookmarks_Screen.dart';
import 'package:kheft/Widgets/ExplainText.dart';
import 'package:kheft/controller.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: mediaQuery.size.height * 0.1,
            ),
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
                  margin: EdgeInsets.only(
                    left: 20,
                    top: 20,
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          right: 10,
                        ),
                        child: CircleAvatar(
                          backgroundImage: Controller.user.image!.image,
                          minRadius: mediaQuery.size.width * 0.2 / 2,
                        ),
                      ),
                      Container(
                        width: mediaQuery.size.width * 0.7,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Controller.user.firstname,
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                Controller.user.lastname,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: ExplainText(
                      icon: Icons.badge,
                      explanation: Controller.user.username,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: ExplainText(
                      icon: Icons.phone,
                      explanation: Controller.user.phoneNumber,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: ExplainText(
                      icon: Icons.email,
                      explanation: Controller.user.email,
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(
                  //     bottom: 30,
                  //   ),
                  //   child: ExplainText(
                  //     icon: Icons.cake,
                  //     explanation: Controller.user.birthDate.toString(),
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 50,
                    ),
                    child: ExplainText(
                      icon: Icons.password,
                      explanation: Controller.user.password,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(BookmarkScreen.routeAddress);
                      },
                      radius: 10,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.bookmarks_rounded),
                              Text(
                                "Your bookmarks",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 30,
                      right: 10,
                      left: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(Icons.help),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Help")
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(Icons.support_agent),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Support")
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
