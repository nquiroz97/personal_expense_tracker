import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  final String text;
  final Function helperFunction;
  const AdaptiveButton(
      {Key? key, required this.helperFunction, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () => helperFunction)
        : TextButton(
            onPressed: () => helperFunction,
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ));
  }
}
