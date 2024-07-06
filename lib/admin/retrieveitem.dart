
import 'package:atk_inventoris/provider/itemlist.dart';
import 'package:atk_inventoris/provider/userorder.dart';
import 'package:atk_inventoris/utils/itemtile.dart';
import 'package:atk_inventoris/utils/mybutton.dart';
import 'package:atk_inventoris/utils/ordertile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ItemRetrieveAdmin extends StatefulWidget {
  const ItemRetrieveAdmin({super.key});

  @override
  State<ItemRetrieveAdmin> createState() => _ItemRetrieveAdminState();
}

class _ItemRetrieveAdminState extends State<ItemRetrieveAdmin> {
  final _formKey = GlobalKey<FormState>();
  final DateTime _date = DateTime.now();
  final DateFormat _formattedDate = DateFormat('dd MMMM yyyy');

  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    if (picked != null) {
      setState(() {
        _dateController.text = _formattedDate.format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List acceptOrder = Provider.of<UserOrder>(context)
        .userOrderList
        .where((order) =>
            order["order"]["status"] == "Approved" &&
            !order["order"]["retrieve_admin"])
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Retrieve Item - Admin"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          // ListView below is used to render the initial display containing the purchase order + id and date
          child: acceptOrder.isNotEmpty
              ? ListView.builder(
                  itemCount: acceptOrder.length,
                  itemBuilder: (context, index) {
                    // Using Gesture Detector to make each created container clickable to display purchase order details
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "Purchased Order ${acceptOrder[index]["order"]['id'].toString().padLeft(3, '0')}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16)),
                                          const Spacer(),
                                          Text(
                                              acceptOrder[index]["order"]
                                                  ["date"],
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16)),
                                        ],
                                      ),
                                      const SizedBox(height: 14),
                                      Text("Nama Penerima",
                                          style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontSize: 16)),
                                      const SizedBox(height: 8),
                                      Text(acceptOrder[index]["user"],
                                          style: GoogleFonts.poppins(
                                              fontSize: 16)),
                                      const SizedBox(height: 4),
                                      const Divider(
                                        thickness: 1,
                                      ),
                                      Text("Tanggal Permintaan",
                                          style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontSize: 16)),
                                      const SizedBox(height: 8),
                                      Text(acceptOrder[index]["order"]["date"],
                                          style: GoogleFonts.poppins(
                                              fontSize: 16)),
                                      const SizedBox(height: 4),
                                      const Divider(
                                        thickness: 1,
                                      ),
                                      const SizedBox(height: 14),
                                      Text("Permintaan",
                                          style: GoogleFonts.poppins(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontSize: 18)),
                                      const SizedBox(height: 10),
                                      Expanded(
                                        // ListView here is used to render each item detail in each purchase order
                                        child: ListView.builder(
                                            itemCount: acceptOrder[index]
                                                    ["order"]["items"]
                                                .length,
                                            itemBuilder:
                                                (context, secondIndex) {
                                              List itemList = Provider.of<
                                                      ItemList>(context)
                                                  .items
                                                  .where(
                                                    (element) =>
                                                        element[0] ==
                                                        acceptOrder[index]
                                                                    ["order"]
                                                                ["items"]
                                                            [secondIndex]["id"],
                                                  )
                                                  .toList();
                                              return ItemTile(
                                                itemName: itemList[0][1],
                                                itemBrand: itemList[0][2],
                                                itemDesc: itemList[0][3],
                                                qty: acceptOrder[index]["order"]
                                                            ["items"]
                                                        [secondIndex]["qty"]
                                                    .toString(),
                                              );
                                            }),
                                      ),
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              onTap: _selectDate,
                                              controller: _dateController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Date must be filled';
                                                }
                                                return null;
                                              },
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              decoration: InputDecoration(
                                                  labelText:
                                                      "Tanggal Pengiriman  ",
                                                  labelStyle:
                                                      GoogleFonts.quicksand(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  )),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ))),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: MyButton(
                                                      text: "CONFIRM",
                                                      onPressed: () {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          Provider.of<UserOrder>(
                                                                  context,
                                                                  listen: false)
                                                              .changeRetrieveStatus(
                                                                  index: acceptOrder[
                                                                          index]
                                                                      [
                                                                      "order"]["id"]);
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      }),
                                                ),
                                                const SizedBox(width: 20),
                                                Expanded(
                                                  child: MyButton(
                                                      text: "CANCEL",
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      }),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: OrderTile(
                        orderNumber: acceptOrder[index]["order"]['id']
                            .toString()
                            .padLeft(3, '0'),
                        user: acceptOrder[index]["user"],
                        date: acceptOrder[index]["order"]["date"],
                        retrieveStatus: acceptOrder[index]["order"]
                            ["retrieve_admin"],
                      ),
                    );
                  })
              : Container()),
    );
  }
}
