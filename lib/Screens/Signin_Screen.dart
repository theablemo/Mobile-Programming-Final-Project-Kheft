import 'package:flutter/material.dart';
import 'package:kheft/Screens/Signup_Screen.dart';
import 'package:kheft/Screens/Verification_Screen.dart';
import 'package:kheft/Widgets/CustomSubmitButton.dart';
import 'package:kheft/Widgets/InputTextWithTitle.dart';

class SignInScreen extends StatelessWidget {
  static const routeAddress = "/Signin_Page";

  final phoneOrEmailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void showErrorDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              "Please Consider filling out all parts.",
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

  void doOnPressedSignIn(BuildContext context) {
    final verify = true;
    if (verify) {
      Navigator.of(context).pushNamed(
        VerficationScreen.routeAddress,
      );
    } else {
      showErrorDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: mediaQuery.size.width * 0.25,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(height: mediaQuery.size.height * 0.2),
                InputTextWithTitle(
                  title: "Enter Your Phone or Email",
                  inputType: TextInputType.emailAddress,
                  textEditingController: phoneOrEmailTextController,
                ),
                SizedBox(height: 25),
                InputTextWithTitle(
                  title: "Enter Your Password",
                  inputType: TextInputType.visiblePassword,
                  textEditingController: passwordTextController,
                ),
                SizedBox(height: mediaQuery.size.height * 0.1),
                CustomSubmitButton(
                  doOnPressed: () => doOnPressedSignIn(context),
                  text: "Signin",
                ),
                SizedBox(height: mediaQuery.size.height * 0.025),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      SignupScreen.routeAddress,
                    );
                  },
                  child: Text(
                    "Signup",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ]),
            ],
          ),
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
