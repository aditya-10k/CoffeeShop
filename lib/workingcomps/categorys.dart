import 'package:coffee/pages/in-app pages/GenPage.dart';
import 'package:coffee/pages/loginpage.dart';
import 'package:flutter/material.dart';

// Define your category list as a class or a method.
class Category {
  final String image;
  final String link ;
  final String title;
  final Function(BuildContext) onTouch;

  Category({
    required this.link,
    required this.image,
    required this.title,
    required this.onTouch,
  });
}

List<Category> categories = [
   Category(
    link: 'https://unicode-flutter-lp.onrender.com/get_products_by_category?category=HOT%20BEVERAGES',
    image: 'https://athome.starbucks.com/sites/default/files/2021-06/1_CAH_CaffeMocha_Hdr_2880x16602.jpg', 
    title: 'HOT BEVERAGES',
    onTouch: (BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    },
  ),
   Category(
    link: 'https://unicode-flutter-lp.onrender.com/get_products_by_category?category=ICED%20BEVERAGES',
    image: 'https://athome.starbucks.com/sites/default/files/2024-05/OTHC-P00122733_COLD_ChocolateHazelnut_2880x1660_0.png', 
    title: 'ICED BEVERAGES',
    onTouch: (BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GenPage()),
      );
    },
  ),
   Category(
    link: 'https://unicode-flutter-lp.onrender.com/get_products_by_category?category=ADD-INS',
    image: 'https://athome.starbucks.com/sites/default/files/2022-05/1_CAH_IcedCoffeeSphere_Hdr_2880x1660_0.jpg', 
    title: 'ADD-INS',
    onTouch: (BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GenPage()),
      );
    },
  ),
   Category(
    link: 'https://unicode-flutter-lp.onrender.com/get_products_by_category?category=SYRUPS',
    image: 'https://athome.starbucks.com/sites/default/files/2023-01/CAH_SimpleSyrup_Hdr_2880x1660_0.jpg', 
    title: 'SYRUPS',
    onTouch: (BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GenPage()),
      );
    },
  ),
   Category(
    link: 'https://unicode-flutter-lp.onrender.com/get_products_by_category?category=FOOD',
    image: 'https://athome.starbucks.com/sites/default/files/2021-08/1_CAH_OvernightGrainBowl_Hdr_2880x1660_0.jpg', 
    title: 'FOOD',
    onTouch: (BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GenPage()),
      );
    },
  ),
];


