
import 'package:atk_inventoris/models/complaint.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerComplaint extends ChangeNotifier {
  String _name = "Test";
  String _email = "Test";
  bool _isMaintenance = true;
  final TextEditingController complaintController = TextEditingController();

  List<Complaint> _complaints = [
    Complaint(
        name: "Test",
        email: "Test",
        date: DateTime.now().toString(),
        complaint: "Test"),
    Complaint(
        name: "Test1",
        email: "Test2",
        date: DateTime.now().toString(),
        complaint: "lorem ipsum ghsdoiaiogdhs ig saiogh siogidsah gogd aspg erop jvdsaog djsaopg asog ujwss goasda opgopw jgodpasgop dsjopds pgjfdsaopf podsj f podasfop jagwog jdlasjgap"),
  ];
  List<Complaint> get complaints => _complaints;

  String get name => _name;

  String get email => _email;

  String get complain => complaintController.text;

  bool get isMaintenance => _isMaintenance;

  void setUserEmail(String name, String email) {
    _name = name;
    _email = email;
    notifyListeners();
  }

  void addComplaint() {
    final newComplaint = Complaint(
        name: _name,
        email: _email,
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
        complaint: complaintController.text);

    _complaints.add(newComplaint);
    notifyListeners();
    complaintController.clear();
  }

   void resolveComplaint(Complaint complaint) {
    _complaints.remove(complaint);
    notifyListeners();
  }

  Complaint getComplaint() {
    return Complaint(
        name: _name,
        email: _email,
        date: DateTime.now().toString(),
        complaint: complaintController.text);
  }
}
