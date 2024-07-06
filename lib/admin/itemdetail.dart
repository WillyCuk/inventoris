import 'dart:io';
import 'package:atk_inventoris/provider/itemlist.dart';
import 'package:atk_inventoris/utils/mypagebutton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ItemDetailsAdmin extends StatefulWidget {
  final int itemIndex;
  const ItemDetailsAdmin({super.key, required this.itemIndex});

  @override
  State<ItemDetailsAdmin> createState() => _ItemDetailsAdminState();
}

class _ItemDetailsAdminState extends State<ItemDetailsAdmin> {
  bool isEdit = false;
  int add = 0;
  late int _qty;

  @override
  Widget build(BuildContext context) {
    List<dynamic> item = Provider.of<ItemList>(context).items[widget.itemIndex];
    _qty = item[5];
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
                      _qty.toString(),
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
          isEdit
              ? Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Add Stock",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    )),
                    Expanded(
                        child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                if (add > 0) {
                                  add -= 1;
                                }
                              });
                            },
                            child: const Icon(
                              Icons.remove,
                              size: 16,
                            )),
                        const SizedBox(width: 10),
                        Text(
                          add.toString(),
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                add += 1;
                              });
                            },
                            child: const Icon(
                              Icons.add,
                              size: 16,
                            )),
                      ],
                    )),
                  ],
                )
              : Container(),
          const Spacer(),
          Row(
            children: [
              const Spacer(),
              MyPageButton(
                  text: isEdit ? "CONFIRM" : "EDIT",
                  onPressed: () {
                    setState(() {
                      if (isEdit) {
                        Provider.of<ItemList>(context, listen: false)
                            .setQty(index: widget.itemIndex, qty: _qty + add);
                        _qty += add;
                        add = 0;
                      }
                      isEdit = !isEdit;
                    });
                  },
                  width: MediaQuery.of(context).size.width * .1,
                  height: 40),
            ],
          ),
        ]),
      ),
    );
  }
}
