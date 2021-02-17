import 'package:flutter/material.dart';

class CountryProvider with ChangeNotifier {
  List<String> _items = [

  ];

  String _selectedItem;

  List<String> get items => _items;

  String get selected => _selectedItem;

  void setSelectedItem(String s) {
    _selectedItem = s;
    notifyListeners();
  }
}
