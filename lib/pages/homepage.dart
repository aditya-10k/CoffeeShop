import 'package:coffee/pages/auth.dart';
import 'package:coffee/pages/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import  'auth.dart';

class Homepage extends StatefulWidget {
   Homepage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[300],
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        
      ),
      drawer: Drawer(
        backgroundColor:Color.fromARGB(255, 63, 45, 45) ,
        child: ListView(
          children: [
            DrawerHeader(child: Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  opacity: 0.8,
                  image: AssetImage('assets/Designer (3).jpeg'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            )
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app_outlined,color: Colors.white70,),
              title: Text('Logout',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20
              ),),
              onTap: () async {
                await widget.signOut();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            )
          ],
        ),
      )
      

    );
  }
}