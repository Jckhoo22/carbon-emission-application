import 'package:flutter/material.dart';

Widget calculateButton({
  required double width,
  required double height,
  required Color btnColor,
  required void Function() onTap,
}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        alignment: Alignment.center,
        width: width,
        height: height * 0.06,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ), // BorderRadius.all
        ),
        // BoxDecoration
        child: const Text(
          "Calculate",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ), // TextStyle
        ), // Text
      ), // Container
    ); // GestureDetector
