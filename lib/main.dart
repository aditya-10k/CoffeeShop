import 'package:coffee/firebase_options.dart';
import 'package:coffee/pages/homepage.dart';
import 'package:coffee/pages/loginpage.dart';
import 'package:coffee/pages/signup.dart';
import 'package:coffee/pages/splashs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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