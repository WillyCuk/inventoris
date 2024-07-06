import 'dart:io';
import 'package:atk_inventoris/provider/itemlist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ItemDetailsUser extends StatelessWidget {
  final int itemIndex;
  const ItemDetailsUser({super.key, required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    List<dynamic> item = Provider.of<ItemList>(context).items[itemIndex];
    return Scaffold(
      appBar: AppBar(title: const Text("Stock Item")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .4,
            height: MediaQuery.of(context).size.height * .15,
            child: item[6] is XFile
                ? Image.file(
                    File(item[6].path),
                    fit: BoxFit.contain,
                  )
                : Image.asset(
                    item[6],
                    fit: BoxFit.contain,
                  ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Name",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  item[1],
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Divider(thickness: 2),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Brand",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  item[2],
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Divider(thickness: 2),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Type",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  item[3] == "" ? "-" : item[3],
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Divider(thickness: 2),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Description",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  item[4] == "" ? "-" : item[4],
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Divider(thickness: 2),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Quantity",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item[5].toString(),
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Rim",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Divider(thickness: 2),
          ),
        ]),
      ),
    );
  }
}
