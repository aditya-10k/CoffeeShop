import 'package:flutter/material.dart';

class offerpage extends StatefulWidget {
  const offerpage({super.key});

  @override
  State<offerpage> createState() => _offerpageState();
}

class _offerpageState extends State<offerpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text('offer page')),
    );
  }
}