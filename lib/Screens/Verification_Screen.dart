import 'package:flutter/material.dart';
import 'package:kheft/Screens/BottomNav_Screen.dart';
import 'package:kheft/Screens/Signin_Screen.dart';
import 'package:kheft/Widgets/CustomSubmitButton.dart';
import 'package:kheft/Widgets/PageTitleText.dart';
import 'package:kheft/request.dart';
import 'package:kheft/controller.dart';

class VerficationScreen extends StatelessWidget {
  static const routeAddress = "/Verfication_Page";
  final verificationTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final List<String> args =
        ModalRoute.of(context)!.settings.arguments as List<String>;

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
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                height: mediaQuery.size.height * 0.1,
              ),
              CustomSubmitButton(
                doOnPressed: () {
                  showDialog(
                      useSafeArea: true,
                      barrierDismissible: true,
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          content: new Row(
                            children: [
                              CircularProgressIndicator(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              Container(
                                  margin: EdgeInsets.only(left: 7),
                                  child: Text("Loading...")),
                            ],
                          ),
                        );
                      });
                  if (args[1] == "up") {
                    verifySignUp(
                            args[0], int.parse(verificationTextController.text))
                        .then((value) {
                      Navigator.of(context).pop;
                      if (value == "ok") {
                        Navigator.of(context).pushNamed(
                          SignInScreen.routeAddress,
                        );
                      } else {
                        showErrorDialog(context, value!);
                      }
                    });
                  } else {
                    verifyLogin(
                            args[0], int.parse(verificationTextController.text))
                        .then((value) {
                      Navigator.of(context).pop;
                      if (value == "ok") {
                        getUserProfile().then((value) {
                          print(value!.email + value.username);
                          Controller.user = value;
                          getAllBooksByCategory(0, "index=1").then((value) {
                            Controller.books.addAll(value!);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                BottomNavScreen.routeAddress,
                                (Route<dynamic> route) => false);
                          });
                        });
                      } else {
                        showErrorDialog(context, value!);
                      }
                    });
                  }
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
