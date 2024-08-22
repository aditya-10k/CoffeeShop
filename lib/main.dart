import 'package:coffee/pages/homepage.dart';
import 'package:coffee/pages/loginpage.dart';
import 'package:coffee/pages/signup.dart';
import 'package:coffee/pages/splashs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: LoginPage(),
initialRoute:'/login' ,
      routes: {
       '/login' : (context) => LoginPage(),
       '/signup' : (context) => Signup(),
       '/splash' : (context) => Splashs(),
       '/homepage' : (context) => Homepage(),
      },
    );
  }
}