import 'package:atk_inventoris/provider/maintenance.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MaintenanceModeToggle extends StatefulWidget {
  const MaintenanceModeToggle({super.key});

  @override
  _MaintenanceModeToggleState createState() => _MaintenanceModeToggleState();
}

class _MaintenanceModeToggleState extends State<MaintenanceModeToggle> {
  final TextEditingController _regardController = TextEditingController();

  void _showConfirmationDialog(
      BuildContext context, MaintenanceProvider provider) {
    _regardController.clear();
    String? errorText;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              icon: Icon(
                Icons.warning,
                color: Theme.of(context).colorScheme.primary,
                size: 40,
              ),
              title: Text(
                "Confirm Action",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    provider.isMaintenance
                        ? "Are you sure you want to disable maintenance mode?"
                        : "Are you sure you want to enable maintenance mode?",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (!provider.isMaintenance)
                    TextField(
                      controller: _regardController,
                      decoration: InputDecoration(
                        labelText: "Regard for Maintenance",
                        errorText: errorText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (!provider.isMaintenance &&
                        _regardController.text.isEmpty) {
                      setState(() {
                        errorText = "Regard for Maintenance is required.";
                      });
                      return;
                    }
                    provider.toggleMaintenance(_regardController.text);
                    Navigator.of(context).pop();
                    _showSuccessDialog(context, provider.isMaintenance);
                  },
                  child: Text(
                    "Confirm",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, bool isActivated) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: Icon(
            Icons.check_circle,
            color: Theme.of(context).colorScheme.primary,
            size: 40,
          ),
          title: Text(
            "Success",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          content: Text(
            isActivated
                ? "Maintenance mode has been enabled."
                : "Maintenance mode has been disabled.",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final maintenanceModeProvider = Provider.of<MaintenanceProvider>(context);

    return Card(
      color: maintenanceModeProvider.isMaintenance
          ? Colors.red[300]
          : Colors.green[300],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Maintenance Mode',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Switch(
                  activeColor: Theme.of(context).colorScheme.primary,
                  inactiveTrackColor: Colors.grey,
                  value: maintenanceModeProvider.isMaintenance,
                  onChanged: (value) {
                    _showConfirmationDialog(context, maintenanceModeProvider);
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              maintenanceModeProvider.isMaintenance
                  ? 'Maintenance Mode is Active for ${maintenanceModeProvider.activeDuration.inHours}h ${maintenanceModeProvider.activeDuration.inMinutes % 60}m ${maintenanceModeProvider.activeDuration.inSeconds % 60}s'
                  : 'Maintenance Mode is Inactive',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
