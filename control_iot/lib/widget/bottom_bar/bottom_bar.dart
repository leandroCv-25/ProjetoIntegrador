import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/navigation_provider.dart';
import '../responsive/responsive_widget.dart';
import 'bottom_bar_column.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomBarColumn1 = BottomBarColumn(
      'Sobre',
      text1: 'Sobre nós',
      function1: () {
        Provider.of<NavigationProvider>(context, listen: false).setPage(3);
      },
      text2: 'Contato',
      function2: () {
        Provider.of<NavigationProvider>(context, listen: false).setPage(4);
      },
    );
    final bottomBarColumn2 = BottomBarColumn(
      'Redes sociais',
      text1: 'Instagram',
      function1: () async {
        const url = 'https://www.instagram.com/hy_doityourself/';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      text2: 'Facebook',
      function2: () async {
        const url = 'https://www.facebook.com/HY-101655141766316/';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      text3: 'Linkedin',
      function3: () async {
        const url = 'https://www.linkedin.com/company/hy-do-it-your-self/';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
    );
    return Container(
      padding: const EdgeInsets.all(30),
      color: Colors.blueGrey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (ResponsiveWidget.isSmallScreen(context) ||
              ResponsiveWidget.isExtraSmallScreen(context))
            Column(
              children: [
                const Divider(
                  color: Colors.white,
                  height: 3,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [bottomBarColumn1, bottomBarColumn2]),
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 15,
                  backgroundImage: const AssetImage(
                    "assets/images/logo.png",
                  ),
                  backgroundColor: Colors.transparent,
                  child: Container(),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          if (!ResponsiveWidget.isSmallScreen(context) &&
              !ResponsiveWidget.isExtraSmallScreen(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 15,
                  backgroundImage: const AssetImage(
                    "assets/images/logo.png",
                  ),
                  backgroundColor: Colors.transparent,
                  child: Container(),
                ),
                bottomBarColumn1,
                bottomBarColumn2,
              ],
            ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: Colors.white,
            thickness: 1,
          ),
          const SizedBox(height: 20),
          Text(
            'Copyright © 2020 | Hy',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
