import 'dart:ui';

import 'package:flutter/material.dart';

class GradientBackGround extends StatelessWidget {
  final Color? endColor;
  final Color? beginColor;

  const GradientBackGround({this.beginColor, this.endColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            beginColor ?? Theme.of(context).primaryColorDark,
            endColor ?? Theme.of(context).primaryColorLight,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
