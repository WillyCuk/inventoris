import 'package:flutter/material.dart';

class ItemList extends ChangeNotifier {
  final List<List<dynamic>> _items = [
    [
      0,
      "Pulpen",
      "Boldliner",
      "",
      "",
      1000,
      "assets/boldliner.jpg",
      "Pcs"
    ],
    [
      1,
      "Kertas A4",
      "Bola Dunia",
      "",
      "",
      1000,
      "assets/bola_dunia.jpg",
      "Rim"
    ],
    [
      2,
      "Kertas F4",
      "Bola Dunia",
      "",
      "",
      1000,
      "assets/bola_dunia2.jpg",
      "Rim"
    ],
    [
      3,
      "Kertas B4",
      "Bola Dunia",
      "",
      "",
      250,
      "assets/logo.jpg",
      "Rim"
    ]
  ];

  List get items => _items;
  int get id => _items.length;

  int isItemList(List<dynamic> addItem) {
    for (int index = 0; index < _items.length; index++) {
      var item = _items[index];
      if (item[0] == addItem[0] && item[1] == addItem[1]) {
        return index;
      }
    }
    return -1;
  }

  void setQty({
    required int index,
    required int qty,
  }) {
    try {
      _items[index][5] = qty;
      debugPrint(_items[index].toString());
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  Future<void> addItem({
    required String itemName,
    required String itemBrand,
    required String itemType,
    required String itemDesc,
    required int itemQty,
    required dynamic itemImg,
    required String itemUnit,
  }) async {
    List<dynamic> newItem = [
      id,
      itemName,
      itemBrand,
      itemType,
      itemDesc,
      itemQty,
      itemImg,
      itemUnit
    ];
    try {
      int existingIndex = isItemList(newItem);
      if (existingIndex == -1) {
        _items.add(newItem);
        debugPrint(_items.toString());
      } else {
        // If the item exists, update its quantity by adding 100
        _items[existingIndex][5] += itemQty;
        debugPrint('Quantity updated for item at index $existingIndex');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  void retrieveQty({required List<Map<String, int>> item}) {
    try {
      for (var i in item) {
        var item = _items.firstWhere((element) => element[0] == i['id']);
        if (item[5] - i['qty']! < 0) {
          throw Exception('Insufficient quantity for ${item[1]}');
        } else {
          item[5] -= i['qty']!;
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
