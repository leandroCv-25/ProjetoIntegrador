import 'package:control_iot/screens/home_screen/widgets/section_side.dart';
import 'package:flutter/material.dart';

import '../../widget/bottom_bar/bottom_bar.dart';
import '../../widget/drawer/app_drawer.dart';
import '../../widget/drawer/top_bar_contents.dart';
import '../../widget/responsive/responsive_widget.dart';
import 'widgets/section_banner.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;

  void _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: (ResponsiveWidget.isSmallScreen(context) ||
              ResponsiveWidget.isExtraSmallScreen(context))
          ? AppBar(
              title: CircleAvatar(
                backgroundImage: const AssetImage("assets/images/logo.png"),
                backgroundColor: const Color(0x00000000),
                child: Container(),
              ),
              elevation: 0,
              backgroundColor:
                  Theme.of(context).primaryColorDark.withOpacity(_opacity),
              centerTitle: true,
            )
          : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: TopBarContents(_opacity),
            ),
      drawer: const AppDrawer(),
      body: ListView(
        padding: EdgeInsets.zero,
        controller: _scrollController,
        children: [
          SectionBanner("images/banner.jpg"),
          SectionSide(
            image: "images/Pêndulo.png",
            right: true,
            answer:
                "Uma plataforma criada com intuito de auxiliar laboratórios acadêmicos a estudar e desenvolver pesquisa relacionada a aplicações práticas da teoria de controle.",
            question: "QUEM SOMOS?",
          ),
          SectionSide(
            image: "",
            answer: "Podemos trabalhar com diversas teorias de controle.",
            question: "Preparado para tentar?",
          ),
          BottomBar(),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
