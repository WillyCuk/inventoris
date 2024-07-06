import 'package:atk_inventoris/router/routernamed.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class StockTile extends StatelessWidget {
  final String routeIndex;
  final String itemName;
  final String itemBrand;
  final String qty;
  final String role;
  final String unit;
  const StockTile(
      {super.key,
      required this.routeIndex,
      required this.itemName,
      required this.itemBrand,
      required this.qty,
      required this.role,
      required this.unit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        role == "admin"
            ? context.pushNamed(RouterName.itemDetailAdminPage,
                pathParameters: {'index': routeIndex})
            : context.pushNamed(RouterName.itemDetailUserPage,
                pathParameters: {'index': routeIndex});
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        padding: const EdgeInsets.only(bottom: 9.0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    width: 2))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemName,
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(height: 5),
                Text(
                  itemBrand,
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w200,
                      fontSize: 15),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  qty,
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(width: 10),
                Text(
                  unit,
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
