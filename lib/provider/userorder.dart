import 'package:flutter/material.dart';

class UserOrder extends ChangeNotifier {
  final List<Map<String, dynamic>> _userOrderList = [
    {
      "user": "username",
      "order": {
        "id": 1,
        "status": "Waiting",
        "retrieve_admin": null,
        "retrieve_user": null,
        "message": "",
        "date": '23 April 2021',
        "send_date": "",
        "items": [
          {"id": 2, "qty": 21},
          {"id": 0, "qty": 123}
        ]
      }
    },
    {
      "user": "cecilia",
      "order": {
        "id": 2,
        "status": "Approved",
        "retrieve_admin": false,
        "retrieve_user": null,
        "message": "",
        "date": '24 May 2022',
        "send_date": "",
        "items": [
          {"id": 2, "qty": 21},
          {"id": 3, "qty": 211},
          {"id": 1, "qty": 221},
        ]
      }
    },
    {
      "user": "cecilia",
      "order": {
        "id": 3,
        "status": "Waiting",
        "retrieve_admin": null,
        "retrieve_user": null,
        "message": "",
        "date": '23 June 2023',
        "send_date": "",
        "items": [
          {"id": 2, "qty": 21},
        ]
      }
    },
    {
      "user": "cecilia",
      "order": {
        "id": 4,
        "status": "Waiting",
        "retrieve_admin": null,
        "retrieve_user": null,
        "message": "",
        "date": '23 June 2023',
        "send_date": "",
        "items": [
          {"id": 2, "qty": 21},
        ]
      }
    },
    {
      "user": "jason",
      "order": {
        "id": 5,
        "status": "Approved",
        "retrieve_admin": true,
        "retrieve_user": false,
        "message": "",
        "date": '23 April 2024',
        "send_date": "25 April 2024",
        "items": [
          {"id": 2, "qty": 21},
        ]
      }
    },
  ];

  List<Map<String, dynamic>> get userOrderList => _userOrderList;
  int get id => _userOrderList.length;

  void addOrder(
      {required String user, required List itemRequest, required String date}) {
    _userOrderList.add({
      "user": user,
      "order": {
        "id": id + 1,
        "status": "Waiting",
        "retrieve_admin": null,
        "retrieve_user": null,
        "message": "",
        "date": date,
        "send_date": "",
        "items": itemRequest
      }
    });
    debugPrint(_userOrderList.toString());
    notifyListeners();
  }

  void changeStatusApproved({required int index}) {
    int orderIndex =
        _userOrderList.indexWhere((element) => element["order"]['id'] == index);
    _userOrderList[orderIndex]["order"]["status"] = "Approved";
    _userOrderList[orderIndex]["order"]["retrieve_admin"] = false;
    notifyListeners();
  }

  void changeStatusRejected({required int index, required String message}) {
    int orderIndex =
        _userOrderList.indexWhere((element) => element["order"]['id'] == index);
    _userOrderList[orderIndex]["order"]["message"] = message;
    _userOrderList[orderIndex]["order"]["status"] = "Rejected";
    notifyListeners();
  }

  void changeRetrieveStatus({required int index}) {
    int orderIndex =
        _userOrderList.indexWhere((element) => element["order"]['id'] == index);
    _userOrderList[orderIndex]["order"]["retrieve_admin"] = true;
    _userOrderList[orderIndex]["order"]["retrieve_user"] = false;
    notifyListeners();
  }

  void changeRetrieveUserStatus({required int index}) {
    int orderIndex =
        _userOrderList.indexWhere((element) => element["order"]['id'] == index);

    _userOrderList[orderIndex]["order"]["retrieve_user"] = true;
    notifyListeners();
  }
}
