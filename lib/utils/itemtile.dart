import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemTile extends StatelessWidget {
  final String itemName;
  final String itemBrand;
  final String itemDesc;
  final String qty;

  const ItemTile(
      {super.key,
      required this.itemName,
      required this.itemBrand,
      required this.itemDesc,
      required this.qty});

  @override
  Widget build(BuildContext context) {
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
                    itemName,
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  Row(
                    children: [
                      Text(itemBrand,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.secondary)),
                      Text(itemDesc, style: GoogleFonts.poppins(fontSize: 14))
                    ],
                  )
                ],
              ),
              const Spacer(),
              Text(qty.toString(), style: GoogleFonts.poppins(fontSize: 14)),
              const SizedBox(width: 15),
              Text("Rim", style: GoogleFonts.poppins(fontSize: 14))
            ],
          ),
        ],
      ),
    );
  }
}
