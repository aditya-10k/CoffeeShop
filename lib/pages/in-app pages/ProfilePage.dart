import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: user != null && user!.displayName != null
            ? Text("Welcome! , ${user!.displayName}")
            : const Text("No user is signed in or name not available"),
      ),
    );
  }
}
