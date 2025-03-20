import 'package:flutter/material.dart';

import '../../Constant/theme.dart';

Widget emissionCardSkeleton({
  required double height,
  required double width,
}) =>
    Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ), // BorderRadius.all
      ),
      // BoxDecoration
      height: height * 0.32,
      width: width,
      child: const CircularProgressIndicator(),
    ); // Container
