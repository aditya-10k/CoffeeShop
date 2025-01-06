import 'package:coffee/UserRepo.dart';
import 'package:coffee/Usermodel.dart';
import 'package:coffee/pages/auth.dart';
import 'package:coffee/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Profilepage extends StatelessWidget {
  // This is the unique identifier for the user

  final User? user = Auth().currentUser;

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
  // Optionally clear user data from other sources if needed (e.g., SharedPreferences).
 
}


  

  @override
  Widget build(BuildContext context) {

    String userId = Get.find<UserIdController>().getUserId();

    print("Fetching data for userId: $userId");

    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        leading: IconButton(onPressed: () async {
                  await signOut();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                }, icon: Icon(
                  Icons.exit_to_app_outlined, size: 40,
                  color: Color.fromARGB(255, 0, 112, 72),
                ),),),
      body: FutureBuilder<Usermodel?>(
        future: Get.find<Userrepo>().fetchid(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('User not found $userId'));
          } else {
            var user = snapshot.data!;

            
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${user.name ?? 'N/A'}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Email: ${user.email ?? 'N/A'}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),

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
                  await signOut();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
