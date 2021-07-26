import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends StatelessWidget {
  final String textHint;
  final double widthCoefficient;
  final MediaQueryData mediaQuery;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  const CustomTextInput({
    required this.textHint,
    required this.mediaQuery,
    required this.textEditingController,
    this.widthCoefficient = 1,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);

    return Container(
      height: 30,
      width: mediaQuery.size.width * (widthCoefficient),
      alignment: Alignment.center,
      // margin: margin,
      child: Container(
        height: 30,
        width: mediaQuery.size.width * widthCoefficient * 0.85,
        child: TextField(
          keyboardType: textInputType,
          controller: textEditingController,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: textHint,
            hintStyle: Theme.of(context).textTheme.caption,
          ),
        ),
      ),
    );
  }
}
