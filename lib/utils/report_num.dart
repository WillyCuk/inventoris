
import 'package:atk_inventoris/provider/itemlist.dart';
import 'package:atk_inventoris/provider/monthlyreport.dart';
import 'package:atk_inventoris/provider/userorder.dart';
import 'package:atk_inventoris/utils/monthtile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class ReportNum extends StatefulWidget {
  const ReportNum({super.key});

  @override
  State<ReportNum> createState() => _ReportNumState();
}

class _ReportNumState extends State<ReportNum> {
  bool isFilterYear = true;
  String _selectedVal = "0";
  String? _selectedYear;
  late List itemList;
  late String brand;
  late String type;
  late String desc;

  @override
  void initState() {
    super.initState();
    _selectedYear = DateTime.now().year.toString();
  }

  List<Map<String, dynamic>> _filterMonthlyList(
      List<Map<String, dynamic>> monthlyList) {
    return monthlyList
        .where((monthData) {
          final itemName = itemList[int.parse(_selectedVal)][1].toLowerCase();
          final itemMatches =
              itemName == monthData['item'].toString().toLowerCase();
          final yearMatches =
              !isFilterYear || _selectedYear == monthData['year'].toString();

          return itemMatches && yearMatches;
        })
        .expand((monthData) => monthData['data'])
        .toList()
        .cast<Map<String, dynamic>>();
  }

  @override
  Widget build(BuildContext context) {
    itemList = Provider.of<ItemList>(context).items;
    brand = itemList[int.parse(_selectedVal)][2].toString();
    type = itemList[int.parse(_selectedVal)][3].toString();
    desc = itemList[int.parse(_selectedVal)][4].toString();

    List<Map<String, dynamic>> monthlyList =
        Provider.of<MonthlyReport>(context).monthlyList;
    List<Map<String, dynamic>> filteredMonthlyList =
        _filterMonthlyList(monthlyList);

    List<Map<String, dynamic>> allOrder = Provider.of<UserOrder>(context)
        .userOrderList
        .where((element) =>
            element["order"]["status"] == "Approved" ||
            element["order"]["status"] == "Rejected")
        .toList();

    List<String> uniqueYears = allOrder
        .map<String>((order) {
          String date = order['order']['date'];
          return date.split(' ')[2];
        })
        .toSet()
        .toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    iconSize: 46,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).dividerTheme.color!,
                        ),
                      ),
                    ),
                    value: _selectedVal,
                    items: itemList
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e[0].toString(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e[1],
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      e[2],
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      e[4],
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
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
                        brand = itemList[int.parse(_selectedVal)][2].toString();
                        type = itemList[int.parse(_selectedVal)][3].toString();
                        desc = itemList[int.parse(_selectedVal)][4].toString();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    hint: Text(
                      "Filter by year",
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    iconSize: 18,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).dividerTheme.color!,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).dividerTheme.color!,
                        ),
                      ),
                    ),
                    value: _selectedYear,
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
                        _selectedYear = val!;
                        isFilterYear = true;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredMonthlyList.length,
                itemBuilder: (context, index) {
                  final monthData = filteredMonthlyList[index];
                  return MonthTile(
                    month: monthData['month'],
                    qty: monthData['qty'].toString(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
