import 'package:flutter/material.dart';
import 'package:kheft/Screens/BottomNav_Screen.dart';
import 'package:kheft/Widgets/CustomSubmitButton.dart';
import 'package:kheft/Widgets/PageTitleText.dart';

class VerficationScreen extends StatelessWidget {
  static const routeAddress = "/Verfication_Page";

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final verificationTextController = TextEditingController();

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      child: Icon(
                        Icons.chevron_left,
                        size: 50,
                      ),
                      alignment: Alignment.topLeft,
                      width: mediaQuery.size.width * 0.1,
                      margin: EdgeInsets.only(left: 20),
                    ),
                  ),
                  Container(
                    width: mediaQuery.size.width * 0.8,
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: mediaQuery.size.width * 0.15,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              PageTitleText("Verification"),
              SizedBox(
                height: mediaQuery.size.height * 0.2,
              ),
              Text(
                "Enter the code that has been sent to your email!",
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: mediaQuery.size.height * 0.1,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: mediaQuery.size.width * 0.1),
                child: TextField(
                  controller: verificationTextController,
                ),
              ),
              SizedBox(
                height: mediaQuery.size.height * 0.1,
              ),
              CustomSubmitButton(
                doOnPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      BottomNavScreen.routeAddress,
                      (Route<dynamic> route) => false);
                },
                text: "Verify",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
