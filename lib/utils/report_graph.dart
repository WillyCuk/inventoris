import 'package:atk_inventoris/provider/itemlist.dart';
import 'package:atk_inventoris/provider/monthlyreport.dart';
import 'package:atk_inventoris/provider/userorder.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class ReportGraph extends StatefulWidget {
  const ReportGraph({super.key});

  @override
  State<ReportGraph> createState() => _ReportGraphState();
}

class _ReportGraphState extends State<ReportGraph> {
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
    final itemName = itemList[int.parse(_selectedVal)][1].toLowerCase();
    return monthlyList.where((monthData) {
      final itemMatches =
          itemName == monthData['item'].toString().toLowerCase();
      final yearMatches =
          !isFilterYear || _selectedYear == monthData['year'].toString();

      return itemMatches && yearMatches;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double maxValue = 100;
    double maxChartValue = ((maxValue ~/ 20) + 1) * 20;
    itemList = Provider.of<ItemList>(context).items;
    brand = itemList[int.parse(_selectedVal)][2].toString();
    type = itemList[int.parse(_selectedVal)][3].toString();
    desc = itemList[int.parse(_selectedVal)][4].toString();

    List<Map<String, dynamic>> monthList =
        Provider.of<MonthlyReport>(context).monthlyList;
    List<Map<String, dynamic>> filteredMonthlyList =
        _filterMonthlyList(monthList);

    final List<BarChartGroupData> barChartGroups = [
      for (int i = 0; i < 12; i++)
        BarChartGroupData(x: i, barRods: [
          BarChartRodData(
              toY: filteredMonthlyList.isNotEmpty &&
                      filteredMonthlyList[0]['data'].length > i
                  ? filteredMonthlyList[0]['data'][i]['qty'].toDouble()
                  : 0,
              color: Theme.of(context).colorScheme.primary,
              width: 15),
        ]),
    ];

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

    return Padding(
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
                          color: Theme.of(context).dividerTheme.color!),
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
                          color: Theme.of(context).dividerTheme.color!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).dividerTheme.color!),
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
          SizedBox(
              height: 400,
              width: 600,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: BarChart(BarChartData(
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipRoundedRadius: 20,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          String value = rod.toY.toString();
                          return BarTooltipItem(
                            value,
                            const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          );
                        },
                      ),
                    ),
                    barGroups: barChartGroups,
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(
                      show: true,
                      horizontalInterval: 20,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Theme.of(context).dividerTheme.color!,
                        strokeWidth: 0.5,
                      ),
                      getDrawingVerticalLine: (value) => FlLine(
                        color: Theme.of(context).dividerTheme.color!,
                        strokeWidth: 0.5,
                      ),
                    ),
                    titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 20,
                            getTitlesWidget: (value, meta) {
                              if (value % 20 == 0 && value <= maxChartValue) {
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Text(
                                      value.toInt().toString(),
                                      style: const TextStyle(
                                        fontSize: 10,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                const style = TextStyle(
                                  fontSize: 14,
                                );
                                Widget text;
                                switch (value.toInt()) {
                                  case 0:
                                    text = const Text('Jan', style: style);
                                    break;
                                  case 1:
                                    text = const Text('Feb', style: style);
                                    break;
                                  case 2:
                                    text = const Text('Mar', style: style);
                                    break;
                                  case 3:
                                    text = const Text('Apr', style: style);
                                    break;
                                  case 4:
                                    text = const Text('May', style: style);
                                    break;
                                  case 5:
                                    text = const Text('Jun', style: style);
                                    break;
                                  case 6:
                                    text = const Text('Jul', style: style);
                                    break;
                                  case 7:
                                    text = const Text('Aug', style: style);
                                    break;
                                  case 8:
                                    text = const Text('Sep', style: style);
                                    break;
                                  case 9:
                                    text = const Text('Oct', style: style);
                                    break;
                                  case 10:
                                    text = const Text('Nov', style: style);
                                    break;
                                  case 11:
                                    text = const Text('Dec', style: style);
                                    break;
                                  default:
                                    text = const Text('', style: style);
                                    break;
                                }
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  space: 4,
                                  child: text,
                                );
                              }),
                        )))),
              )),
        ],
      ),
    );
  }
}
