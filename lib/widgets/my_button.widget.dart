import 'package:flutter/cupertino.dart';
import 'package:parkingold/resources/dimens.dart';
import 'package:parkingold/theme/colors.dart';
import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  const MyButton({Key? key, required this.text, this.onTap}) : super(key: key);

  final String text;
  final VoidCallback? onTap;

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        // margin: EdgeInsets.symmetric(horizontal: Dimens.gap_dp20),
        decoration: BoxDecoration(
            color: buttoncolor, borderRadius: BorderRadius.circular(Dimens.radius_25)),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
