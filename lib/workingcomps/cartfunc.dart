import 'coffeelist.dart';
import 'package:flutter/material.dart';

class Cartfunc extends ChangeNotifier{

  final List<Coffeelist> _items = [
    Coffeelist(name: 'Bubble Tea', price: 200, imgadd: 'lib/workingcomps/imgloc/—Pngtree—bubble milk tea illustration_5359566.png'),
    Coffeelist(name: 'Green Tea Frappe', price: 230, imgadd: 'lib/workingcomps/imgloc/—Pngtree—green tea frappe_3984596.png'),
    Coffeelist(name: 'Cappuccino', price: 250, imgadd: 'lib/workingcomps/imgloc/coffee-cappuccino-drink-free-vector-removebg-preview.png'),
    Coffeelist(name: 'Caramel Macchiato', price: 260, imgadd: 'lib/workingcomps/imgloc/pngtree-caramel-macchiato-in-a-mug-png-image_2886000-removebg-preview.png'),
    Coffeelist(name: 'Cheesecake', price: 300, imgadd: 'lib/workingcomps/imgloc/pngtree-cheesecake-with-strawberry-jelly-and-chocolate-png-image_3919394-removebg-preview.png'),
    Coffeelist(name: 'Croissant', price: 250, imgadd: 'lib/workingcomps/imgloc/pngtree-delicious-croissant-vector-png-image_4560917-removebg-preview.png'),
    Coffeelist(name: 'Bagel', price: 250, imgadd: 'lib/workingcomps/imgloc/bagel.png'),
    Coffeelist(name: 'Ice Coffee', price: 350, imgadd: 'lib/workingcomps/imgloc/pngtree-ice-coffee-vector-illustration-png-image_3926492-removebg-preview.png'),
  ];

  List<Coffeelist> _usercart =[];

  List<Coffeelist> get items => _items;

  List<Coffeelist> get usercart => _usercart;

  void additem(Coffeelist coffee)
  {
    _usercart.add(coffee);
    notifyListeners();
  }

  void removeitem(Coffeelist coffee)
  {
    _usercart.remove(coffee);
    notifyListeners();
  }
}

