
import 'package:atk_inventoris/provider/itemlist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BottomListItem extends StatelessWidget {
  final int itemCount;
  final int index;
  final Map orderItem;
  const BottomListItem(
      {super.key,
      required this.itemCount,
      required this.index,
      required this.orderItem});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      // Listview disini digunakan untuk merender setiap item detail dalam purchase order masing-masing
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: orderItem["order"]["items"].length,
          itemBuilder: (context, secondIndex) {
            List itemList = Provider.of<ItemList>(context)
                .items
                .where(
                  (element) =>
                      element[0] ==
                      orderItem["order"]["items"][secondIndex]["id"],
                )
                .toList();

            return Padding(
              padding: const EdgeInsets.only(bottom: 9.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            itemList[0][1],
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          Row(
                            children: [
                              Text(itemList[0][2],
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, color: Colors.blueGrey)),
                              Text(itemList[0][3],
                                  style: GoogleFonts.poppins(fontSize: 14))
                            ],
                          )
                        ],
                      ),
                      const Spacer(),
                      Text(
                          orderItem["order"]["items"][secondIndex]["qty"]
                              .toString(),
                          style: GoogleFonts.poppins(fontSize: 14)),
                      const SizedBox(width: 15),
                      Text(itemList[0][7],
                          style: GoogleFonts.poppins(fontSize: 14))
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
