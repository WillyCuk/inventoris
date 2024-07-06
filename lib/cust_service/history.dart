import 'package:atk_inventoris/provider/maintenance.dart';
import 'package:atk_inventoris/utils/maintenance_record_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MaintenanceHistoryPage extends StatefulWidget {
  const MaintenanceHistoryPage({super.key});

  @override
  State<MaintenanceHistoryPage> createState() => _MaintenanceHistoryPageState();
}

class _MaintenanceHistoryPageState extends State<MaintenanceHistoryPage> {
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  bool _dateFilterApplied = false;

  void _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      helpText: 'Select Date Range',
      cancelText: 'Clear',
      confirmText: 'Apply',
      locale: const Locale('en', 'US'),
      context: context,
      barrierColor: Theme.of(context).primaryColor.withOpacity(0.5),
      initialDateRange: _selectedStartDate != null && _selectedEndDate != null
          ? DateTimeRange(start: _selectedStartDate!, end: _selectedEndDate!)
          : null,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedStartDate = picked.start;
        _selectedEndDate = picked.end;
        _dateFilterApplied = true;
      });
    }
  }

  void _clearDateFilter() {
    setState(() {
      _dateFilterApplied = false;
      _selectedStartDate = null;
      _selectedEndDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final maintenanceProvider = Provider.of<MaintenanceProvider>(context);
    final maintenanceHistory = _dateFilterApplied
        ? maintenanceProvider.maintenanceHistory.where((record) {
            final startDate = record.startTime;
            return startDate.isAfter(_selectedStartDate!) &&
                startDate
                    .isBefore(_selectedEndDate!.add(const Duration(days: 1)));
          }).toList()
        : maintenanceProvider.maintenanceHistory;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maintenance History'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                  onPressed: () => _selectDateRange(context),
                  child: Text(
                    'Select Date Range',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
                if (_dateFilterApplied)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                    ),
                    onPressed: _clearDateFilter,
                    child: Text(
                      'Clear Filter',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: maintenanceHistory.isEmpty
                ? Center(
                    child: Text(
                      _dateFilterApplied
                          ? 'No records found for selected date range.'
                          : 'No maintenance history available.',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    // Display the list from newest to oldest
                    padding: const EdgeInsets.all(16),
                    itemCount: maintenanceHistory.length,
                    itemBuilder: (context, index) {
                      final record = maintenanceHistory[index];
                      return MaintenanceRecordCard(record: record);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
