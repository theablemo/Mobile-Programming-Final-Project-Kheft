import 'package:flutter/material.dart';

class PageTitleText extends StatelessWidget {
  final String title;
  PageTitleText(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
      ),
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
