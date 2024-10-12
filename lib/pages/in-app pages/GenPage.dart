import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee/workingcomps/drinksdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenPage extends StatefulWidget {
  const GenPage({super.key});

  @override
  State<GenPage> createState() => _GenPageState();
}

class _GenPageState extends State<GenPage> {
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

  List<String> imgsrcc = [
    "assets/21667-easy-iced-coffee-ddmfs-4x3-0093-7becf3932bd64ed7b594d46c02d0889f.jpg",
    "assets/bagel-recipe.jpg",
    "assets/Coffee-Frappe.jpg",
    "assets/EBNfrdjX4AIGEq-.jpg",
    "assets/oolong-iced-tea-recipe-766389-hero-07-1cc310d9aa8f497b8f78bb7021fd0e5c.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Welcome message container
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: screenWidth - 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 0, 112, 72),
                  ),
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Text(
                    user != null && user!.displayName != null
                        ? "Welcome, ${user!.displayName}!"
                        : "Welcome Guest!",
                    style: GoogleFonts.robotoSlab(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Serving text
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
            child: Text(
              "We serve",
              textAlign: TextAlign.left,
              style: GoogleFonts.robotoSlab(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),

          // Carousel slider
          Container(
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 1.0,
                  autoPlay: true,
                ),
                items: imgsrcc.map((img) {
                  return Builder(
                    builder: (BuildContext context) {
                      return InkWell(
                        child: Image.asset(
                          img,
                          fit: BoxFit.cover,
                          width: screenWidth - 20,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),

           SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
            child: Text(
              "What would you like?",
              textAlign: TextAlign.left,
              style: GoogleFonts.robotoSlab(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          SizedBox(height: 10,),
          Drinksdata(),
          
        ],
      ),
    );
  }
}
