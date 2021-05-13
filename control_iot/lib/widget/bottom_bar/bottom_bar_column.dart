import 'package:flutter/material.dart';

import '../responsive/responsive_widget.dart';

class BottomBarColumn extends StatelessWidget {
  final String title;
  final String? text1;
  final String? text2;
  final String? text3;
  final Function()? function1;
  final Function()? function2;
  final Function()? function3;

  const BottomBarColumn(this.title,
      {this.text1,
      this.text2,
      this.function1,
      this.function2,
      this.text3,
      this.function3});

  @override
  Widget build(BuildContext context) {
    final style = ResponsiveWidget.isSmallScreen(context)
        ? Theme.of(context).textTheme.caption!.copyWith(color: Colors.white)
        : Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white);
    return Column(children: [
      Text(title, style: Theme.of(context).textTheme.bodyText1),
      TextButton(
        onPressed: function1,
        child: Text(text1!, style: style),
      ),
      TextButton(
        onPressed: function2,
        child: Text(text2!, style: style),
      ),
      if (text3 != null)
        TextButton(
          onPressed: function3,
          child: Text(text3!, style: style),
        )
      else
        Container(),
    ]);
  }
}
