
import 'package:atk_inventoris/router/routernamed.dart';
import 'package:atk_inventoris/utils/custdashboardtile.dart';
import 'package:atk_inventoris/utils/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardCSPage extends StatefulWidget {
  const DashboardCSPage({super.key});

  @override
  State<DashboardCSPage> createState() => _DashboardCSPageState();
}

class _DashboardCSPageState extends State<DashboardCSPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      drawer: const MyCSDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome CS',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'What do you want to do?',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            CustDashboardTile(
                route: RouterName.custComplaint,
                menuName: 'View Complaint',
                menuIcon: const Icon(Icons.remove_red_eye)),
            CustDashboardTile(
                route: RouterName.maintenanceService,
                menuName: 'Maintenance Service',
                menuIcon: const Icon(Icons.timer_sharp)),
            CustDashboardTile(
                route: RouterName.maintenanceHistory,
                menuName: 'Maintenance History',
                menuIcon: const Icon(Icons.history)),
          ],
        ),
      ),
    );
  }
}
