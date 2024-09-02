import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkingold/resources/dimens.dart';
import 'package:parkingold/resources/gaps.dart';
import 'package:parkingold/utils/screen.util.dart';
import 'package:parkingold/resources/colors.dart';

class CardSetting extends StatelessWidget {
  const CardSetting(
      {Key? key,
      this.onTap,
      required this.icon,
      required this.title,
      this.desc})
      : super(key: key);

  final IconData icon;
  final VoidCallback? onTap;
  final String title;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Colours.white,
                  borderRadius: BorderRadius.circular(Dimens.radius_25),
                  boxShadow: [
                    BoxShadow(
                      color: Colours.grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colours.arrowBgColor,
                        borderRadius: BorderRadius.circular(Dimens.radius_15),
                        // shape: BoxShape.circle
                      ),
                      child: Center(
                          child: Icon(
                        icon,
                        color: Colours.mainFontColor,
                      )),
                    ),
                    Gaps.hGap15,
                    Expanded(
                      child: Container(
                        width: (context.width - 90) * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colours.mainFontColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            desc != null && desc!.isNotEmpty
                                ? Container(
                                    margin: const EdgeInsets.only(
                                        top: Dimens.gap_dp5),
                                    child: Text(
                                      desc ?? '',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colours.black.withOpacity(0.5),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: Container(
                    //     child: Row(
                    //       mainAxisAlignment:
                    //       MainAxisAlignment.end,
                    //       children: [
                    //         Text(
                    //           "\$150",
                    //           style: TextStyle(
                    //               fontSize: 15,
                    //               fontWeight: FontWeight.bold,
                    //               color: Colours.black),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
