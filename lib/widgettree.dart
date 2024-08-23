import 'package:coffee/pages/auth.dart';
import 'package:coffee/pages/homepage.dart';
import 'package:coffee/pages/loginpage.dart';
import 'package:flutter/material.dart';

class Widgettree extends StatefulWidget {
  const Widgettree({super.key});

  @override
  State<Widgettree> createState() => _WidgettreeState();
}

class _WidgettreeState extends State<Widgettree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream : Auth().authStateChanges,
     builder: (context , snapshot){
      if(snapshot.hasData){
        return Homepage();
      }
      else {
        return LoginPage();
      }
     });
  }
}