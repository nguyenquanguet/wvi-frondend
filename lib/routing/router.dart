import 'package:vnmo_mis/pages/mis/mis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/overview_controller.dart';
import '../pages/clients/clients.dart';
import '../pages/overview/overview.dart';
import '../pages/sales/sales.dart';
import '../pages/transaction/transaction.dart';
import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // case overviewPageRoute:
    //   return _getPageRoute(OverviewPage());
    // case transactionPageRoute:
    //   return _getPageRoute(const TransactionPage());
    // case clientsPageRoute:
    //   return _getPageRoute(ClientsPage());
    case misPageRoute:
      return _getPageRoute(MisPage());
    // case salesPageRoute:
    //   return _getPageRoute(const SalesPage());
    default:
      return _getPageRoute(MisPage());
  // return _getPageRoute(OverviewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  Get.delete<OverviewController>();
  return MaterialPageRoute(builder: (context) => child);
}
