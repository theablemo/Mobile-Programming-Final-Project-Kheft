import 'package:flutter/material.dart';

class ExplainText extends StatelessWidget {
  final String title;
  final String explanation;
  final IconData? icon;

  const ExplainText({
    this.title = "",
    required this.explanation,
    this.icon = null,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: icon == null
                ? Text(
                    title,
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                : Icon(icon),
          ),
          Text(
            explanation,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Container(),
        ],
      ),
    );
  }
}
