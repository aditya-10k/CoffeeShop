import 'dart:convert';
import 'dart:math';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'model.dart';


class Cartfunc extends ChangeNotifier {
  List<BeverageModel> _items = [];
final Map<BeverageModel, int> _usercart = {};
  final String lynk = 'https://unicode-flutter-lp-new-final.onrender.com/get_all_products';
  List<int> priceList = [100, 340, 220, 430, 500, 600, 120, 245, 189];
  List<BeverageModel> get items => _items;
  Map<BeverageModel, int> get userCart => _usercart;


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


void additem(BuildContext context, BeverageModel drink) {
  if (_usercart.containsKey(drink)) {
    _usercart[drink] = _usercart[drink]! + 1;
  } else {
    _usercart[drink] = 1;
  }
  notifyListeners();
  
  final quantity = _usercart[drink];
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        '${drink.name} added to cart. Quantity: $quantity',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Color(0xFF00704A),
      duration: Duration(seconds: 2),
    ),
  );
  print('Item added');
}

  void removeitem(BeverageModel drink) {
    if (_usercart.containsKey(drink)) {
      if (_usercart[drink]! > 1) {
        _usercart[drink] = _usercart[drink]! - 1;
      } else {
        _usercart.remove(drink);
      }
    }
    notifyListeners();
  }

  void clearCart() {
    _usercart.clear(); // Clears all items from the cart
    notifyListeners(); // Notifies listeners that the cart has been cleared
  }


  // double get totalCost {
  //   return _usercart.fold(0, (sum, item) => sum + (item.price ?? 0));
  // }
}
