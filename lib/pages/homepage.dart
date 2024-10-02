import 'package:coffee/pages/in-app%20pages/CartPage.dart';
import 'package:coffee/pages/in-app%20pages/GenPage.dart';
import 'package:coffee/pages/in-app%20pages/MenuPage.dart';
import 'package:coffee/pages/in-app%20pages/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icons_plus/icons_plus.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int curindex = 0;

  List<Widget> pagewidgets = [
    genpage(),
    Menupage(),
   
    cartpage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // Adding bottom navigation bar with constraints and layout fixes
        bottomNavigationBar: 
         
          
           ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 60, // Explicit height for the bottom navigation bar
              child: GNav(
                gap: 5,
                tabBackgroundColor: Color.fromARGB(255, 0, 85, 55),
                textSize: 12,
                activeColor: Colors.white,
                color: Colors.grey.shade400,
                backgroundColor: Color.fromARGB(255, 0, 112, 72),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                duration: Duration(milliseconds: 400),
                onTabChange: (index) {
                  setState(() {
                    curindex = index;
                  });
                },
                tabs: [
                  GButton(
                    icon: Icons.home_filled,
                    text: 'Home',
                    iconSize: 30,
                    leading: Image.asset(
                      'lib/workingcomps/imgloc/cup.png',
                      height: 40,
                    ),
                  ),
                  GButton(
                    icon: Icons.menu,
                    text: 'Menu',
                    iconSize: 30,
                    leading: Image.asset(
                      'lib/workingcomps/imgloc/menu.png',
                      height: 40,
                    ),
                  ),
                  GButton(
                    icon: Icons.shopping_bag_outlined,
                    text: 'Cart',
                    iconSize: 30,
                    leading: Image.asset(
                      'lib/workingcomps/imgloc/bag.png',
                      height: 40,
                    ),
                  ),
                  GButton(
                    icon: Bootstrap.person_circle,
                    text: 'Profile',
                    iconSize: 38,
                  ),
                ],
              ),
            ),
          ),
        
        // Properly laying out the body content with a column and expanded widget
        body: Column(
          children: [
            Expanded(
              child: pagewidgets[curindex], // Displaying the selected page
            ),
          ],
        ),
      ),
    );
  }
}