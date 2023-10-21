import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends StatelessWidget {
  final String textHint;
  final double widthCoefficient;
  final MediaQueryData mediaQuery;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final VoidCallback? onTapFunction;
  final bool readOnlyValue;
  const CustomTextInput({
    required this.textHint,
    required this.mediaQuery,
    required this.textEditingController,
    this.widthCoefficient = 1,
    this.textInputType = TextInputType.text,
    this.onTapFunction,
    this.readOnlyValue = false,
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
          onTap: onTapFunction,
          readOnly: readOnlyValue,
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
