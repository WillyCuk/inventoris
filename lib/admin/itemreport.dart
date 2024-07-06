
import 'package:atk_inventoris/utils/report_graph.dart';
import 'package:atk_inventoris/utils/report_num.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemReportAdmin extends StatefulWidget {
  const ItemReportAdmin({super.key});

  @override
  State<ItemReportAdmin> createState() => _ItemReportAdminState();
}

class _ItemReportAdminState extends State<ItemReportAdmin> {
  bool isFilterYear = false;
  late List monthList;
  late List itemList;
  late String brand;
  late String type;
  late String desc;

  final tabs = ['Text', 'Graph'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Item Report"),
          bottom: TabBar(indicatorColor: Colors.black, tabs: [
            for (final tab in tabs)
              Tab(
                child: Text(tab,
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.inversePrimary)),
              ),
          ]),
        ),
        body: const TabBarView(children: [ReportNum(), ReportGraph()]),
      ),
    );
  }
}
