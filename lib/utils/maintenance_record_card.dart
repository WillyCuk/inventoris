import 'package:atk_inventoris/models/maintenance_record.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MaintenanceRecordCard extends StatelessWidget {
  final MaintenanceRecord record;

  const MaintenanceRecordCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Theme.of(context).colorScheme.primaryContainer,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              record.regard,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start Time:',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            Text(
              DateFormat.yMMMMd().add_jm().format(record.startTime),
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            if (record.endTime != null) ...[
              const SizedBox(height: 8),
              Text(
                'End Time:',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              Text(
                DateFormat.yMMMMd().add_jm().format(record.endTime!),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
            if (record.duration != null) ...[
              const SizedBox(height: 8),
              Text(
                'Duration:',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              Text(
                '${record.duration!.inHours}h ${record.duration!.inMinutes.remainder(60)}m',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
            if (record.isOngoing) ...[
              const SizedBox(height: 8),
              Text(
                'Status: ONGOING',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
