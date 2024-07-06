
import 'package:atk_inventoris/provider/itemlist.dart';
import 'package:atk_inventoris/provider/user.dart';
import 'package:atk_inventoris/provider/userorder.dart';
import 'package:atk_inventoris/utils/mybutton.dart';
import 'package:atk_inventoris/utils/mypagebutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:intl/intl.dart";
import 'package:provider/provider.dart';


class ItemRequest extends StatefulWidget {
  const ItemRequest({super.key});

  @override
  State<ItemRequest> createState() => _ItemRequestState();
}

class _ItemRequestState extends State<ItemRequest> {
  List<Map<String, dynamic>> itemRequest = [];
  TextEditingController qtyController = TextEditingController();
  String _selectedVal = "2";

  @override
  void initState() {
    qtyController.text = "0";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateFormat date = DateFormat('dd MMMM yyyy');
    List itemList = Provider.of<ItemList>(context).items;
    String brand = itemList[int.parse(_selectedVal)][2].toString();
    String type = itemList[int.parse(_selectedVal)][3].toString();
    String desc = itemList[int.parse(_selectedVal)][4].toString();
    String user = Provider.of<User>(context).user;

    return Scaffold(
      appBar: AppBar(title: const Text("Request Forms")),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 30.0,
          horizontal: MediaQuery.of(context).size.width * 0.1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tanggal Permintaan",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              date.format(now),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 12),
            Text(
              "Nama Pengguna",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            Text(
              user,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 20),
            itemRequest.isNotEmpty
                ? SizedBox(
                    height: itemRequest.length * 55,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: itemRequest.length,
                      itemBuilder: (context, index) {
                        List item = itemList
                            .where((e) => e[0] == itemRequest[index]['id'])
                            .toList();
                        debugPrint(item.toString());
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item[0][1],
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (itemRequest[index]['qty'] > 0) {
                                          itemRequest[index]['qty']--;
                                        }
                                      });
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    itemRequest[index]['qty'].toString(),
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        itemRequest[index]['qty']++;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  MyPageButton(
                                    text: "DELETE",
                                    onPressed: () {
                                      setState(() {
                                        itemRequest.removeAt(index);
                                      });
                                    },
                                    width: 1,
                                    height: 40,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Container(),
            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StatefulBuilder(builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Items",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.5,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      DropdownButtonFormField(
                                        iconSize: 46,
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                            ),
                                          ),
                                        ),
                                        value: _selectedVal,
                                        items: itemList
                                            .map(
                                              (e) => DropdownMenuItem<String>(
                                                value: e[0].toString(),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      e[1],
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          e[2],
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        Text(
                                                          e[4],
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        elevation: 0,
                                        focusColor: Colors.transparent,
                                        onChanged: (String? val) {
                                          setState(() {
                                            _selectedVal = val!;
                                            brand = itemList[
                                                    int.parse(_selectedVal)][2]
                                                .toString();
                                            type = itemList[
                                                    int.parse(_selectedVal)][3]
                                                .toString();
                                            desc = itemList[
                                                    int.parse(_selectedVal)][4]
                                                .toString();
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Brand",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        brand.isEmpty ? "-" : brand,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1.5,
                                        color: Color.fromARGB(255, 5, 44, 96),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Item Type",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        type.isEmpty ? "-" : type,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const Divider(thickness: 1.5),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Description",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        desc.isEmpty ? "-" : desc,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const Divider(thickness: 1.5),
                                      Text(
                                        "Qty",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: qtyController,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]'),
                                          ),
                                        ],
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                                const Spacer(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: MyButton(
                                        text: "CANCEL",
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: MyButton(
                                        text: "CONFIRM",
                                        onPressed: () {
                                          setState(() {
                                            bool itemExists = itemRequest.any(
                                              (element) =>
                                                  element['id'] ==
                                                  int.parse(_selectedVal),
                                            );
                                            if (itemExists) {
                                              int itemIndex =
                                                  itemRequest.indexWhere(
                                                (item) =>
                                                    item['id'] ==
                                                    int.parse(_selectedVal),
                                              );
                                              debugPrint(itemIndex.toString());
                                              itemRequest[itemIndex]['qty'] +=
                                                  int.parse(qtyController.text);
                                            } else {
                                              itemRequest.add({
                                                "id": int.parse(_selectedVal),
                                                "qty": int.parse(
                                                    qtyController.text),
                                              });
                                            }
                                          });
                                          qtyController.text = "0";
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      color: const Color.fromARGB(255, 5, 44, 96),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: MyButton(
                    text: "CANCEL",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: MyButton(
                    text: "CONFIRM",
                    onPressed: () {
                      if (itemRequest.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 100),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            content: Text("Item Has not been added",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer)),
                            duration: const Duration(seconds: 1),
                            // dismissDirection: DismissDirection.none,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else {
                        Provider.of<UserOrder>(context, listen: false).addOrder(
                            user: user,
                            itemRequest: itemRequest,
                            date: date.format(now));
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
