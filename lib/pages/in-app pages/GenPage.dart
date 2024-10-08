import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class genpage extends StatefulWidget {
  const genpage({super.key});

  @override
  State<genpage> createState() => _genpageState();
}

class _genpageState extends State<genpage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

 
  Future<void> _loadUser() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      await currentUser.reload(); 
      setState(() {
        user = _auth.currentUser; 
      });
    }
  }
  List <Color> cl =[ Colors.black /*,Color.fromARGB(255, 152, 112, 112)*/];
  List <String> imgsrcc = [
     "assets/21667-easy-iced-coffee-ddmfs-4x3-0093-7becf3932bd64ed7b594d46c02d0889f.jpg",
     "assets/bagel-recipe.jpg",
     "assets/Coffee-Frappe.jpg",
     "assets/EBNfrdjX4AIGEq-.jpg",
     "assets/oolong-iced-tea-recipe-766389-hero-07-1cc310d9aa8f497b8f78bb7021fd0e5c.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center ,
                    children:[ Container(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: 
                        user != null && user!.displayName != null
                          ? Text("Welcome , ${user!.displayName} !" ,
                          style: GoogleFonts.robotoSlab(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20-3
                          ),)
                          : Text("Welcome Guest!" ,
                          style: GoogleFonts.robotoSlab(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20-3
                          ),),
                      
                    ),
                    ]
                  ),

                  Container(
                    height: 200,
                    child: CarouselView(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                      itemExtent: MediaQuery.of(context).size.width-20, 
                      children: [
                        
                          
                        for(int i=0 ; i< imgsrcc.length ; i++)
                        InkWell(
                          child: Image.asset(imgsrcc[i],
                          fit: BoxFit.cover,

                          ),
                        ),
                        
                        ]
                      ),
                  )
        ],
      ),
    );
  }
}
