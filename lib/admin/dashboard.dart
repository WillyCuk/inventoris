import 'package:atk_inventoris/router/routernamed.dart';
import 'package:atk_inventoris/utils/dashboardtile.dart';
import 'package:atk_inventoris/utils/logo.dart';
import 'package:atk_inventoris/utils/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardAdminPage extends StatelessWidget {
  DashboardAdminPage({super.key});

  final List<List<String>> menu = [
    ["Stock Item", "assets/receive.png", RouterName.stockItemAdminPage],
    ["Add Item", "assets/plus.png", RouterName.addItemAdminPage],
    [
      "Item Requests",
      "assets/shopping-list.png",
      RouterName.itemRequestsAdminPage
    ],
    ["Orders Statuses", "assets/check.png", RouterName.orderStatusAdminPage],
    [
      "Retrieved Items",
      "assets/download.png",
      RouterName.retrieveItemAdminPage
    ],
    ["Item Reports", "assets/report.png", RouterName.itemReportsAdminPage],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const MyAdminDrawer(),
      appBar: AppBar(
        title: Text(
          "Aplikasi Data BMN ATK",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
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
              // crossAxisSpacing: 10,
            ),
            itemCount: menu.length,
            itemBuilder: (context, index) {
              return DashboardTile(
                  route: menu[index][2],
                  imagePath: menu[index][1],
                  menuName: menu[index][0]);
            },
          )
        ],
      ),
    );
  }
}
