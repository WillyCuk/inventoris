import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderTile extends StatelessWidget {
  final String orderNumber;
  final String date;
  final String user;
  final bool? retrieveStatus;

  const OrderTile({
    super.key,
    required this.orderNumber,
    required this.date,
    required this.user,
    required this.retrieveStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 25.0),
        padding: const EdgeInsets.only(bottom: 9.0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    width: 2))),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Purchase Order $orderNumber",
                  style: GoogleFonts.poppins(),
                ),
                const Spacer(),
                Text(
                  date,
                  style: GoogleFonts.poppins(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  user,
                  style: GoogleFonts.poppins(),
                ),
                const Spacer(),
                retrieveStatus == null
                    ? Container()
                    : retrieveStatus!
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : const Icon(
                            Icons.error,
                            color: Colors.red,
                          )
              ],
            ),
          ],
        )
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Expanded(
        //             child: Row(
        //               children: [
        //                 Text(
        //                   "Purchase Order $orderNumber",
        //                   style: GoogleFonts.poppins(),
        //                 ),
        //                 const Spacer(),
        //                 Text(
        //                   date,
        //                   style: GoogleFonts.poppins(),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           const SizedBox(height: 8),
        //           Text(
        //             user,
        //             style: GoogleFonts.poppins(color: Colors.grey),
        //           )
        //         ],
        //       ),
        //     ],
        //   ),
        // ],
        // ),
        );
  }
}
