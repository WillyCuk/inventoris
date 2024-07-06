import 'dart:async';
import 'package:atk_inventoris/models/maintenance_record.dart';
import 'package:flutter/material.dart';

class MaintenanceProvider with ChangeNotifier {
  bool _isMaintenance = false;
  DateTime? _maintenanceStartTime;
  Timer? _timer;
  Duration _activeDuration = Duration.zero;
  final List<MaintenanceRecord> _maintenanceHistory = [
    //create a initial record example
    MaintenanceRecord(
      regard: 'Maintenance V1.1 - Minor Bug on Add Item',
      startTime: DateTime(2024, 5, 26),
      endTime: DateTime(2024, 5, 28),
    ),
    MaintenanceRecord(
      regard: 'Maintenance V2.1 - Release New Feature - Customer Complaint',
      startTime: DateTime(2024, 6, 26),
      endTime: DateTime(2024, 5, 27),
    ),
  ];

  bool get isMaintenance => _isMaintenance;
  Duration get activeDuration => _activeDuration;
  List<MaintenanceRecord> get maintenanceHistory =>
      List.unmodifiable(_maintenanceHistory);

  void toggleMaintenance(String regard) {
    if (_isMaintenance) {
      // Stop maintenance mode
      final endTime = DateTime.now();
      final duration = endTime.difference(_maintenanceStartTime!);
      _maintenanceHistory.last.endTime = endTime;
      _maintenanceHistory.last.duration = duration;
      _isMaintenance = false;
      _timer?.cancel();
    } else {
      // Start maintenance mode
      _maintenanceStartTime = DateTime.now();
      _isMaintenance = true;
      _activeDuration = Duration.zero;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _activeDuration = DateTime.now().difference(_maintenanceStartTime!);
        notifyListeners();
      });
      _maintenanceHistory.add(
        MaintenanceRecord(
          regard: regard,
          startTime: _maintenanceStartTime!,
        ),
      );
    }
    notifyListeners();
  }
}
