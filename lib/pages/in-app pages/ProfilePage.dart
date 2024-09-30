import 'package:coffee/pages/auth.dart';
import 'package:coffee/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class ProfilePage extends StatefulWidget {
   ProfilePage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title:Text(
          
                    'Settings', 
                    style: GoogleFonts.robotoSlab(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color:  Colors.black,
                    )
      ),),
      body: ListView(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        children: [
          SizedBox(height: 20,),

          ListTile(
            
//SizedBox(width: 10,),
             leading:  Icon(Bootstrap.person_circle,size: 40,
              color: Color.fromARGB(255, 0, 112, 72),),
          title:     
         user != null && user!.displayName != null
            ? Text("${user!.displayName}",
            style: GoogleFonts.robotoSlab(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
            ),
            )
            :  Text("Guest",
            style: GoogleFonts.robotoSlab(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
            ),),
    
          ),
          SizedBox(height: 10,),
          ListTile(
                leading: Icon(
                  Icons.exit_to_app_outlined, size: 40,
                  color: Color.fromARGB(255, 0, 112, 72),
                ),
                title: Text(
                  'Logout',
                  style: GoogleFonts.robotoSlab(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onTap: () async {
                  await widget.signOut();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
        ]

      ),
    );
  }
}
