
import 'package:atk_inventoris/provider/itemlist.dart';
import 'package:atk_inventoris/provider/userorder.dart';
import 'package:atk_inventoris/utils/bottomlistitem.dart';
import 'package:atk_inventoris/utils/mybutton.dart';
import 'package:atk_inventoris/utils/ordertile.dart';
import 'package:atk_inventoris/utils/reject_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../utils/mysnackbar.dart';

class ItemRequestAdmin extends StatelessWidget {
  const ItemRequestAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final List waitingOrder = Provider.of<UserOrder>(context)
        .userOrderList
        .where((order) => order["order"]["status"] == "Waiting")
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text("Request Items")),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          // Listview dibawah digunakan untuk merender bagian awal tampilan yang berisi purchase order + id dan tanggal
          child: ListView.builder(
              itemCount: waitingOrder.length,
              itemBuilder: (context, index) {
                if (waitingOrder.isNotEmpty) {
                  // Penggunaan Gesture Detector agar setiap container yang dibuat bisa di klik untuk menampilkan detail purchase order
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                            "Purchased Order ${waitingOrder[index]["order"]['id'].toString().padLeft(3, '0')}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 16)),
                                        const Spacer(),
                                        Text(
                                            waitingOrder[index]["order"]
                                                ["date"],
                                            style: GoogleFonts.poppins(
                                                fontSize: 16)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    BottomListItem(
                                      itemCount: waitingOrder[index]["order"]
                                              ["items"]
                                          .length,
                                      index: index,
                                      orderItem: waitingOrder[index],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: MyButton(
                                              text: "REJECT",
                                              onPressed: () async {
                                                final message =
                                                    await showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return const RejectDialog();
                                                        });
                                                if (message != null) {
                                                  debugPrint(message);
                                                  Provider.of<UserOrder>(
                                                          context,
                                                          listen: false)
                                                      .changeStatusRejected(
                                                    index: waitingOrder[index]
                                                        ["order"]['id'],
                                                    message: message.toString(),
                                                  );
                                                  Navigator.pop(context);
                                                }
                                              }),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: MyButton(
                                              text: "APPROVE",
                                              onPressed: () {
                                                try {
                                                  Provider.of<ItemList>(context,
                                                          listen: false)
                                                      .retrieveQty(
                                                          item: waitingOrder[
                                                                      index]
                                                                  ["order"]
                                                              ["items"]);
                                                  Provider.of<UserOrder>(
                                                          context,
                                                          listen: false)
                                                      .changeStatusApproved(
                                                          index: waitingOrder[
                                                                  index]
                                                              ["order"]['id']);
                                                  Navigator.pop(context);
                                                } catch (e) {
                                                  String errorMessage = e
                                                      .toString()
                                                      .split(':')
                                                      .last
                                                      .trim();
                                                  showTopSnackBar(
                                                      context, errorMessage);
                                                }
                                              }),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: OrderTile(
                      orderNumber: waitingOrder[index]["order"]['id']
                          .toString()
                          .padLeft(3, '0'),
                      user: waitingOrder[index]["user"],
                      date: waitingOrder[index]["order"]["date"],
                      retrieveStatus: null,
                    ),
                  );
                } else {
                  return Container();
                }
              })),
    );
  }
}
