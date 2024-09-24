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

  // Method to reload the user and fetch the latest info
  Future<void> _loadUser() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      await currentUser.reload(); // Reload to get the most up-to-date user info
      setState(() {
        user = _auth.currentUser; // After reload, update the user object
      });
    }
  }
  List <Color> cl =[ Colors.black /*,Color.fromARGB(255, 152, 112, 112)*/];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(mainAxisAlignment: MainAxisAlignment.center ,
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
    );
  }
}
