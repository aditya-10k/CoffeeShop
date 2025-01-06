import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/Usermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class Userrepo extends GetxController {
  static Userrepo get instance => Get.find();

  final db = FirebaseFirestore.instance;

Future<void> createuser(Usermodel user) async {
  try {
    // Add user to Firestore
    var userRef = await db.collection("Users").add(user.toJson());
    String userId = userRef.id; // Auto-generated Firestore ID
    print("Generated userId: $userId");

    // Set the userId in UserIdController
    Get.find<UserIdController>().setUserId(userId);
    print("UserIdController set userId: $userId");

    Get.snackbar(
      "Success",
      "Account created successfully! User ID: $userId",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 0, 112, 72).withOpacity(0.1),
      colorText: Colors.white,
    );
  } catch (error) {
    print("Error creating user: $error");
    Get.snackbar(
      "Error",
      error.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.1),
      colorText: Colors.white,
    );
  }
}



  Future<Usermodel?> fetchid(String userid) async {
  try {
    if (userid.isEmpty) {
      throw Exception('User ID cannot be empty');
    }
    
    print('Fetching user with id: $userid');
    DocumentSnapshot snapshot = await db.collection('Users').doc(userid).get();

    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      Usermodel user = Usermodel(
        id: snapshot.id,
        name: data["Name"],
        email: data["email"],
      );
      return user;
    } else {
      return null; // User does not exist
    }
  } catch (e) {
    print("Error: $e");
    return null;
  }
}
}

class UserIdController extends GetxController {
  var userId = ''.obs;

  void setUserId(String id) {
    userId.value = id;
    print("UserIdController set userId: $id");
  }

  String getUserId() {
    print("UserIdController get userId: ${userId.value}");
    return userId.value;
  }
}


