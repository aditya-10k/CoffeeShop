import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee/workingcomps/drinksdata.dart';
import 'package:coffee/workingcomps/model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

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

    List<BeverageModel> drinklist = [];

  Future<List<BeverageModel>> getdrinkapi() async {
    final response = await http.get(Uri.parse('https://api.sampleapis.com/coffee/hot'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      drinklist.clear();
      for (Map i in data) {
        drinklist.add(BeverageModel.fromJson(i));
      }
      return drinklist;
    } else {
      return drinklist;
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
      body: SingleChildScrollView(
        child: Column(
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
            SizedBox(height: 30,),
        
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
            SizedBox(height: 30,),
        
            Padding(
              
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: getdrinkapi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  } else {
                    drinklist.shuffle();
                    return Container(
                      
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 0, 112, 72),
                      ),
              
                      child: Container(
                                    height: 200,
                                    width: screenWidth- 16,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        viewportFraction: 1.0,
                        autoPlay: true,
                      ),
                      items: drinklist.map((drink) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                                  drink.title!, 
                                                  style: GoogleFonts.robotoSlab(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  )),
                                                  SizedBox(height: 10,),
                                                  Container(
                                                    width: screenWidth/2 - 40,
                                                    child: Text(
                                                    drink.description!, 
                                                    style: GoogleFonts.robotoSlab(
                                                      color: Colors.white,
                                                      //fontWeight: FontWeight.bold,
                                                      fontSize: 10,
                                                    )
                                                    ),
                                                  )
                                                  ,
                                    ],
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      drink.image! ,
                                      fit: BoxFit.cover,
                                      width: screenWidth/2 - 20,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                                      ),
                                    ),
                                  ),
                    ); 
                  }
                },
              ),
            ),
        
            // Container(
            //   height: 200,
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(15),
            //     child: CarouselSlider(
            //       options: CarouselOptions(
            //         height: 200,
            //         viewportFraction: 1.0,
            //         autoPlay: true,
            //       ),
            //       items: drinklist.map((drink) {
            //         return Builder(
            //           builder: (BuildContext context) {
            //             return InkWell(
            //               child: Image.asset(
            //                 drink.image!,
            //                 fit: BoxFit.cover,
            //                 width: screenWidth - 20,
            //               ),
            //             );
            //           },
            //         );
            //       }).toList(),
            //     ),
            //   ),
            // ),
        
             SizedBox(height: 30,),
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
            SizedBox(height: 30,),
            Drinksdata(),
            
          ],
        ),
      ),
    );
  }
}
