import 'package:coffee/pages/auth.dart';
import 'package:coffee/pages/in-app%20pages/CartPage.dart';
import 'package:coffee/pages/in-app%20pages/GenPage.dart';
import 'package:coffee/pages/in-app%20pages/MenuPage.dart';
import 'package:coffee/pages/in-app%20pages/OfferPage.dart';
import 'package:coffee/pages/in-app%20pages/ProfilePage.dart';
import 'package:coffee/pages/loginpage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
   Homepage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int curindex = 0;

  List <Widget> pagewidgets = 
  [
    genpage(),
    Menupage(),
    offerpage(),
    cartpage(),
    ProfilePage(),

  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 208, 184, 168),
        appBar: AppBar(

          backgroundColor: const Color.fromARGB(255, 208, 184, 168),
          elevation: 0,
          
        ),
        drawer: Drawer(
          backgroundColor:Color.fromARGB(255, 63, 45, 45) ,
          child: ListView(
            children: [
              DrawerHeader(child: Center(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    opacity: 0.8,
                    image: AssetImage('assets/download (2).png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              )
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app_outlined,color: Colors.white70,),
                title: Text('Logout',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20
                ),),
                onTap: () async {
                  await widget.signOut();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                },
              )
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
                height: 55,
                onTap: (index)
                {
                  setState(() {
                    curindex = index;
                  });
                },
                
                backgroundColor: const Color.fromARGB(255, 208, 184, 168),
                color: Color.fromARGB(255, 63, 45, 45) ,
                animationDuration: Duration(milliseconds: 300),
                
                items: [
              
               Image.asset('assets/Con Panna.png' ,height: 35, alignment: Alignment.bottomCenter,), 
               Image.asset('assets/menu board.png' ,height: 35,),
               Image.asset('assets/download.png', height: 35,),
               Image.asset('assets/download (1).png', height: 35,),
               Image.asset('assets/sss.png', height: 35,)
                
                
              ]),

              body: SafeArea(child: pagewidgets[curindex]),
            ),
          );
    
  }
}