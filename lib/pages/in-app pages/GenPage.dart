//import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee/workingcomps/apicatcher.dart';
import 'package:coffee/workingcomps/categorys.dart';
import 'package:coffee/workingcomps/getintouch.dart';
//import 'package:coffee/workingcomps/model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
//import 'package:http/http.dart' as http;

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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          textAlign: TextAlign.center,
                      style: GoogleFonts.robotoSlab(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
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
              child: InkWell(
                onTap: (){
                          Navigator.pushNamed(context,'/drinksdata' );
                        },
                child: Container(
                  child: Row(
                    children: [
                      Text(
                        "We serve",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.robotoSlab(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Spacer(),
                      IconButton( 
                        onPressed: (){
                          Navigator.pushNamed(context,'/drinksdata' );
                        }, 
                        icon: Icon(AntDesign.arrow_right_outline,
                        color: Colors.black,))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
        
            Padding(
              
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: getdrinkapi('https://unicode-flutter-lp-new-final.onrender.com/get_all_products'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 0, 112, 72),
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
                        height: 300,
                        viewportFraction: 1.0,
                        autoPlay: true,
                      ),
                      items: drinklist.map((drink) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Container(
                                        width: screenWidth/2 - 40,
                                        child: Text(
                                                    drink.name!, 
                                                    style: GoogleFonts.robotoSlab(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 17,
                                                    )),
                                      ),
                                                  SizedBox(height: 10,),
                                                  Container(
                                                    width: screenWidth/2 - 40,
                                                    child: Text(  'Ingredients: ${drink.recipeIngredient?.join(', ') ?? 'No ingredients available'}', 
                                                    style: GoogleFonts.robotoSlab(
                                                      color: Colors.white,
                                                      //fontWeight: FontWeight.bold,
                                                      fontSize: 10,
                                                    ),
                                                    maxLines: 4,  
                                                    overflow: TextOverflow.ellipsis,
                                                    ),
                                                  )
                                                  ,
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      drink.image! ,
                                      fit: BoxFit.cover,
                                      height: 150,
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
        
           
        
             SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
              child: Row(
                children: [
                  Text(
                    "What would you like?",
                    textAlign: TextAlign.right,
                    style: GoogleFonts.robotoSlab(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Spacer(),

                ],
              ),
            ),
            SizedBox(height: 20,),
           // Drinksdata(),

           Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 0, 112, 72),
            ),
             child: Wrap(
              //spacing: 10,
              //runSpacing: 10,
              alignment: WrapAlignment.center,
                     children: categories.map((category) {
                       return SizedBox(
                        width: 80,
                        height: 80,
                         child: Card(
                                     color: Color.fromARGB(255, 0, 112, 72),
                                     margin: EdgeInsets.all(5),
                                     elevation: 5,
                                     child: GestureDetector(
                                       onTap: () => category.onTouch(context),
                                       child: ClipRRect(
                                                               borderRadius: BorderRadius.circular(10),
                                                               child: Image.network(
                                                                 category.image,
                                                                 height: 60, 
                                                                 width: 60,
                                                                 fit: BoxFit.cover,
                                                               ),
                                       ),
                                     ),
                         ),
                       );
                     }).toList(),
                   ),
           ),

            // SizedBox(height: 30,),

            // Text(
            //     "Get in touch",
            //     textAlign: TextAlign.left,
            //     style: GoogleFonts.robotoSlab(
            //       color: Colors.black,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 25,
            //     ),
            //   ),

              SizedBox(height: 30,),

              Getintouch()

            
          ],
        ),
      ),
    );
  }
}
