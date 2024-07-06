import 'package:flutter/material.dart';

class MonthlyReport extends ChangeNotifier {
  final List<Map<String, dynamic>> _monthlyList = [
    {
      "item": "pulpen",
      "year": "2022",
      "data": [
        {
          "month": "January",
          "qty": 7,
        },
        {
          "month": "February",
          "qty": 34,
        },
        {
          "month": "March",
          "qty": 2,
        },
        {
          "month": "April",
          "qty": 13,
        },
        {
          "month": "May",
          "qty": 32,
        },
        {
          "month": "June",
          "qty": 14,
        },
        {
          "month": "July",
          "qty": 25,
        },
        {
          "month": "August",
          "qty": 12,
        },
        {
          "month": "September",
          "qty": 5,
        },
        {
          "month": "October",
          "qty": 17,
        },
        {
          "month": "November",
          "qty": 23,
        },
        {
          "month": "December",
          "qty": 11,
        },
      ]
    },
    {
      "item": "pulpen",
      "year": "2024",
      "data": [
        {
          "month": "January",
          "qty": 10,
        },
        {
          "month": "February",
          "qty": 20,
        },
        {
          "month": "March",
          "qty": 30,
        },
        {
          "month": "April",
          "qty": 40,
        },
        {
          "month": "May",
          "qty": 0,
        },
        {
          "month": "June",
          "qty": 20,
        },
        {
          "month": "July",
          "qty": 30,
        },
        {
          "month": "August",
          "qty": 50,
        },
        {
          "month": "September",
          "qty": 10,
        },
        {
          "month": "October",
          "qty": 20,
        },
        {
          "month": "November",
          "qty": 50,
        },
        {
          "month": "December",
          "qty": 20,
        },
      ]
    },
    {
      "item": "kertas A4",
      "year": "2024",
      "data": [
        {
          "month": "January",
          "qty": 43,
        },
        {
          "month": "February",
          "qty": 23,
        },
        {
          "month": "March",
          "qty": 52,
        },
        {
          "month": "April",
          "qty": 13,
        },
        {
          "month": "May",
          "qty": 56,
        },
        {
          "month": "June",
          "qty": 42,
        },
        {
          "month": "July",
          "qty": 25,
        },
        {
          "month": "August",
          "qty": 36,
        },
        {
          "month": "September",
          "qty": 32,
        },
        {
          "month": "October",
          "qty": 24,
        },
        {
          "month": "November",
          "qty": 53,
        },
        {
          "month": "December",
          "qty": 43,
        },
      ]
    },
  ];

  List<Map<String, dynamic>> get monthlyList => _monthlyList;
  int get id => _monthlyList.length;

  void addOrder({required String month, required int num}) {
    _monthlyList.add({"month": month, "qty": num});
    debugPrint(_monthlyList.toString());
    notifyListeners();
  }
}
