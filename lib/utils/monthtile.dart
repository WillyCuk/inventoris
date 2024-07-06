import 'package:atk_inventoris/router/routernamed.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MonthTile extends StatelessWidget {
  final String month;
  final String qty;
  const MonthTile({super.key, required this.month, required this.qty});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(RouterName.itemReportsAdminPage,
            pathParameters: {'month': month});
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        padding: const EdgeInsets.only(bottom: 9.0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Theme.of(context).dividerColor, width: 1))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  month,
                  style: GoogleFonts.poppins(fontSize: 17),
                ),
              ],
            ),
            Text(
              qty,
              style: GoogleFonts.poppins(),
            ),
          ],
        ),
      ),
    );
  }
}
