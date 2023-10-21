import 'package:flutter/material.dart';

class CustomTextInputWithIcon extends StatelessWidget {
  final IconData icon;
  final String textHint;
  final double widthCoefficient;
  final MediaQueryData mediaQuery;
  final TextEditingController textEditingController;
  const CustomTextInputWithIcon({
    required this.icon,
    required this.textHint,
    required this.mediaQuery,
    required this.textEditingController,
    this.widthCoefficient = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);

    return Container(
      height: 30,
      width: mediaQuery.size.width * (widthCoefficient),
      alignment: Alignment.center,
      // margin: margin,
      child: Row(
        children: [
          Container(
            width: mediaQuery.size.width * widthCoefficient * 0.1,
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          SizedBox(
            width: mediaQuery.size.width * widthCoefficient * 0.05,
          ),
          Container(
            height: 30,
            width: mediaQuery.size.width * widthCoefficient * 0.85,
            child: TextField(
              controller: textEditingController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: textHint,
                hintStyle: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
