import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class Profilepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushNamed('/login');
 
}
    final String uid = FirebaseAuth.instance.currentUser!.uid; 
    print("Current User UID: ${FirebaseAuth.instance.currentUser?.uid}");


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 70,
        leading: IconButton(onPressed:signOut , icon: Icon(BoxIcons.bx_log_out_circle, color: Color(0xFF00704A), )),
        title: Text("User Profile",
      style: GoogleFonts.robotoSlab(
        color: Colors.black,
        
        fontWeight: FontWeight.bold,
      ),)),

      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Users').doc(uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color:const Color(0xFF00704A) ,));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No data found for this user.'));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, size: 24),
                    SizedBox(width: 10),
                    Text("${userData['name']}", style: GoogleFonts.robotoSlab(fontSize: 16,)),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Icon(IonIcons.mail, size: 24),
                    SizedBox(width: 15),
                    Text("${userData['email']}", style: GoogleFonts.robotoSlab(fontSize: 16, )),
                  ],
                ),
                SizedBox(height: 15),
                // FilledButton(onPressed: signOut, child: Text('Sign Out')),
                InkWell(
  onTap: () {
    Navigator.pushNamed(context, '/orderhistory');
  },
  child: Row(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/orderhistory');
        },
        child: const Icon(
          Icons.history, 
          
        ),
      ),
      const SizedBox(width: 10),
      Text(
        'Order History',
        style: GoogleFonts.robotoSlab(
          
          fontSize: 16,
          
        ),
      ),
    ],
  ),
),

                
              ],
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}
