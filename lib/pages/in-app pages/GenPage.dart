import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  List <Color> cl =[ Color.fromARGB(255, 63, 45, 45) ,Color.fromARGB(255, 152, 112, 112)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 184, 168),
      body: Column(
        
        children: [

          Row(
            children: [
              SizedBox(width: 10,),
              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: cl ),
                  color: Color.fromARGB(255, 63, 45, 45),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: 
                  user != null && user!.displayName != null
                    ? Text("Welcome! , ${user!.displayName}" ,
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 20-5
                    ),)
                    : const Text("nil"),
                
              ),
            ],
          ),
        ],
      )
    );
  }
}
