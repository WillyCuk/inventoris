import 'package:atk_inventoris/utils/maintenance_toggle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaintenanceService extends StatelessWidget {
  const MaintenanceService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maintenance Service"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Maintenance Service",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const MaintenanceModeToggle()
          ],
        ),
      ),
    );
  }
}
