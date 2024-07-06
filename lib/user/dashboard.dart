import 'package:atk_inventoris/router/routernamed.dart';
import 'package:atk_inventoris/utils/dashboardtile.dart';
import 'package:atk_inventoris/utils/logo.dart';
import 'package:atk_inventoris/utils/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardUserPage extends StatelessWidget {
  DashboardUserPage({super.key});

  final List<List<String>> menu = [
    ["Stock Item", "assets/receive.png", RouterName.stockItemUserPage],
    [
      "Requests Items",
      "assets/shopping-list.png",
      RouterName.itemRequestsUserPage
    ],
    ["Orders Status", "assets/check.png", RouterName.orderStatusUserPage],
    ["Retrieve Items", "assets/download.png", RouterName.itemRetrieveUserPage],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const MyUserDrawer(),
      appBar: AppBar(
        title: Text(
          "Aplikasi Data BMN ATK",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .03),
          const MyLogo(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .125,
                vertical: 10.0),
            child: const Divider(),
          ),
          Text(
            "Menu Data",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Theme.of(context).colorScheme.primary),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .1,
                vertical: 10.0),
            child: const Divider(),
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
              ),
              itemCount: menu.length,
              itemBuilder: (context, index) {
                return DashboardTile(
                    route: menu[index][2],
                    imagePath: menu[index][1],
                    menuName: menu[index][0]);
              }),
        ],
      ),
    );
  }
}
