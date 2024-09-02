import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkingold/resources/gaps.dart';
import 'package:parkingold/utils/screen.util.dart';
import 'package:parkingold/resources/colors.dart';

class ButtonFunction extends StatefulWidget {
  const ButtonFunction({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onTap;
  final String title;

  @override
  State<ButtonFunction> createState() => _ButtonFunctionState();
}

class _ButtonFunctionState extends State<ButtonFunction> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
            color: Colours.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colours.grey.withOpacity(0.03),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
          child: Container(
            alignment: Alignment.center,
            width: (context.width / 2) - 70,
            height: (context.width / 2) - 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  size: 50,
                  color: Colours.mainFontColor,
                ),
                Gaps.vGap10,
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colours.mainFontColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
