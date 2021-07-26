import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  final VoidCallback doOnPressed;
  final String text;
  final Color backgroundColor;
  final IconData? icon;
  final double? width;

  CustomSubmitButton({
    required this.doOnPressed,
    required this.text,
    this.backgroundColor = const Color.fromRGBO(161, 232, 240, 1),
    this.icon = null,
    this.width = 90,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: doOnPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: Colors.black,
            ),
          Container(
            alignment: Alignment.center,
            width: width,
            child: Text(
              text,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
          ),
          Container(),
        ],
      ),
      style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          side: BorderSide(
            style: BorderStyle.solid,
            color: Colors.grey,
          )),
    );
  }
}
