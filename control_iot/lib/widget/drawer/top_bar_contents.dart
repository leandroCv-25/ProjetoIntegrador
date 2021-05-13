import 'package:control_iot/widget/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/navigation_provider.dart';
import '../../providers/user_manager.dart';
import '../../widget/auth_dialog.dart';

class TopBarContents extends StatefulWidget {
  final double opacity;
  const TopBarContents(this.opacity);

  @override
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final _userManager = Provider.of<UserManager>(context);

    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        color: Theme.of(context).bottomAppBarColor.withOpacity(widget.opacity),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[0] = true
                              : _isHovering[0] = false;
                        });
                      },
                      onTap: () {
                        Provider.of<NavigationProvider>(context, listen: false)
                            .setPage(0);
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            // backgroundImage:
                            //     const AssetImage("assets/images/logo.png"),
                            backgroundColor: Colors.transparent,
                            child: Container(),
                          ),
                          SizedBox(width: screenSize.width / 100),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Início',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                              const SizedBox(height: 5),
                              Visibility(
                                maintainAnimation: true,
                                maintainState: true,
                                maintainSize: true,
                                visible: _isHovering[0] != null &&
                                    _isHovering[0] == true,
                                child: Container(
                                  height: 2,
                                  width: 20,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 30),
                    if (_userManager.isLoggedIn)
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[1] = true
                                : _isHovering[1] = false;
                          });
                        },
                        onTap: () {
                          Provider.of<NavigationProvider>(context,
                                  listen: false)
                              .setPage(1);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Aparelhos',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[1] != null &&
                                  _isHovering[1] == true,
                              child: Container(
                                height: 2,
                                width: 20,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    if (_userManager.isLoggedIn)
                      SizedBox(width: screenSize.width / 30),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[2] = true
                              : _isHovering[2] = false;
                        });
                      },
                      onTap: () {
                        Provider.of<NavigationProvider>(context, listen: false)
                            .setPage(2);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Teorias',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[2] != null &&
                                _isHovering[2] == true,
                            child: Container(
                              height: 2,
                              width: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[5] = true : _isHovering[5] = false;
                  });
                },
                onTap: !_userManager.isLoggedIn
                    ? () {
                        showDialog(
                          context: context,
                          builder: (context) => AuthDialog(),
                        );
                      }
                    : null,
                child: !_userManager.isLoggedIn
                    ? Text(
                        'Entrar',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                            ),
                      )
                    : Row(
                        children: [
                          // CircleAvatar(
                          //   radius: 15,
                          //   backgroundImage: _userManager!= null
                          //       ? NetworkImage(imageUrl)
                          //       : null,
                          //   child: imageUrl == null
                          //       ? Icon(
                          //           Icons.account_circle,
                          //           size: 30,
                          //         )
                          //       : Container(),
                          // ),
                          const SizedBox(width: 5),
                          if (_userManager.isLoggedIn &&
                              ResponsiveWidget.isLargeScreen(context))
                            Text(
                              _userManager.user!.name ??
                                  _userManager.user!.email!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.logout),
                            color: Colors.white,
                            highlightColor: Colors.blueGrey[800],
                            onPressed: () => _userManager.signOut(),
                          )
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
