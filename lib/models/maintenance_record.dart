class MaintenanceRecord {
  final String regard;
  final DateTime startTime;
  DateTime? endTime;
  Duration? duration;

  MaintenanceRecord({
    required this.regard,
    required this.startTime,
    this.endTime,
    this.duration,
  });

  bool get isOngoing => endTime == null;
}
