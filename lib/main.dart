import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:atk_inventoris/notification/notif_service.dart';
import 'package:atk_inventoris/provider/complaints.dart';
import 'package:atk_inventoris/provider/itemlist.dart';
import 'package:atk_inventoris/provider/maintenance.dart';
import 'package:atk_inventoris/provider/monthlyreport.dart';
import 'package:atk_inventoris/provider/theme.dart';
import 'package:atk_inventoris/provider/user.dart';
import 'package:atk_inventoris/provider/userorder.dart';
import 'package:atk_inventoris/router/router.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => User()),
      ChangeNotifierProvider(create: (context) => ItemList()),
      ChangeNotifierProvider(create: (context) => UserOrder()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => MonthlyReport()),
      ChangeNotifierProvider(create: (context) => CustomerComplaint()),
      ChangeNotifierProvider(create: (context) => MaintenanceProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ATK",
      home: AnimatedSplashScreen(
          splash: "assets/s1600.png",
          splashIconSize: 400,
          splashTransition: SplashTransition.sizeTransition,
          pageTransitionType: PageTransitionType.leftToRight,
          nextScreen: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: MyRouter().router,
            builder: (context, router) {
              return Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return Theme(
                    data: themeProvider.themeData,
                    child: router!,
                  );
                },
              );
            },
          )),
    );
  }
}
