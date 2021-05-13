import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/navigation_provider.dart';

class DrawTile extends StatelessWidget {
  final IconData? iconData;
  final String? image;
  final String text;
  final Function() function;
  final int? order;

  const DrawTile(
      {this.iconData,
      this.image,
      required this.text,
      required this.function,
      required this.order});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final int atualPage = Provider.of<NavigationProvider>(context).page;
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8),
        height: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: <Widget>[
                if (iconData != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(iconData,
                        size: 32,
                        color: atualPage == order ? primaryColor : Colors.grey),
                  ),
                if (image != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage(image!),
                      backgroundColor: Colors.transparent,
                      child: Container(),
                    ),
                  ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: atualPage == order ? primaryColor : Colors.grey),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
