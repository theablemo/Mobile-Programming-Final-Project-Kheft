import 'package:flutter/material.dart';
import 'package:kheft/Widgets/CustomSubmitButton.dart';
import 'package:kheft/Widgets/CustomTextInput.dart';
import 'package:kheft/Widgets/PageTitleText.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:carousel_slider/carousel_slider.dart';

typedef void OnPickImageCallback(
    double? maxWidth, double? maxHeight, int? quality);

class PublishBookScreen extends StatefulWidget {
  static const routeAddress = "/publish_book_page";

  @override
  _PublishBookScreenState createState() => _PublishBookScreenState();
}

class _PublishBookScreenState extends State<PublishBookScreen> {
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  bool exchange = false;
  bool contactMail = true;
  bool contactPhone = false;
  final titleTextInput = TextEditingController();
  final writerTextInput = TextEditingController();
  final publisherTextInput = TextEditingController();
  final publicationTextInput = TextEditingController();
  final originalPriceTextInput = TextEditingController();
  final priceTextInput = TextEditingController();
  final exchangeBookTitle = TextEditingController();
  final noteTextInput = TextEditingController();
  List<String> exchangeBooks = <String>[];

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
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
            PageTitleText(
              "Publish a book",
            ),
            Expanded(
              child: ListView(
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
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.photo_library_rounded),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 5),
                                            child: Text(
                                              "Add Photos",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                          ),
                                          Text(
                                            "(Max 5)",
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: images.length >= 5
                                            ? null
                                            : () {
                                                loadAssets();
                                              },
                                        icon: Icon(Icons.add),
                                        disabledColor: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                                CarouselSlider(
                                  options: CarouselOptions(
                                    viewportFraction: 0.5,
                                    aspectRatio: 2,
                                    enlargeCenterPage: true,
                                    enableInfiniteScroll: false,
                                  ),
                                  items: images.map((image) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          width: mediaQuery.size.width * 0.5,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: AssetThumb(
                                                    asset: image,
                                                    width:
                                                        (mediaQuery.size.width *
                                                                0.5)
                                                            .toInt(),
                                                    height:
                                                        (mediaQuery.size.width *
                                                                0.5)
                                                            .toInt(),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 0.5),
                                                    ),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          images.remove(image);
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.redAccent,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                )
                              ],
                            ),
                          ),
                        ],
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
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 5,
                              top: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.menu_book),
                                Text(
                                  "Book's info",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Container(),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 20,
                              bottom: 5,
                            ),
                            child: CustomTextInput(
                              textHint: "Title",
                              mediaQuery: mediaQuery,
                              textEditingController: titleTextInput,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: CustomTextInput(
                              textHint: "Writer",
                              mediaQuery: mediaQuery,
                              textEditingController: writerTextInput,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: CustomTextInput(
                              textHint: "Publisher",
                              mediaQuery: mediaQuery,
                              textEditingController: publisherTextInput,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: CustomTextInput(
                              textHint: "Publication",
                              mediaQuery: mediaQuery,
                              textEditingController: publicationTextInput,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: CustomTextInput(
                              textHint: "Original Price",
                              mediaQuery: mediaQuery,
                              textEditingController: originalPriceTextInput,
                              textInputType: TextInputType.number,
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                CustomTextInput(
                                  textHint: "Price",
                                  mediaQuery: mediaQuery,
                                  textEditingController: priceTextInput,
                                  textInputType: TextInputType.number,
                                  widthCoefficient: 0.4,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: exchange,
                                        onChanged: (value) {
                                          setState(() {
                                            exchange = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        "Want to exchange?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (exchange)
                            Container(
                              child: Column(
                                children: [
                                  Divider(
                                    thickness: 2,
                                    indent: mediaQuery.size.width * 0.1,
                                    endIndent: mediaQuery.size.width * 0.1,
                                  ),
                                  Text(
                                    "Enter the book's title",
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: CustomTextInput(
                                        textHint: "title",
                                        mediaQuery: mediaQuery,
                                        textEditingController:
                                            exchangeBookTitle),
                                  ),
                                  // Container(
                                  //   height: 150,
                                  //   child: ListView.builder(
                                  //     itemBuilder: (ctx, index) {
                                  //       return Container();
                                  //     },
                                  //     itemCount: exchangeBooks.length,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                        ],
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
                        margin: EdgeInsets.symmetric(horizontal: 5),
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
                                    "Contact info",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Container(),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("How to contact you",
                                  style: Theme.of(context).textTheme.subtitle2),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        shape: CircleBorder(),
                                        value: contactMail,
                                        onChanged: (value) {
                                          setState(() {
                                            if (value! == false &&
                                                    contactPhone == true ||
                                                value == true) {
                                              contactMail = value;
                                            }
                                          });
                                        }),
                                    Icon(Icons.mail),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        shape: CircleBorder(),
                                        value: contactPhone,
                                        onChanged: (value) {
                                          setState(() {
                                            if (value! == false &&
                                                    contactMail == true ||
                                                value == true) {
                                              contactPhone = value;
                                            }
                                          });
                                        }),
                                    Icon(Icons.phone),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              child: Text("Note",
                                  style: Theme.of(context).textTheme.subtitle2),
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: CustomTextInput(
                                  textHint: "",
                                  mediaQuery: mediaQuery,
                                  textEditingController: noteTextInput),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: mediaQuery.size.width,
              margin: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: CustomSubmitButton(
                      doOnPressed: () {},
                      icon: Icons.publish,
                      text: "Publish",
                      width: null,
                    ),
                    flex: 3,
                  ),
                  Container(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: CustomSubmitButton(
                      doOnPressed: () {
                        Navigator.of(context).pop();
                      },
                      width: null,
                      text: "Discard",
                      backgroundColor: Theme.of(context).errorColor,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
