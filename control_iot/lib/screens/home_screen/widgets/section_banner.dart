import 'package:flutter/material.dart';

import '../../../widget/responsive/responsive_widget.dart';

class SectionBanner extends StatelessWidget {
  SectionBanner(this.image);
  final String image;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      height: ResponsiveWidget.isSmallScreen(context)
          ? ResponsiveWidget.heightScreen(context) * 0.45
          : ResponsiveWidget.heightScreen(context) * 0.90,
      width: ResponsiveWidget.widthScreen(context),
      fit: BoxFit.fill,
    );
  }
}
