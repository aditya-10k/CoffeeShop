import 'package:coffee/firebase_options.dart';
import 'package:coffee/pages/forgotpass.dart';
import 'package:coffee/pages/homepage.dart';
import 'package:coffee/pages/in-app%20pages/MenuPage.dart';
import 'package:coffee/pages/loginpage.dart';
import 'package:coffee/pages/signup.dart';
import 'package:coffee/pages/splashs.dart';
import 'package:coffee/widgettree.dart';
import 'package:coffee/workingcomps/cartfunc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Future<void> main() async {

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
    return ChangeNotifierProvider(
      create: (context) => Cartfunc(),
      builder: (context,child) =>MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: const Widgettree(),
initialRoute:'/splash' ,
      routes: {

       '/forgotpass' : (context) => ForgotPass(),
       '/login' : (context) => LoginPage(),
       '/signup' : (context) => Signup(),
       '/splash' : (context) => Splashs(),
       '/homepage' : (context) => Homepage(),
       '/menu' : (context) => Menupage(),
      },
      )
    );
  }
}