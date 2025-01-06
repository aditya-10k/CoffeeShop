import 'package:coffee/UserRepo.dart';
import 'package:coffee/pages/in-app%20pages/CartPage.dart';
import 'package:coffee/pages/in-app%20pages/GenPage.dart';
import 'package:coffee/pages/in-app%20pages/ProfilePage.dart';
import 'package:coffee/workingcomps/drinksdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icons_plus/icons_plus.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int currentindex = 0;
  late String userId ; 
  List<Widget> pagewidgets = [];

 final PageController _controller = PageController(initialPage: 0);

 

 void initState() {
    super.initState();

    // Fetch the userId when the page loads
    userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    // Initialize pagewidgets with ProfilePage receiving userId
    pagewidgets = [
      GenPage(),
      Drinksdata(),
      CartPage(),
      Profilepage(), // Pass userId to ProfilePage
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

           body:  
            PageView(
        children: pagewidgets,
        controller: _controller ,
        onPageChanged: (index){
          setState(() {
            currentindex = index;
            
          
          });
        },
      ),
         
          bottomNavigationBar: 
               Container(
                height: 70,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                 child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                   child: GNav(
                    gap: 5,
                    tabBackgroundColor: Color.fromARGB(255, 0, 85, 55),
                    textSize: 12,
                    activeColor: Colors.white,
                    color: Colors.grey.shade400,
                    backgroundColor: Color.fromARGB(255, 0, 112, 72),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    selectedIndex: currentindex,
                    duration: Duration(milliseconds: 400),
                    onTabChange: (index) {
                      setState(() {
                        currentindex = index;
                        _controller.jumpToPage(index);
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
                          width: 40,
                        ),
                      ),
                      GButton(
                        icon: Icons.menu,
                        text: 'Menu',
                        iconSize: 30,
                        leading: Image.asset(
                          'lib/workingcomps/imgloc/menu.png',
                          height: 40,
                          width: 40,
                        ),
                      ),
                      GButton(
                        icon: Icons.shopping_bag_outlined,
                        text: 'Cart',
                        iconSize: 30,
                        leading: Image.asset(
                          'lib/workingcomps/imgloc/bag.png',
                          height: 40,
                          width: 40,
                        ),
                      ),
                      GButton(
                        icon: Bootstrap.person_fill,
                        text: 'Profile',
                        iconSize: 38,
                        iconActiveColor: Colors.white,
                        iconColor: Colors.white,
                      ),
                    ],
                                 ),
                 ),
               ),
         
       
           
            
          
        
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}
