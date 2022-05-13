import 'dart:developer';

import 'package:flutter/material.dart';

class RouteHelper {
  RouteHelper._();
  static RouteHelper routeHelper = RouteHelper._();
  GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  goToPage(String routeName) {
    log(routeName);
    navKey.currentState?.pushNamed(routeName);
    log("message");
  }

  goToPageWithReplacement(String routeName) {
    navKey.currentState?.pushReplacementNamed(routeName);
  }

  back() {
    navKey.currentState?.pop();
  }
}
