import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Sign-in method with email and password
   Future<User?> signInWithEmailAndPassword({
    required String mail,
    required String psk,
  }) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: mail, password: psk);
    return credential.user; // This should return the authenticated user
  }

  // Create user method with email and password
  Future<UserCredential> createUserWithEmailAndPassword({
    required String mail,
    required String psk,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(email: mail, password: psk);
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail({
    required String mail,
  }) async {
    await _firebaseAuth.sendPasswordResetEmail(email: mail);
  }

  // Sign out method
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
