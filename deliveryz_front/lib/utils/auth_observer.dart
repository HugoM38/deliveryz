import 'package:deliveryz_front/utils/shared_prefs_manager.dart';
import 'package:flutter/material.dart';

class AuthObserver extends NavigatorObserver {
  String? lastCheckedRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _checkAuthentication(route.settings.name);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _checkAuthentication(newRoute?.settings.name);
  }

  Future<void> _checkAuthentication(String? routeName) async {
    if (routeName == null) return;

    bool isUserLogged = await SharedPrefsManager.isUserLogged();
    String? role = await SharedPrefsManager.getRole();
    lastCheckedRoute = routeName;

    if (isUserLogged && (routeName == '/login' || routeName == '/signup')) {
      navigator!.pushNamedAndRemoveUntil(
          role == 'Client'
              ? '/home-client'
              : role == 'Restaurant'
                  ? '/home-cooker'
                  : '/home-deliverer',
          (Route<dynamic> route) => false);
    } else if (!isUserLogged &&
        (routeName != '/login' && routeName != '/signup')) {
      navigator!
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    }
  }
}
