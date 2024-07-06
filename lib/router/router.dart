import "package:atk_inventoris/admin_user/error.dart";
import "package:atk_inventoris/admin_user/login.dart";
import "package:atk_inventoris/admin_user/mainpage.dart";
import "package:atk_inventoris/admin_user/register.dart";
import "package:atk_inventoris/router/routernamed.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class MyRouter {
  GoRouter router = GoRouter(
      initialLocation: "/",
      routes: [
        GoRoute(
          path: "/",
          name: RouterName.mainPageName,
          builder: (context, state) => const MainPage(),
        ),
        GoRoute(
          path: "/login",
          name: RouterName.loginPageName,
          pageBuilder: (context, state) {
            return const MaterialPage(child: LoginPage());
          },
        ),
        GoRoute(
            path: "/register",
            name: RouterName.registerPageName,
            pageBuilder: (context, state) {
              return const MaterialPage(child: RegisterPage());
            }),
      ],
      errorPageBuilder: (context, state) {
        return MaterialPage(child: ErrorPage(key: state.pageKey));
      });
}
