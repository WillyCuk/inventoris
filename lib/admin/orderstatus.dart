
import 'package:atk_inventoris/provider/userorder.dart';
import 'package:atk_inventoris/utils/bottomlistitem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../utils/ordertile.dart';

class OrderStatusAdmin extends StatefulWidget {
  const OrderStatusAdmin({super.key});

  @override
  State<OrderStatusAdmin> createState() => _OrderStatusAdminState();
}

class _OrderStatusAdminState extends State<OrderStatusAdmin> {
  bool isApproved = false;
  bool isRejected = false;
  bool isFilterYear = false;
  String? _selectedVal;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> allOrder = Provider.of<UserOrder>(context)
        .userOrderList
        .where((element) =>
            element["order"]["status"] == "Approved" ||
            element["order"]["status"] == "Rejected")
        .toList();

    List<Map<String, dynamic>> approvedOrder = allOrder
        .where((element) => element["order"]["status"] == "Approved")
        .toList();

    List<Map<String, dynamic>> rejectedOrder = allOrder
        .where((element) => element["order"]["status"] == "Rejected")
        .toList();

    List<Map<String, dynamic>> yearOrder = allOrder
        .where((order) => order['order']['date'].split(' ')[2] == _selectedVal)
        .toList();

    List<String> uniqueYears = allOrder
        .map<String>((order) {
          String date = order['order']['date'];
          return date.split(' ')[2];
        })
        .toSet()
        .toList();

    return Scaffold(
        appBar: AppBar(title: const Text("Order Statuses")),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(children: [
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  ChoiceChip(
                      showCheckmark: false,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      selectedColor: Colors.green,
                      label: Text(
                        "Approved",
                        style: GoogleFonts.poppins(),
                      ),
                      selected: isApproved,
                      onSelected: (val) {
                        setState(() {
                          isApproved = !isApproved;
                          isRejected = false;
                          isFilterYear = false;
                          _selectedVal = null;
                        });
                      }),
                  const SizedBox(width: 10),
                  ChoiceChip(
                      showCheckmark: false,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      selectedColor: Colors.red,
                      label: Text(
                        "Rejected",
                        style: GoogleFonts.poppins(),
                      ),
                      selected: isRejected,
                      onSelected: (val) {
                        setState(() {
                          isRejected = !isRejected;
                          isApproved = false;
                          isFilterYear = false;
                          _selectedVal = null;
                        });
                      }),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField(
                      hint: Text(
                        "Filter by year",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      iconSize: 18,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ),
                      ),
                      value: _selectedVal,
                      items: uniqueYears
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: SizedBox(height: 20, child: Text(e)),
                            ),
                          )
                          .toList(),
                      elevation: 0,
                      focusColor: Colors.transparent,
                      onChanged: (String? val) {
                        setState(() {
                          _selectedVal = val!;
                          isFilterYear = true;
                          isApproved = false;
                          isRejected = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            !isApproved && !isRejected && isFilterYear
                ? Expanded(
                    child: ListView.builder(
                      itemCount: yearOrder.length,
                      itemBuilder: ((context, index) {
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
                                                  "Purchased Order ${yearOrder[index]["order"]['id'].toString().padLeft(3, '0')}",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16)),
                                              const Spacer(),
                                              Text(
                                                  yearOrder[0]["order"]["date"],
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16)),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          BottomListItem(
                                              itemCount: yearOrder[index]
                                                      ["order"]["items"]
                                                  .length,
                                              index: index,
                                              orderItem: yearOrder[index]),
                                          yearOrder[index]["order"]
                                                      ["message"] ==
                                                  ""
                                              ? Container()
                                              : Text(
                                                  "Reject Message : ${yearOrder[index]["order"]["message"]}",
                                                  style: GoogleFonts.poppins(),
                                                ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: OrderTile(
                            orderNumber: yearOrder[index]["order"]['id']
                                .toString()
                                .padLeft(3, '0'),
                            user: yearOrder[index]["user"],
                            date: yearOrder[index]["order"]["date"],
                            retrieveStatus: yearOrder[index]["order"]
                                ["retrieve_admin"],
                          ),
                        );
                      }),
                    ),
                  )
                : isApproved
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: approvedOrder.length,
                          itemBuilder: ((context, index) {
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
                                                      "Purchased Order ${approvedOrder[index]["order"]['id'].toString().padLeft(3, '0')}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 16)),
                                                  const Spacer(),
                                                  Text(
                                                      approvedOrder[index]
                                                          ["order"]["date"],
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 16)),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              BottomListItem(
                                                  itemCount:
                                                      approvedOrder[index]
                                                              ["order"]["items"]
                                                          .length,
                                                  index: index,
                                                  orderItem:
                                                      approvedOrder[index]),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: OrderTile(
                                orderNumber: approvedOrder[index]["order"]['id']
                                    .toString()
                                    .padLeft(3, '0'),
                                user: approvedOrder[index]["user"],
                                date: approvedOrder[index]["order"]["date"],
                                retrieveStatus: approvedOrder[index]["order"]
                                    ["retrieve_admin"],
                              ),
                            );
                          }),
                        ),
                      )
                    : isRejected
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: rejectedOrder.length,
                              itemBuilder: ((context, index) {
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
                                                          "Purchased Order ${rejectedOrder[index]["order"]['id'].toString().padLeft(3, '0')}",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize:
                                                                      16)),
                                                      const Spacer(),
                                                      Text(
                                                          rejectedOrder[0]
                                                              ["order"]["date"],
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize:
                                                                      16)),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  BottomListItem(
                                                      itemCount:
                                                          rejectedOrder[index]
                                                                      ["order"]
                                                                  ["items"]
                                                              .length,
                                                      index: index,
                                                      orderItem:
                                                          rejectedOrder[index]),
                                                  rejectedOrder[index]["order"]
                                                              ["message"] ==
                                                          ""
                                                      ? Container()
                                                      : Text(
                                                          "Reject Message : ${rejectedOrder[index]["order"]["message"]}",
                                                          style: GoogleFonts
                                                              .poppins(),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: OrderTile(
                                    orderNumber: rejectedOrder[index]["order"]
                                            ['id']
                                        .toString()
                                        .padLeft(3, '0'),
                                    user: rejectedOrder[index]["user"],
                                    date: rejectedOrder[0]["order"]["date"],
                                    retrieveStatus: null,
                                  ),
                                );
                              }),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: allOrder.length,
                              itemBuilder: ((context, index) {
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
                                                          "Purchased Order ${allOrder[index]["order"]['id'].toString().padLeft(3, '0')}",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize:
                                                                      16)),
                                                      const Spacer(),
                                                      Text(
                                                          allOrder[index]
                                                              ["order"]["date"],
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize:
                                                                      16)),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  BottomListItem(
                                                      itemCount: allOrder[index]
                                                              ["order"]["items"]
                                                          .length,
                                                      index: index,
                                                      orderItem:
                                                          allOrder[index]),
                                                  allOrder[index]["order"]
                                                              ["message"] ==
                                                          ""
                                                      ? Container()
                                                      : Text(
                                                          "Reject Message : ${allOrder[index]["order"]["message"]}",
                                                          style: GoogleFonts
                                                              .poppins(),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: OrderTile(
                                    orderNumber: allOrder[index]["order"]['id']
                                        .toString()
                                        .padLeft(3, '0'),
                                    user: allOrder[index]["user"],
                                    date: allOrder[index]["order"]["date"],
                                    retrieveStatus: allOrder[index]["order"]
                                        ["retrieve_admin"],
                                  ),
                                );
                              }),
                            ),
                          )
          ]),
        ));
  }
}
