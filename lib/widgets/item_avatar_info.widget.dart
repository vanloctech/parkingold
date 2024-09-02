import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkingold/resources/gaps.dart';

import '../resources/colors.dart';

class ItemAvatarInfo extends StatelessWidget {
  const ItemAvatarInfo({Key? key, required this.title, required this.value}) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colours.mainFontColor),
          ),
          Gaps.vGap5,
          Text(
            title,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w100,
                color: Colours.black),
          ),
        ],
      ),
    );
  }
}
