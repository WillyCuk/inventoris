import 'package:atk_inventoris/provider/theme.dart';
import 'package:atk_inventoris/provider/user.dart';
import 'package:atk_inventoris/router/routernamed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyAdminDrawer extends StatelessWidget {
  const MyAdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Aplikasi Pendataan Alat Tulis Kantor",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 70),
              GestureDetector(
                onTap: () => context.pushNamed(RouterName.dashboardAdminPage),
                child: Text(
                  "Main Page",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 35),
              GestureDetector(
                onTap: () => context.pushNamed(RouterName.profilePage),
                child: Text(
                  "Profile",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 35),
              GestureDetector(
                onTap: () =>
                    context.pushNamed(RouterName.itemRequestsAdminPage),
                child: Text(
                  "Request Forms",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 35),
              GestureDetector(
                onTap: () =>
                    context.pushNamed(RouterName.approvedOrderAdminPage),
                child: Text(
                  "Approved Requests",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 35),
              GestureDetector(
                onTap: () => context.pushNamed(RouterName.stockItemAdminPage),
                child: Text(
                  "Item",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 35),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(height: 35),
              FlutterSwitch(
                  activeIcon: const Icon(
                    Icons.dark_mode,
                    color: Colors.black,
                  ),
                  inactiveIcon: const Icon(Icons.light_mode),
                  value: Provider.of<ThemeProvider>(context).isDarkMode,
                  onToggle: (value) =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme()),
              const SizedBox(height: 30),
              GestureDetector(
                  onTap: () {
                    Provider.of<User>(context, listen: false).isLogin = false;
                    context.goNamed(RouterName.loginPageName);
                  },
                  child: Text(
                    "Log Out",
                    style: GoogleFonts.poppins(fontSize: 20),
                  )),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () => context.pushNamed(RouterName.csContact),
                child: Text(
                  "CS Contact",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

class MyUserDrawer extends StatelessWidget {
  const MyUserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Aplikasi Pendataan Alat Tulis Kantor",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 70),
              GestureDetector(
                onTap: () => context.pushNamed(RouterName.dashboardUserPage),
                child: Text(
                  "Main Page",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 35),
              GestureDetector(
                onTap: () => context.pushNamed(RouterName.profilePage),
                child: Text(
                  "Profile",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 35),
              GestureDetector(
                onTap: () => context.pushNamed(RouterName.itemRequestsUserPage),
                child: Text(
                  "Request Forms",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 35),
              GestureDetector(
                onTap: () => context.pushNamed(RouterName.stockItemUserPage),
                child: Text(
                  "Item",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 35),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(height: 35),
              FlutterSwitch(
                  activeIcon: const Icon(
                    Icons.dark_mode,
                    color: Colors.black,
                  ),
                  inactiveIcon: const Icon(Icons.light_mode),
                  value: Provider.of<ThemeProvider>(context).isDarkMode,
                  onToggle: (value) =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme()),
              const SizedBox(height: 30),
              GestureDetector(
                  onTap: () {
                    Provider.of<User>(context, listen: false).isLogin = false;
                    context.goNamed(RouterName.loginPageName);
                  },
                  child: Text(
                    "Log Out",
                    style: GoogleFonts.poppins(fontSize: 20),
                  )),
              GestureDetector(
                onTap: () => context.pushNamed(RouterName.csContact),
                child: Text(
                  "CS Contact",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
