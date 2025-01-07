import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model.dart'; 

class Cartfunc extends ChangeNotifier {
  List<BeverageModel> _items = [];
  List<BeverageModel> _usercart = [];
  final String lynk = 'https://unicode-flutter-lp-new-final.onrender.com/get_all_products';
  List<int> priceList = [100, 340, 220, 430, 500, 600, 120, 245, 189];
  List<BeverageModel> get items => _items;
  List<BeverageModel> get usercart => _usercart;

  Future<void> fetchItems() async {
    final response = await http.get(Uri.parse(lynk));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      _items = List<BeverageModel>.from(
        data.map((item) => BeverageModel.fromJson(item))
      );
      notifyListeners();
    }
  }

  int getRandomPrice() {
    Random random = Random();
    int index = random.nextInt(priceList.length);
    return priceList[index];
  }

  void additem(BeverageModel drink) {

    _usercart.add(drink);
    
    notifyListeners();
    print('item added');
  }

  void removeitem(BeverageModel drink) {
    _usercart.remove(drink);
    notifyListeners();
  }

  // double get totalCost {
  //   return _usercart.fold(0, (sum, item) => sum + (item.price ?? 0));
  // }
}
