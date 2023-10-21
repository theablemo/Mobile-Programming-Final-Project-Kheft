import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kheft/Screens/Verification_Screen.dart';
import 'package:kheft/Widgets/CustomSubmitButton.dart';
import 'package:kheft/Widgets/CustomTextInputWithIcon.dart';
import 'package:kheft/Widgets/PageTitleText.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:kheft/request.dart';

class SignupScreen extends StatefulWidget {
  static const routeAddress = "/Signup_Page";

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final usernameTextController = TextEditingController();

  final passwordTextController = TextEditingController();

  final firstNameTextController = TextEditingController();

  final lastNameTextController = TextEditingController();

  final birthDateTextController = TextEditingController();

  final emailTextController = TextEditingController();

  final phoneNumberTextController = TextEditingController();
  DateTime? selectedDate;

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

  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        // selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if (resultList.isNotEmpty) {
        images = resultList;
      }
      _error = error;
    });
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
              Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/logo.png",
                  height: mediaQuery.size.width * 0.15,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: mediaQuery.size.height * 0.05,
              ),
              PageTitleText("Signup"),
              SizedBox(
                height: 10,
              ),
              // images.isEmpty
              //     ? ElevatedButton(
              //         onPressed: loadAssets,
              //         child: Text("Select Image"),
              //         style: ElevatedButton.styleFrom(
              //             primary: Color.fromRGBO(161, 232, 240, 1),
              //             side: BorderSide(
              //               style: BorderStyle.solid,
              //               color: Colors.grey,
              //             )),
              //       )
              //     : InkWell(
              //         onTap: loadAssets,
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(10),
              //           child: AssetThumb(
              //             asset: images[0],
              //             width: (mediaQuery.size.width * 0.4).toInt(),
              //             height: (mediaQuery.size.width * 0.4).toInt(),
              //           ),
              //         ),
              //       ),
              SizedBox(
                height: mediaQuery.size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 30,
                ),
                child: CustomTextInputWithIcon(
                  icon: Icons.badge,
                  textHint: "Username",
                  mediaQuery: mediaQuery,
                  textEditingController: usernameTextController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 30,
                ),
                child: CustomTextInputWithIcon(
                  icon: Icons.password,
                  textHint: "Password",
                  mediaQuery: mediaQuery,
                  textEditingController: passwordTextController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextInputWithIcon(
                      icon: Icons.person,
                      textHint: "First Name",
                      widthCoefficient: 0.35,
                      mediaQuery: mediaQuery,
                      textEditingController: firstNameTextController,
                    ),
                    SizedBox(
                      width: mediaQuery.size.width * 0.05,
                    ),
                    CustomTextInputWithIcon(
                      icon: Icons.person,
                      textHint: "Last Name",
                      widthCoefficient: 0.35,
                      mediaQuery: mediaQuery,
                      textEditingController: lastNameTextController,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 30,
                ),
                child: Container(
                  height: 30,
                  width: mediaQuery.size.width * (0.8),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Container(
                        width: mediaQuery.size.width * 0.8 * 0.1,
                        child: Icon(
                          Icons.cake,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      SizedBox(
                        width: mediaQuery.size.width * 0.8 * 0.05,
                      ),
                      Container(
                        height: 30,
                        width: mediaQuery.size.width * 0.8 * 0.85,
                        child: TextField(
                          controller: birthDateTextController,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                selectedDate = value;
                              });
                            });
                          },
                          readOnly: true,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: selectedDate == null
                                ? "Birth Date"
                                : DateFormat.yMMMd().format(selectedDate!),
                            hintStyle: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 30,
                ),
                child: CustomTextInputWithIcon(
                  icon: Icons.email,
                  textHint: "Email",
                  mediaQuery: mediaQuery,
                  textEditingController: emailTextController,
                ),
              ),
              CustomTextInputWithIcon(
                icon: Icons.phone,
                textHint: "Phone Number",
                mediaQuery: mediaQuery,
                textEditingController: phoneNumberTextController,
              ),
              SizedBox(
                height: 50,
              ),
              CustomSubmitButton(
                doOnPressed: () {
                  if (usernameTextController.text.isEmpty ||
                      passwordTextController.text.isEmpty ||
                      firstNameTextController.text.isEmpty ||
                      lastNameTextController.text.isEmpty ||
                      selectedDate == null ||
                      emailTextController.text.isEmpty ||
                      phoneNumberTextController.text.isEmpty) {
                    showErrorDialog(
                        context, "Please Consider filling out all parts.");
                  } else {
                    showDialog(
                        useSafeArea: true,
                        barrierDismissible: true,
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            content: new Row(
                              children: [
                                CircularProgressIndicator(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                Container(
                                    margin: EdgeInsets.only(left: 7),
                                    child: Text("Loading...")),
                              ],
                            ),
                          );
                        });
                    signUp(
                            usernameTextController.text,
                            passwordTextController.text,
                            emailTextController.text,
                            phoneNumberTextController.text,
                            firstNameTextController.text,
                            lastNameTextController.text,
                            "")
                        .then((value) {
                      print("oomadim inja");
                      Navigator.of(context).pop();
                      if (value == "ok") {
                        Navigator.of(context).pushNamed(
                            VerficationScreen.routeAddress,
                            arguments: [usernameTextController.text, "up"]);
                      } else {
                        showErrorDialog(context, value);
                      }
                    });
                  }
                },
                text: "Signup",
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Discard",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontFamily: "Varela",
                  ),
                ),
              ),
            ],
          ),
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
