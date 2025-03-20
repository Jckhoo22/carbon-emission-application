import 'package:flutter/material.dart';

import '../../Constant/theme.dart';
import '../../Data/has_value.dart';

// T is like type to accommodate all data type
Widget customDropdown<T extends HasValue>({
  required String labelText,
  required List<T> items,
  required T? value,
  required void Function(T?) onChanged,
  required double width,
  required double height,
}) =>
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            labelText,
            style: label(),
          ), // Text
          SizedBox(
            width: width,
            height: height * 0.06,
            child: DropdownButtonFormField<T>(
              value: value,
              items: items
                  .map(
                    (item) => DropdownMenuItem<T>(
                      value: item,
                      child: Text(item.value),
                    ), // DropdownMenuItem
                  )
                  .toList(),
              onChanged: onChanged,
            ), // DropdownButtonFormField
          ), // SizedBox
        ], // Column
      ), // Expanded
    );
