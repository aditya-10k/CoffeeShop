import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text("User Profile")),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Users').doc(uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
                Text("Name: ${userData['name']}", style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text("Email: ${userData['email']}", style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                MaterialButton(onPressed: signOut, child: Text('Sign Out')),
              ],
            ),
          );
        },
      ),
    );
  }
}
