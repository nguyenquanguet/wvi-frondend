import 'package:flutter/material.dart';

import '../helpers/responsiveness.dart';

AppBar topNavigatorBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Expanded(
              child: Container(
              padding: const EdgeInsets.fromLTRB(50, 10, 5, 5),
              child: Image.asset("assets/icons/logo.png"),
            ))
          : IconButton(
              onPressed: () {
                key.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu),
              color: Colors.black,
            ),
      elevation: 0,
      leadingWidth: 180,
      backgroundColor: Colors.transparent,
    );
