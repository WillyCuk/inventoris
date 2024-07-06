import 'package:atk_inventoris/provider/itemlist.dart';
import 'package:atk_inventoris/utils/stocktile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StockItemUser extends StatelessWidget {
  const StockItemUser({super.key});

  @override
  Widget build(BuildContext context) {
    List items = Provider.of<ItemList>(context).items;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Row(
          children: [
            Text(
              "Stock Item",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => StockTile(
                role: "user",
                routeIndex: index.toString(),
                itemName: items[index][1],
                itemBrand: items[index][2],
                qty: items[index][5].toString(),
                unit: items[index][7]),
          )),
    );
  }
}
