import 'package:flutter/material.dart';

class InputTextWithTitle extends StatelessWidget {
  final textEditingController;
  final String title;
  final TextInputType inputType;

  InputTextWithTitle({
    required this.title,
    required this.inputType,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(bottom: 10, left: 18, right: 18),
        child: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.start,
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        height: 35,
        child: TextField(
          autofocus: false,
          keyboardType: inputType,
          controller: textEditingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
    ]);
  }
}
