import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widget/responsive/responsive_widget.dart';

class SectionSide extends StatelessWidget {
  SectionSide(
      {this.right = false,
      this.left = false,
      required this.answer,
      required this.question,
      required this.image});

  final bool right;
  final bool left;
  final String answer;
  final String question;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: ResponsiveWidget.isSmallScreen(context)
                ? ResponsiveWidget.widthScreen(context)
                : ResponsiveWidget.widthScreen(context) / 2,
            color: Colors.black,
            child: Text(
              question,
              style: ResponsiveWidget.isSmallScreen(context)
                  ? Theme.of(context).textTheme.headline6
                  : Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (left)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(image),
                  ),
                ),
              SizedBox(
                width: ResponsiveWidget.isSmallScreen(context)
                    ? MediaQuery.of(context).size.width / 2
                    : MediaQuery.of(context).size.width / 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    answer,
                    textAlign: TextAlign.justify,
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    style: ResponsiveWidget.isSmallScreen(context)
                        ? Theme.of(context).textTheme.bodyText2
                        : Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              if (right)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(image),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
