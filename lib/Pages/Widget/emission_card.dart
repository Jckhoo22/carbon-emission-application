import 'package:flutter/material.dart';

import '../../Constant/theme.dart';

Container emissionCard({
  required double height,
  required double width,
  required double co2eGm,
  required double co2eLb,
  required double co2eKg,
  required double co2eMt,
  required IconData icon,
  required Color iconColor,
}) =>
    Container(
      height: height * 0.33,
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          Icon(
            color: secondaryBlue,
            icon,
            size: 82,
          ), // Icon
          Text(
            co2eGm.toString(),
            style: displayLarge(),
            overflow: TextOverflow.ellipsis,
          ), // Text
          Text(
            "Co2e/gm",
            style: normal(),
            overflow: TextOverflow.ellipsis,
          ), // Text
          SizedBox(
            height: height * 0.04,
          ), // SizedBox
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: width * 0.15,
                child: Column(
                  children: [
                    Text(
                      co2eLb.toString(),
                      style: displayMedium(bold: true),
                      overflow: TextOverflow.ellipsis,
                    ), // Text
                    Text(
                      "Co2e/lb",
                      style: label(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ), // Column
              ),
              SizedBox(
                width: width * 0.15,
                child: Column(
                  children: [
                    Text(
                      co2eKg.toString(),
                      style: displayMedium(bold: true),
                      overflow: TextOverflow.ellipsis,
                    ), // Text
                    Text(
                      "Co2e/kg",
                      style: label(),
                      overflow: TextOverflow.ellipsis,
                    ), // Text
                  ],
                ), // Column
              ),
              SizedBox(
                width: width * 0.15,
                child: Column(
                  children: [
                    Text(
                      co2eMt.toString(),
                      style: displayMedium(bold: true),
                      overflow: TextOverflow.ellipsis,
                    ), // Text
                    Text(
                      "Co2e/mt",
                      style: label(),
                      overflow: TextOverflow.ellipsis,
                    ), // Text
                  ],
                ),
              ),
            ],
          ), // Row
        ],
      ),
    );
