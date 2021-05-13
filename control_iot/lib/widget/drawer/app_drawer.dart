import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/navigation_provider.dart';
import '../../providers/user_manager.dart';
import '../auth_dialog.dart';
import '../detail/gradient_background.dart';
import 'draw_tile.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer();

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<UserManager>(context);
    //debugPrint(_auth.userUid);
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            const SizedBox(
              height: 250,
              child: GradientBackGround(),
            ),
            ListView(
              padding: const EdgeInsets.only(top: 16, left: 16),
              children: <Widget>[
                Container(
                  height: 250,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.fromLTRB(0, 16, 16, 8),
                  child: Stack(
                    children: <Widget>[
                      const Positioned(
                        top: 8,
                        left: 40,
                        child: CircleAvatar(
                          radius: 80,
                          //backgroundImage: AssetImage("assets/images/logo.png"),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Bem-vindo",
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyText1,
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                DrawTile(
                  iconData: Icons.home,
                  text: "Inicio",
                  function: () {
                    Provider.of<NavigationProvider>(context, listen: false)
                        .setPage(0);
                    Navigator.of(context).pop();
                  },
                  order: 0,
                ),
                if (_auth.isLoggedIn)
                  DrawTile(
                    iconData: Icons.construction,
                    text: "Aparelhos",
                    function: () {
                      Provider.of<NavigationProvider>(context, listen: false)
                          .setPage(1);
                      Navigator.of(context).pop();
                    },
                    order: 1,
                  ),
                if (!_auth.isLoggedIn)
                  DrawTile(
                    iconData: Icons.account_box,
                    text: "Entrar",
                    function: () {
                      showDialog(
                        context: context,
                        builder: (context) => AuthDialog(),
                      );
                    },
                    order: null,
                  ),
                DrawTile(
                  iconData: Icons.book,
                  text: "Teorias",
                  function: () {
                    Provider.of<NavigationProvider>(context, listen: false)
                        .setPage(2);
                    Navigator.of(context).pop();
                  },
                  order: 2,
                ),
                if (Provider.of<UserManager>(context).isLoggedIn)
                  DrawTile(
                    iconData: Icons.exit_to_app,
                    text: "Sair",
                    function: () {
                      Provider.of<UserManager>(context, listen: false)
                          .signOut();
                    },
                    order: null,
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
