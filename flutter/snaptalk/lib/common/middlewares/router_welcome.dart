import 'package:flutter/material.dart';
import 'package:snaptalk/common/routes/routes.dart';
import 'package:snaptalk/common/store/store.dart';

import 'package:get/get.dart';

class RouteWelcomeMiddleware extends GetMiddleware {
  // priority
  @override
  int? priority = 0;

  RouteWelcomeMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    print(ConfigStore.to.isFirstOpen);
    if (ConfigStore.to.isFirstOpen == false) {
      return null;
    } else if (UserStore.to.isLogin == true) {
      return RouteSettings(name: AppRoutes.Message);
    } else {
      return RouteSettings(name: AppRoutes.SIGN_IN);
    }
  }
}
