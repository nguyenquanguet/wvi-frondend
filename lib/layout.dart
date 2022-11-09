import 'package:vnmo_mis/helpers/responsiveness.dart';
import 'package:vnmo_mis/widgets/small_screen.dart';
import 'package:vnmo_mis/widgets/top_nav.dart';
import 'package:flutter/material.dart';

import 'constants/size_config.dart';
import 'widgets/large_screen.dart';
import 'widgets/side_menu.dart';

class SiteLayout extends StatelessWidget {
  SiteLayout({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: topNaigatorBar(context, scaffoldKey),
      drawer: const Drawer(
        child: SideMenu(),
      ),
      body: const ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen(),
      ),
    );
  }
}
